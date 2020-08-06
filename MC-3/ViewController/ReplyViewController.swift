//
//  ReplyViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class ReplyViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var senderID = ""
    var username = ""
    var message = ""
    var myUsername = ""
    var originID = ""
    var imgMessage: UIImage?
    var recordButtonImage:String = "Mic_Thin"
    
    //recording capabilities
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var filename = "Recording.m4a"
    var soundPlayer = AVAudioPlayer()
    var recorded = false
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    //RECONNECT OUTLET
    @IBOutlet weak var sliderSize: UISlider!
    @IBOutlet weak var sliderimage: UIImageView!
    @IBOutlet weak var canvasView: canvasView!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var softPinkButton: UIButton!
    @IBOutlet weak var darkPinkButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    @IBOutlet weak var playRecordButton: UIButton!
    @IBOutlet weak var record1Label: UILabel!
    @IBOutlet weak var record2Label: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    
    @IBOutlet weak var selesaiButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    
    @IBOutlet weak var isiTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //recordingsession
        imageView.image = imgMessage
        usernameLabel.text = username
        messageLabel.text = message
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
        
        self.navigationController?.navigationBar.isHidden = true
        print(senderID, username, message)
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                
                
                let database = CKContainer.default().publicCloudDatabase
                
                let predicate = NSPredicate(format: "creatorID == %@", userID.recordName)
                
                let query = CKQuery(recordType: "profile", predicate: predicate)
                
                query.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
                
                database.perform(query, inZoneWith: nil) { (records, error) in
                    if let fetchedRecords = records {
                        DispatchQueue.main.async {
                            print(records![0])
                            
                            
                            self.myUsername = records![0].object(forKey: "username") as! String
                            print(self.myUsername)
                        }
                    }
                }
            }
        }
        
        //MAKE REPLY
        
        
        sliderSize.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        recordButton.isHidden = false
        drawButton.isHidden = false
        sliderSize.isHidden = true
        sliderimage.isHidden = true
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
        isiTextField.isHidden = false
        record1Label.isHidden = true
        record2Label.isHidden = true
        recordingButton.isHidden = true
        playRecordButton.isHidden = true
        
        initializeHideKeyboard()
        isiTextField.delegate = self
        textFieldShouldReturn(isiTextField)
        
    }
    
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){

    }
    
    @IBAction func recordButton(_ sender: Any) {
        isiTextField.text = ""
        recordButton.isHidden = true
        drawButton.isHidden = true
        sliderSize.isHidden = true
        sliderimage.isHidden = true
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
        isiTextField.isHidden = true
        record1Label.isHidden = false
        record2Label.isHidden = false
        recordingButton.isHidden = false
        playRecordButton.isHidden = false
    }
    
    @IBAction func drawButton(_ sender: Any) {
        isiTextField.text = ""          
        recordButton.isHidden = true
        drawButton.isHidden = true
        sliderSize.isHidden = false
        sliderimage.isHidden = false
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
        isiTextField.isHidden = true
        record1Label.isHidden = true
        record2Label.isHidden = true
        recordingButton.isHidden = true
        playRecordButton.isHidden = true
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
    @IBAction func deleteButton(_ sender: UIButton!) {
    if canvasView.isHidden == false {
        canvasView.clearDraw()
    }
    }
    @IBAction func startRecord(_ sender: Any) {
        if(recordButtonImage == "Mic_Thin"){
            startRecording()
            recordButtonImage = "Mic_Thick"
            recordingButton.setImage(UIImage(named: recordButtonImage),for: .normal)
        }
        else if(recordButtonImage == "Mic_Thick"){
            finishRecording(success: true)
            recordButtonImage = "Mic_Thin"
            recordingButton.setImage(UIImage(named: recordButtonImage), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! MencariViewController
        
        destinationVC.labelAtas.text = "Apakah kamu sudah siap menghanyutkan balasanmu?"
    }
    
    @IBAction func selesaiTapped(_ sender: UIButton) {
        sender.isHidden = true
        selesaiButton.isHidden = true
        let reply = isiTextField.text as! CKRecordValue
        let replyNickname = myUsername as CKRecordValue
        let originID = senderID as CKRecordValue
        let image = self.canvasView.savePic2()
        let imgPath = self.getDocumentsDirectory().appendingPathComponent("image.jpg")
        
        do {
            try image.pngData()?.write(to: imgPath, options: .atomic) } catch { print("saving image error")
        }
        
        let imageRecord = CKAsset(fileURL: imgPath) as CKRecordValue
        let database = CKContainer.default().publicCloudDatabase
        let newRecord = CKRecord(recordType: "perahuKertasReply")
        //HARUSNYA INI RECORDNAME DARI SENDERNYA
        if self.recorded == true {
                          let path = self.getDocumentsDirectory().appendingPathComponent(self.filename)
                          let audio =  CKAsset(fileURL: path) as CKRecordValue
                          //let imageRecord = CKAsset(fileURL: imgp)
                          newRecord.setValue(audio, forKey: "audio")
                      }
        newRecord.setValue(imageRecord, forKey: "image")
//ADD NEWRECORD AUDIO CAPABILITIES
        newRecord.setObject(reply, forKey: "reply")
        newRecord.setObject(replyNickname, forKey: "replyNickname")
        newRecord.setObject(originID, forKey: "originID")
        database.save(newRecord) { (records, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("error")
                } else {
                    print("record was saved")
                }
            }
        }
        
    }
    @IBAction func startPlay(_ sender: Any) {
        preparePlayer()
        soundPlayer.play()
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
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
}
extension UIView{
    func savePic2() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil{
            return image!
        }
        return UIImage()
    }
    
}
