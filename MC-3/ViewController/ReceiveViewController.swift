//
//  ReceiveViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 20/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class ReceiveViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var inbox = [CKRecord]()
    var inboxProfile = [CKRecord]()
    var agePreferenceMin = 0
    var agePreferenceMax = 0
    var genderPreference = 0
    var senderAge = 0
    var userID = ""
    var inboxMyProfile = [CKRecord]()
    var senderGender = 0
    var audio: CKAsset?
    var audioPlayerItem: AVPlayerItem?
    var avPlayer = AVAudioPlayer()
    var audioURL: NSURL?
    var audioAsset: AVAsset?
    var audioPath: URL?
    var image: CKAsset?
    var imageURL: NSURL?
    var imagePath: URL?
    var numIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        //AUDIOSHIT
        //get user ID
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID.recordName)
                self.userID = userID.recordName as! String
                self.getMyID { (ageMax, ageMin, arrOfGender) in
                    //SHOULD RETURN xx,xx WHICH IS ACTUAL THE PROFILE AGEPREFERENCE.
                    // print(self.agePreferenceMin, self.agePreferenceMax)
                    //let predicate = NSPredicate(value: true)
                    
                    //   print(self.genderPreference)
                    //GENDER ERROR
                    //PAKE INI AJA: IF GENDER PREFERENCE = 0, pake predicate yg age aja,jadi semua gender masuk, jika gender preference ada, (1/2) maka pakai predicate yg cuma detect sendergender == preference.
                    if self.genderPreference == 0 {
                        self.withoutGenderReference()
                    } else {
                        self.withGenderReference()
                    }
                }
            }
        }
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
    }
    @IBAction func playTapped(_ sender: Any) {
        //  getDocumentsDirectory()
        preparePlayer()
        avPlayer.play()
    }
    
    func preparePlayer() {
        let path = getDocumentsDirectory().appendingPathComponent("ReceivedAudio.m4a")
        do {
            
            avPlayer = try AVAudioPlayer(contentsOf: path)
            avPlayer.delegate = self
            avPlayer.prepareToPlay()
            avPlayer.volume = 100
            print(path)
        } catch {
            print("error1")
        }
    }
    func getDocumentsDirectory() -> URL {
        var paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        return paths[0]
    }
    func withGenderReference() {
        let database = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(format: "senderAge BETWEEN {\(self.agePreferenceMin), \(self.agePreferenceMax)} AND senderGender = \(self.genderPreference)")
        print("withgenderpreference")
        
        
        
        
        //bikin jd if genderpreference==0 {func a} else {funcb}
        let query = CKQuery(recordType: "perahuKertas", predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "sendingDate", ascending: true)]
        
        
        //get message
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inbox = fetchedRecords
               
                                   
                DispatchQueue.main.async {
                    print(self.inbox)
                     let count = self.inbox.count
                                       let random = Int.random(in: 0..<count)
                    self.numIndex = random
                   
                    let message = self.inbox[random].object(forKey: "message")
                    let senderID = self.inbox[random].object(forKey: "creatorID")
                    self.getSenderID(sender: senderID as! String)
                    
                    self.messageLabel.text = message as! String
                    
                    
                    let audioRecord = self.inbox[random].object(forKey: "audio")
                    
                    self.audio = audioRecord as? CKAsset
                    
                    do {
                        self.audioURL = self.audio?.fileURL as NSURL?
                        
                        
                        //downloadaudio
                        let audioData = try Data(contentsOf: (self.audioURL ?? NSURL()) as URL)
                        print(audioData)
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("ReceivedAudio.m4a", isDirectory: false)
                        FileManager.default.createFile(atPath: destinationPath!.path, contents:audioData, attributes:nil)
                        print("download audio succeed")
                        //  paths = documentsPath
                        print(destinationPath!)
                        self.audioPath = destinationPath!
                        
                        
                        
                        
                        
                    } catch {
                        print("error download audio with gender")
                        
                    }
                    
                    let imgRecord = self.inbox[random].object(forKey: "image")
                    self.image = imgRecord as? CKAsset
                    
                    
                    do {
                        self.imageURL = self.image?.fileURL as NSURL?
                        
                        var imageData = try Data(contentsOf: (self.imageURL ?? NSURL()) as URL)
                        
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("ReceivedImage.jpg", isDirectory: false)
                        FileManager.default.createFile(atPath: destinationPath!.path, contents: imageData, attributes: nil)
                        do {
                            let imgNewData = try Data(contentsOf: destinationPath!)
                            print("download image succeed")
                            
                            
                            //self.imagePath = destinationPath!
                            self.imageView.image = UIImage(data: imgNewData)
                            print("do do ")
                        } catch {print("bgst") }
                        
                    } catch {
                        print("error download picture with gender")
                    }
                    //add senderID to field in my record when replying
                    
                    
                    //RETURN ZERO
                    
                    
                    
                    
                }
                
                
                
                
            }
        }
    }
    func withoutGenderReference() {
        let database = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(format: "senderAge BETWEEN {\(self.agePreferenceMin), \(self.agePreferenceMax)}")
        
        print("without gender preference")
        
        
        
        //bikin jd if genderpreference==0 {func a} else {funcb}
        let query = CKQuery(recordType: "perahuKertas", predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "sendingDate", ascending: true)]
        
        
        //get message
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inbox = fetchedRecords
                DispatchQueue.main.async {
                    let count = self.inbox.count
                    let random = Int.random(in: 0..<count)
                    self.numIndex = random
                   
                    let message = self.inbox[random].object(forKey: "message")
                   let senderID = self.inbox[random].object(forKey: "creatorID")
                    self.getSenderID(sender: senderID as! String)
                    
                    self.messageLabel.text = message as! String
                    
                    let audioRecord = self.inbox[random].object(forKey: "audio")
                    
                    self.audio = audioRecord as? CKAsset
                    //add senderID to field in my record when replying
                    
                    do {
                        self.audioURL = self.audio?.fileURL as NSURL?
                        
                        
                        //downloadaudio
                        let audioData = try Data(contentsOf: (self.audioURL ?? NSURL()) as URL)
                        print(audioData)
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("ReceivedAudio.m4a", isDirectory: false)
                        FileManager.default.createFile(atPath: destinationPath!.path, contents:audioData, attributes:nil)
                        print("download succeed")
                        //  paths = documentsPath
                        print(destinationPath!)
                        self.audioPath = destinationPath!
                        
                    } catch {
                        print("error audio without gender")
                        
                    }
                    
                    
                    let imgRecord = self.inbox[random].object(forKey: "image")
                    self.image = imgRecord as? CKAsset
                    
                    
                    do {
                        self.imageURL = self.image?.fileURL as NSURL?
                        
                        var imageData = try Data(contentsOf: (self.imageURL ?? NSURL()) as URL)
                        
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                        let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("ReceivedImage.jpg", isDirectory: false)
                        FileManager.default.createFile(atPath: destinationPath!.path, contents: imageData, attributes: nil)
                        do {
                            let imgNewData = try Data(contentsOf: destinationPath!)
                        print("download image succeed")
                        
                        
                        //self.imagePath = destinationPath!
                        self.imageView.image = UIImage(data: imgNewData)
                        print("do do ")
                        } catch {print("bgst") }
                        
                    } catch {
                        print("error download picture with gender")
                    }
                    //RETURN ZERO
                    
                    
                    
                    
                }
                
                
                
                
            }
        }
    }
    func getMyID(completion: @escaping ( _ ageMax: Int,  _ ageMin: Int, _ genderPref: Int) -> Void){
        
        
        let database = CKContainer.default().publicCloudDatabase
        let user = self.userID
        let predicate = NSPredicate(format: "creatorID == %@", user)
        let queryMyProfile = CKQuery(recordType: "profile", predicate: predicate)
        queryMyProfile.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
        
        database.perform(queryMyProfile, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inboxMyProfile = fetchedRecords
                DispatchQueue.main.async {
                    
                    self.agePreferenceMin = self.inboxMyProfile[0].object(forKey: "agePreferenceMin") as! Int
                    self.agePreferenceMax = self.inboxMyProfile[0].object(forKey: "agePreferenceMax") as! Int
                    self.genderPreference = self.inboxMyProfile[0].object(forKey: "genderPreference") as! Int
                    
                    
                    
                    //print(self.agePreferenceMin, self.agePreferenceMax)
                    completion(self.agePreferenceMax, self.agePreferenceMin, self.genderPreference)
                }
                
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ReplyViewController
        
        destinationVC.message = messageLabel.text!
        destinationVC.username = usernameLabel.text!
        destinationVC.senderID = self.inbox[numIndex].recordID.recordName as! String
        destinationVC.imgMessage = imageView.image
        
    }
    func getSenderID(sender: String) {
        
        
        let database = CKContainer.default().publicCloudDatabase
        
        let predicate = NSPredicate(format: "creatorID == %@", sender)
        let queryProfile = CKQuery(recordType: "profile", predicate: predicate)
        queryProfile.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
        
        database.perform(queryProfile, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inboxProfile = fetchedRecords
                DispatchQueue.main.async {
                    let username = self.inboxProfile[0].object(forKey: "username")
                    //print(username)
                    self.usernameLabel.text = username as! String
                    
                    
                    //get sender age
                    
                    //                    let senderAge_ = self.inboxProfile[0].object(forKey: "age")
                    //                    self.senderAge = senderAge_ as! Int
                    //
                    //
                    //                    self.senderGender = self.inboxProfile[0].object(forKey: "gender") as! Int
                    //                    print(self.senderGender)
                    
                    //print(self.senderAge)
                }
                
            }
        }
    }
}

// Do any additional setup after loading the view.



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



