//
//  RiwayatReplyViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class RiwayatReplyViewController: UIViewController, AVAudioPlayerDelegate{
    var recordName = ""
    var inbox = [CKRecord]()
    var message = ""
    var originRecordID: CKRecord.ID?
    var senderImage: UIImage?
    var replyImage: UIImage?
    var replyImageAsset: CKAsset?
    var replyImageURL: NSURL?
    var replyImagePath: URL?
    
    //audio capabilities
    var audio: CKAsset?
    var audioPlayerItem: AVPlayerItem?
    var avPlayer = AVAudioPlayer()
    var audioURL: NSURL?
    var audioAsset: AVAsset?
    var audioPath: URL?
    var date: String?
    
    var audioOriginPath: URL?
    
    
    @IBOutlet weak var avatarSenderView: UIImageView!
    @IBOutlet weak var riwayatReplyCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyCounter: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        //print(recordName)
        // print(originRecordID)
        //query the original record
        
        senderImageView.image = senderImage
        dateLabel.text = date ?? ""
        messageLabel.text = message
        riwayatReplyCollectionView.register(RiwayatReplyCollectionViewCell.nib(), forCellWithReuseIdentifier: "RiwayatReplyCollectionViewCell")
        riwayatReplyCollectionView.delegate = self
        riwayatReplyCollectionView.dataSource = self
        let database = CKContainer.default().publicCloudDatabase
        let recordIDName = recordName
        let predicate = NSPredicate(format: "originID == '\(recordName)'")
        
        let predicateAll = NSPredicate(value: true)
        let query = CKQuery(recordType: "perahuKertasReply", predicate: predicate)
        
        //query.sortDescriptors = [NSSortDescriptor(key: "replyDate", ascending: false)]
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                self.inbox = fetchedRecords
                print(self.inbox)
                DispatchQueue.main.async {
                    //code
                    //print(self.inbox)
                    self.replyCounter.text = "\(self.inbox.count)"
                    
                    self.riwayatReplyCollectionView.reloadData()
                }
            }
            
        }
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
            }
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "creatorID == %@", userID?.recordName ?? "")
            let query = CKQuery(recordType: "profile", predicate: predicate)
            query.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
            database.perform(query, inZoneWith: nil) { (records, error) in
                if let fetchedRecords = records {
                    DispatchQueue.main.async {
                       
                        self.usernameLabel.text = fetchedRecords[0].object(forKey: "username") as! String
                        let avatarImage = fetchedRecords[0].object(forKey: "avatar")
                        self.avatarSenderView.image = UIImage(named: avatarImage as! String)
                        
                        
                    }
                
                }
            }
        }
        
    }
    
    @IBAction func playButton(_ sender: Any) {
        preparePlayer()
        avPlayer.play()
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
    }
}
extension RiwayatReplyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //barang di collectionnya biasa pake counter
        return self.inbox.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatReplyCollectionViewCell", for: indexPath) as! RiwayatReplyCollectionViewCell
        
        let record = inbox[indexPath.row]
        //print(inbox)
        cell.replyLabel.text = record.object(forKey: "reply") as? String
        cell.usernameLabel.text = record.object(forKey: "replyNickname") as? String
        
        
        
        
        
        
        
        
        //EXPERIMENTAL DOWNLOADING IMAGE
        let imgRecord = record.object(forKey: "image")
        self.replyImageAsset =  imgRecord as? CKAsset
        do {
            self.replyImageURL = self.replyImageAsset?.fileURL as NSURL?
            
            var imageData = try Data(contentsOf: (self.replyImageURL ?? NSURL()) as URL)
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("ReceivedImage.jpg", isDirectory: false)
            FileManager.default.createFile(atPath: destinationPath!.path, contents: imageData, attributes: nil)
            do {
                let imgNewData = try Data(contentsOf: destinationPath!)
                print("download image succeed")
                
                
                //self.imagePath = destinationPath!
                self.replyImage = UIImage(data: imgNewData)
                //print("do do ")
            } catch {print("bgst") }
            
            let audioRecord = record.object(forKey: "audio")
            
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
                //print(destinationPath!)
                self.audioPath = destinationPath!
                
                
                
                
                
            } catch {
                print("error download audio with gender")
                
            }
            
        } catch {
            print("error download picture with gender")
        }
        
        let date = record.creationDate
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        //print(formatter1.string(from: date!))
        cell.imageView.image = replyImage
        cell.dateLabel.text = formatter1.string(from: date!)
        //print(formatter1.string(from: date!))
        // buat masukin isinya dari mana
        //        let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        let avatar = record.object(forKey: "Avatar") as! String
        
        cell.avatarImage.image = UIImage(named: avatar ?? "Avatar 1")
        return cell
    }
    func preparePlayer() {
        let path = getDocumentsDirectory().appendingPathComponent("ReceivedAudio.m4a")
        do {
            
            avPlayer = try AVAudioPlayer(contentsOf: audioOriginPath!)
            avPlayer.delegate = self
            avPlayer.prepareToPlay()
            avPlayer.volume = 100
            //print(path)
        } catch {
            print("error1")
        }
    }
    func getDocumentsDirectory() -> URL {
        var paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        return paths[0]
    }
    
    
    
}
