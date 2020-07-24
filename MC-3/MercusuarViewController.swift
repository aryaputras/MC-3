//
//  MercusuarViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class MercusuarViewController: UIViewController{
    
    var records = [CKRecord]()
    @IBOutlet weak var mercusuarCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mercusuarCollectionView.register(MercusuarCollectionViewCell.nib(),forCellWithReuseIdentifier: "MercusuarCollectionViewCell")
        mercusuarCollectionView.delegate = self
        mercusuarCollectionView.dataSource = self
        
        
        
        
        
        let database = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "question", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
        
        database.perform(query, inZoneWith: nil) { (records, error) in
              if let fetchedRecords = records {
                                self.records = fetchedRecords
                                DispatchQueue.main.async {
                                    self.mercusuarCollectionView.reloadData()
                                   print(fetchedRecords)
                                }
                             
                            }
        }
        
    }
}
extension MercusuarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //barang di collectionnya biasa pake counter
        return self.records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MercusuarCollectionViewCell", for: indexPath) as! MercusuarCollectionViewCell
        let record = records[indexPath.row]
       
        
        cell.replyLabel.text = record.object(forKey: "question") as! String
        
        
        print(record.object(forKey: "question"))
        
        // buat masukin isinya dari mana
                //let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        return cell
    }
}
