import Foundation
import UIKit
import AVFoundation
import CoreAudio

class MencariViewController: UIViewController {
    
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    var labelAtasText = "Apakah kamu sudah siap menghanyutkan bebanmu?"
    let LEVEL_THRESHOLD: Float = -12.0
    @IBOutlet weak var orangeBackground: UIImageView!
    @IBOutlet weak var paperBoat: UIImageView!
    @IBOutlet weak var tideBackground: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelAtas: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelAtas.text = labelAtasText
        self.navigationController?.navigationBar.isHidden = true
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
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
    }
    
    
    @objc func levelTimerCallback() {
        recorder.updateMeters()
        
        let level = recorder.averagePower(forChannel: 0)
        let isLoud = level > LEVEL_THRESHOLD
        
        if isLoud == true {
            print("true")
            animate()
            
            let path = getDocumentsDirectory().appendingPathComponent("Recording.m4a")
            
            //The file recorded has been deleted
            //But the file saved is not deleted
            do {
                
                try FileManager.default.removeItem(at: path)
            } catch {
                print("error removing audio/audio has been removed")
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
    
    func animate() {
        
        UIView.animate(withDuration: 10, animations: {
            self.orangeBackground.transform = CGAffineTransform(translationX: 0, y: 415)
            self.tideBackground.transform = CGAffineTransform(translationX: 0, y: 415)
            self.paperBoat.transform = CGAffineTransform(translationX: 0, y: -300)
            self.paperBoat.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.label.isHidden = true
            self.labelAtas.isHidden = true
        }) { (finished) in
                    self.performSegue(withIdentifier: "blowToHome", sender: self)
            self.recorder.stop()
        }
    }
}
