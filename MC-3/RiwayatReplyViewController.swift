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
    @IBOutlet weak var riwayatReplyCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(recordName)
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
                
                DispatchQueue.main.async {
                    //code
                    print(self.inbox)
                    self.riwayatReplyCollectionView.reloadData()
                }
            }
        }
        
        
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
        print(inbox)
        cell.replyLabel.text = record.object(forKey: "reply") as! String
        cell.usernameLabel.text = record.object(forKey: "replyNickname") as! String
        
        let date = record.creationDate
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        print(formatter1.string(from: date!))
        
        cell.dateLabel.text = formatter1.string(from: date!)
        // buat masukin isinya dari mana
        //        let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        return cell
    }
    
}
