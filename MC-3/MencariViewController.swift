import Foundation
import UIKit
import AVFoundation
import CoreAudio

class MencariViewController: UIViewController {

    var recorder: AVAudioRecorder!
    var levelTimer = Timer()

    let LEVEL_THRESHOLD: Float = -10.0

    override func viewDidLoad() {
        super.viewDidLoad()

        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        let url = documents.appendingPathComponent("record.caf")

        let recordSettings: [String: Any] = [
            AVFormatIDKey:              kAudioFormatAppleIMA4,
            AVSampleRateKey:            44100.0,
            AVNumberOfChannelsKey:      2,
            AVEncoderBitRateKey:        12800,
            AVLinearPCMBitDepthKey:     16,
            AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
        ]

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url, settings: recordSettings)

        } catch {
            return
        }

        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()

        levelTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)

    }

    @objc func levelTimerCallback() {
        recorder.updateMeters()

        let level = recorder.averagePower(forChannel: 0)
        let isLoud = level > LEVEL_THRESHOLD
        
        if isLoud == true {
            print("true")
            let path = getDocumentsDirectory().appendingPathComponent("Recording.m4a")
            //The file recorded has been deleted
            //But the file saved is not deleted
            do {
            try FileManager.default.removeItem(at: path)
            } catch {
                print("error removing audio")
            }
            
        } else {
          
        }

        // do whatever you want with isLoud
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getDocumentsDirectory() -> URL {
              let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
              return paths[0]
          }


}
