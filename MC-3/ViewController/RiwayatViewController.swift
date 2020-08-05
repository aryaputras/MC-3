//
//  RiwayatViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class RiwayatViewController: UIViewController{
    var inboxRecord = [CKRecord]()
    var recordName = ""
    var message = ""
    var originRecordID: CKRecord.ID?
    var image: UIImage?
    var imageAsset: CKAsset?
    var imageURL: NSURL?
    var imagePath: URL?
    
    var audio: CKAsset?
    var audioPlayerItem: AVPlayerItem?
    var avPlayer = AVAudioPlayer()
    var audioURL: NSURL?
    var audioAsset: AVAsset?
    var audioPath: URL?
    var date: String?
    var replyCountRecord = ""
    
    @IBOutlet weak var riwayatCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        riwayatCollectionView.register(RiwayatCollectionCell.nib(),forCellWithReuseIdentifier: "RiwayatCollectionCell")
        riwayatCollectionView.delegate = self
        riwayatCollectionView.dataSource = self
        let database = CKContainer.default().publicCloudDatabase
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
            }
            //GETTING USER'S MESSAGES THAT GO OUT
            //let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "creatorID == %@", userID?.recordName ?? "")
            let query = CKQuery(recordType: "perahuKertas", predicate: predicate)
            
            query.sortDescriptors = [NSSortDescriptor(key: "sendingDate", ascending: false)]
            
            database.perform(query, inZoneWith: nil) { (records, error) in
                if let fetchedRecords = records {
                    self.inboxRecord = records!
                    DispatchQueue.main.async {
                        
                        
                        
                        self.riwayatCollectionView.reloadData()
                        
                        //PRINT MESSAGE
                        
                        //print(records![0].object(forkey: "message")
                    }
                }
            }
        }
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
    }
}

extension RiwayatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //barang di collectionnya biasa pake counter
        return self.inboxRecord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatCollectionCell", for: indexPath) as! RiwayatCollectionCell
        // buat masukin isinya dari mana
        if let record = inboxRecord[indexPath.row] as? CKRecord {
            //print(inbox)
            //        cell.imageView.image = item.imageName
            
            cell.suratLabel.text = record.object(forKey: "message") as? String ?? " "
            
            //EXPERIMENTAL DOWNLOADING IMAGE
            let imgRecord = record.object(forKey: "image")
            self.imageAsset = imgRecord as? CKAsset
            do {
                self.imageURL = self.imageAsset?.fileURL as NSURL?
                
                var imageData = try Data(contentsOf: (self.imageURL ?? NSURL()) as URL)
                
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("ReceivedImage.jpg", isDirectory: false)
                FileManager.default.createFile(atPath: destinationPath!.path, contents: imageData, attributes: nil)
                do {
                    let imgNewData = try Data(contentsOf: destinationPath!)
                    print("download image succeed")
                    
                    
                    //self.imagePath = destinationPath!
                    self.image = UIImage(data: imgNewData)
                    print("do do ")
                } catch {print("bgst") }
                
            } catch {
                print("error download picture with gender")
            }
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
                print(destinationPath!)
                self.audioPath = destinationPath!
                
                
                
                
                
            } catch {
                print("error download audio with gender")
                
            }
            
            //        cell.label2.text = item.name
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapLikes(sender:)))
            tapRecognizer.numberOfTapsRequired = 1
            cell.addGestureRecognizer(tapRecognizer)
            cell.recordName = record.recordID.recordName
            cell.recordID = record.recordID
            cell.image = image
            let date = record.creationDate
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            cell.tanggalLabel.text = formatter1.string(from: date!)
            
            let database = CKContainer.default().publicCloudDatabase
            let predicate = NSPredicate(format: "originID == '\(cell.recordName)'")
            let query = CKQuery(recordType: "perahuKertasReply", predicate: predicate)
            
            database.perform(query, inZoneWith: nil) { (records, error) in
                if let fetchedRecords = records {
                    self.replyCountRecord = "\(fetchedRecords.count)"
                DispatchQueue.main.async {
                    cell.replyCountLabel.text = self.replyCountRecord
                }
            }
            }
            
            
        }
        //print(image)
        return cell
    }
    @objc func tapLikes(sender: UITapGestureRecognizer?){
        if let tapLikes = sender {
            //print(tapLikes.superclass)
            //print(tapLikes.view)
            let cellOwner = tapLikes.view as! RiwayatCollectionCell
            //print(cellOwner.)
            recordName = cellOwner.recordName
            message = cellOwner.suratLabel.text!
            originRecordID = cellOwner.recordID
            image = cellOwner.image
            date = cellOwner.tanggalLabel.text
            performSegue(withIdentifier: "riwayatToReply", sender: Any?.self)
            
            //Make ID for each record and get from cellOwner.(ID) and pass it to CKModify  (ID) likes +1
            
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RiwayatReplyViewController
        
        destinationVC.senderImage = image
        destinationVC.recordName = recordName
        destinationVC.message = message
        destinationVC.originRecordID = originRecordID
        destinationVC.audioOriginPath = self.audioPath
        destinationVC.date = date
        
    }
}
