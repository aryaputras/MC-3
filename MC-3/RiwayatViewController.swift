//
//  RiwayatViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class RiwayatViewController: UIViewController{
    var inbox = [CKRecord]()
    @IBOutlet weak var riwayatCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        riwayatCollectionView.register(RiwayatCollectionCell.nib(),forCellWithReuseIdentifier: "RiwayatCollectionCell")
        riwayatCollectionView.delegate = self
        riwayatCollectionView.dataSource = self
        
        let database = CKContainer.default().publicCloudDatabase
        
                      CKContainer.default().fetchUserRecordID { userID, error in
                    if let userID = userID {
                        //print(userID)
                     
                    }
                    
                        //GETTING USER'S MESSAGES THAT GO OUT
                    let reference = CKRecord.Reference(recordID: userID!, action: .none)
                    let predicate = NSPredicate(format: "creatorID == %@", userID?.recordName ?? "")
                    let query = CKQuery(recordType: "perahuKertas", predicate: predicate)
                        
                        query.sortDescriptors = [NSSortDescriptor(key: "sendingDate", ascending: false)]
                        
                    database.perform(query, inZoneWith: nil) { (records, error) in
                            if let fetchedRecords = records {
                                self.inbox = records!
                                DispatchQueue.main.async {
                                    self.riwayatCollectionView.reloadData()
                                  
                                    //PRINT MESSAGE
                                    
                                    //print(records![0].object(forkey: "message")
                                    
                                    
                                    //PRINT RECORDNAME
                                   // print(records![0].recordID.recordName)
                              
                                                         }
                           
                                
                                
                            }
                        }
                        
                        
                }
        
    }
}
extension RiwayatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //barang di collectionnya biasa pake counter
        return self.inbox.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatCollectionCell", for: indexPath) as! RiwayatCollectionCell
        // buat masukin isinya dari mana
        let record = inbox[indexPath.row]
        print(inbox)
        //        cell.imageView.image = item.imageName
        cell.suratLabel.text = record.object(forKey: "message") as! String
        //        cell.label2.text = item.name
        return cell
    }
}
