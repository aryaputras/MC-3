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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func playTapped(_ sender: Any) {
        //  getDocumentsDirectory()
        preparePlayer()
        avPlayer.play()
        //
        
        
        
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
        print(senderGender)
        
        
        
        
        //bikin jd if genderpreference==0 {func a} else {funcb}
        let query = CKQuery(recordType: "perahuKertas", predicate: predicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "sendingDate", ascending: true)]
        
        
        //get message
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inbox = fetchedRecords
                DispatchQueue.main.async {
                    
                    
                    
                    let message = self.inbox[0].object(forKey: "message")
                    let senderID = self.inbox[0].object(forKey: "creatorID")
                    self.getSenderID(sender: senderID as! String)
                    
                    self.messageLabel.text = message as! String
                    
                    
                    let audioRecord = self.inbox[0].object(forKey: "audio")
                    
                    self.audio = audioRecord as? CKAsset
                    
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
                        print("error with gender")
                        
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
        
        
        
        
        
        //bikin jd if genderpreference==0 {func a} else {funcb}
        let query = CKQuery(recordType: "perahuKertas", predicate: predicate)
        
        query.sortDescriptors = [NSSortDescriptor(key: "sendingDate", ascending: true)]
        
        
        //get message
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inbox = fetchedRecords
                DispatchQueue.main.async {
                    
                    
                    
                    let message = self.inbox[0].object(forKey: "message")
                    let senderID = self.inbox[0].object(forKey: "creatorID")
                    self.getSenderID(sender: senderID as! String)
                    
                    self.messageLabel.text = message as! String
                    
                    let audioRecord = self.inbox[0].object(forKey: "audio")
                    
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
                        print("error without gender")
                        
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
        destinationVC.senderID = self.inbox[0].recordID.recordName as! String
        
        
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



