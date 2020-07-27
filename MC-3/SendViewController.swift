//
//  ViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 17/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class SendViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var age = 0
    var gender = 0
    var profile = [CKRecord]()
    
    //recording capabilities
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var filename = "Recording.m4a"
    var soundPlayer = AVAudioPlayer()
    var recorded = false
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var record1Label: UILabel!
    @IBOutlet weak var record2Label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sliderSize: UISlider!
    @IBOutlet weak var canvasView: canvasView!
    @IBOutlet weak var sliderImage: UIImageView!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var softPinkButton: UIButton!
    @IBOutlet weak var darkPinkButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recording
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        //self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        
        
        initializeHideKeyboard()
        sliderSize.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        recordButton.isHidden = false
        drawButton.isHidden = false
        sliderSize.isHidden = true
        sliderImage.isHidden = true
        canvasView.isHidden = true
        whiteButton.isHidden = true
        blackButton.isHidden = true
        blueButton.isHidden = true
        greenButton.isHidden = true
        yellowButton.isHidden = true
        orangeButton.isHidden = true
        softPinkButton.isHidden = true
        darkPinkButton.isHidden = true
        purpleButton.isHidden = true
        textField.isHidden = false
        record1Label.isHidden = true
        record2Label.isHidden = true
        recordingButton.isHidden = true
        
        initializeHideKeyboard()
        textField.delegate = self
        textFieldShouldReturn(textField)
        
        //fetching age
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                let database = CKContainer.default().publicCloudDatabase
                
                let predicate = NSPredicate(format: "creatorID == %@", userID.recordName)
                let queryProfile = CKQuery(recordType: "profile", predicate: predicate)
                queryProfile.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
                
                database.perform(queryProfile, inZoneWith: nil) { (records, error) in
                    if let fetchedRecords = records {
                        self.profile = fetchedRecords
                        DispatchQueue.main.async {
                            //get sender age
                            self.age = self.profile[0].object(forKey: "age") as! Int
                            
                            
                            
                            //get sender gender
                            self.gender = self.profile[0].object(forKey: "gender") as! Int
                            
                            
                            
                            
                        }
                        
                    }
                }
                
                
            }
            
        }
        
        
    }
    
    @IBAction func recordingButton(_ sender: Any) {
        startRecording()
        
    }
    @IBAction func stopRecordingButton(_ sender: Any) {
        finishRecording(success: true)
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        preparePlayer()
        soundPlayer.play()
    }
    @IBAction func recordButton(_ sender: Any) {
        recordButton.isHidden = true
        drawButton.isHidden = true
        sliderSize.isHidden = true
        sliderImage.isHidden = true
        canvasView.isHidden = true
        whiteButton.isHidden = true
        blackButton.isHidden = true
        blueButton.isHidden = true
        greenButton.isHidden = true
        yellowButton.isHidden = true
        orangeButton.isHidden = true
        softPinkButton.isHidden = true
        darkPinkButton.isHidden = true
        purpleButton.isHidden = true
        deleteButton.setTitle("Urungkan", for: .normal)
        textField.isHidden = true
        record1Label.isHidden = false
        record2Label.isHidden = false
        recordingButton.isHidden = false
        
        
        //IN START RECORDING, CHANGELABEL
        
        
        
        
    }
    
    @IBAction func drawButton(_ sender: Any) {
        recordButton.isHidden = true
        drawButton.isHidden = true
        sliderSize.isHidden = false
        sliderImage.isHidden = false
        canvasView.isHidden = false
        whiteButton.isHidden = false
        blackButton.isHidden = false
        blueButton.isHidden = false
        greenButton.isHidden = false
        yellowButton.isHidden = false
        orangeButton.isHidden = false
        softPinkButton.isHidden = false
        darkPinkButton.isHidden = false
        purpleButton.isHidden = false
        textField.isHidden = true
        record1Label.isHidden = true
        record2Label.isHidden = true
        recordingButton.isHidden = true
    }
    
    
    @IBAction func whiteButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    @IBAction func blackButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    @IBAction func blueButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.2532024682, green: 0.812871635, blue: 0.9448824525, alpha: 1)
    }
    @IBAction func greenButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0, green: 0.7813302875, blue: 0, alpha: 1)
    }
    @IBAction func yellowButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0.8500413299, blue: 0, alpha: 1)
    }
    @IBAction func orangeButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0.5840916038, blue: 0, alpha: 1)
    }
    @IBAction func softPinkButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.9786210656, green: 0.4592483044, blue: 0.9287266135, alpha: 1)
    }
    @IBAction func darkPinkButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0.525508225, alpha: 1)
    }
    @IBAction func purpleButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.5280317664, green: 0.1064086631, blue: 0.7941021323, alpha: 1)
    }
    
    @IBAction func sliderSize(_ sender: UISlider) {
        canvasView.strokeWidth = CGFloat(sender.value)
    }
    //fetching age
    
    
    @IBAction func doneAction(_ sender: Any) {
        
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
                //save image
                let image = self.canvasView.savePic()
                  let imgPath = self.getDocumentsDirectory().appendingPathComponent("image.jpg")
                
                //createfile
                do {
              
                
                    try image.pngData()?.write(to: imgPath, options: .atomic) } catch { print("saving image error")}
                
                let creatorID = userID.recordName as CKRecordValue
                let date = Date() as CKRecordValue
                let story = self.textField.text! as CKRecordValue
                //let audio =
                
                let ageRecord = self.age as CKRecordValue
                let genderRecord = self.gender as CKRecordValue
                let newRecord = CKRecord(recordType: "perahuKertas")
                let database = CKContainer.default().publicCloudDatabase
              //  let image = self.canvasView.savePic()
                let imageRecord = CKAsset(fileURL: imgPath) as CKRecordValue
                
                if self.recorded == true {
                    let path = self.getDocumentsDirectory().appendingPathComponent(self.filename)
                    let audio =  CKAsset(fileURL: path) as CKRecordValue
                    //let imageRecord = CKAsset(fileURL: imgp)
                    newRecord.setValue(audio, forKey: "audio")
                }
                 newRecord.setValue(imageRecord, forKey: "image")
                newRecord.setObject(genderRecord, forKey: "senderGender")
                newRecord.setObject(ageRecord, forKey: "senderAge")
                newRecord.setObject(story, forKey: "message")
                newRecord.setObject(creatorID, forKey: "creatorID")
                newRecord.setObject(date, forKey: "sendingDate")
                
                database.save(newRecord) { record , error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print(error.localizedDescription)
                            
                        } else {
                            
                            print("record was saved")
                            
                            self.performSegue(withIdentifier: "sendToBlow", sender: Any?.self)
                            
                        }
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    @IBAction func hapusButton(_ sender: Any) {
        if canvasView.isHidden == false {
            canvasView.clearDraw()
        }
    }
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(filename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 48000,
            AVNumberOfChannelsKey: 1,
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
        recorded = true
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    
    
    //       @objc func recordTapped() {
    //           if audioRecorder == nil {
    //               startRecording()
    //           } else {
    //               finishRecording(success: true)
    //           }
    //       }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
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
}
//    //UNTUK EXPORT GAMBAR

extension UIView{
    func savePic() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil{
            return image!
        }
        return UIImage()
    }
    
    
    
    //pasang ini untuk let gambar nya
    
    
}
