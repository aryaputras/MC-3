//
//  RiwayatReplyViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class RiwayatReplyViewController: UIViewController{
    var recordName = ""
    var inbox = [CKRecord]()
    var message = ""
    var originRecordID: CKRecord.ID?
    var senderImage: UIImage?
    var replyImage: UIImage?
    var replyImageAsset: CKAsset?
    var replyImageURL: NSURL?
    var replyImagePath: URL?
    
    @IBOutlet weak var riwayatReplyCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var senderImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        //print(recordName)
        // print(originRecordID)
        //query the original record
        
        senderImageView.image = senderImage
        
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
                    self.riwayatReplyCollectionView.reloadData()
                }
            }
        }
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
        cell.replyLabel.text = record.object(forKey: "reply") as! String
        cell.usernameLabel.text = record.object(forKey: "replyNickname") as! String
        
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
                print("do do ")
            } catch {print("bgst") }
            
        } catch {
            print("error download picture with gender")
        }
        
        let date = record.creationDate
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        //print(formatter1.string(from: date!))
        cell.imageView.image = replyImage
        cell.dateLabel.text = formatter1.string(from: date!)
        // buat masukin isinya dari mana
        //        let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        return cell
    }
    
}
