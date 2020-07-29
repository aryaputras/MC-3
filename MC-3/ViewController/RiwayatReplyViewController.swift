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
    @IBOutlet weak var riwayatReplyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        //print(recordName)
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
        print(inbox)
        cell.replyLabel.text = record.object(forKey: "reply") as! String
        return cell
    }
    
}
