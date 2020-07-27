//
//  MICDELETELATERViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 20/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import AVFoundation

class MICDELETELATERViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var filename = "Recording.m4a"
    var soundPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        



        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playTapped(_ sender: UIButton) {
        preparePlayer()
        soundPlayer.play()
    }
    
    func preparePlayer(){
        var error: NSError?
         let path = getDocumentsDirectory().appendingPathComponent(filename)
        do {
        soundPlayer = try AVAudioPlayer(contentsOf: path)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 100
            
        } catch {
            print(error)
        }
        
        
    }
    
    func loadRecordingUI() {
        recordButton = UIButton(frame: CGRect(x: 160, y: 400, width: 128, height: 64))
        recordButton.setTitle("RECORD", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(filename)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderBitRateKey: 320000,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
        
       
        
    }
  
        
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    
    
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }

    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
