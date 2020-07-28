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
        //LIMIT RESULT TO 10
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
        cell.frame.size = CGSize(width: 414, height: 172)
        let record = records[indexPath.row]
       
        let likesNumber = record.object(forKey: "likes") as! Int
        cell.replyLabel.text = record.object(forKey: "question") as? String
        cell.numberOfLikes.text = "\(likesNumber)"
        cell.userNameLabel.text = record.object(forKey: "username") as? String
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapLikes(sender:)))
        tapRecognizer.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tapRecognizer)
        print(likesNumber)
        
        // buat masukin isinya dari mana
                //let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        return cell
    }
    @objc func tapLikes(sender: UITapGestureRecognizer?){
        if let tapLikes = sender {
            //print(tapLikes.superclass)
            //print(tapLikes.view)
            let cellOwner = tapLikes.view as! MercusuarCollectionViewCell
            print(cellOwner.replyLabel.text)
            
            //Make ID for each record and get from cellOwner.(ID) and pass it to CKModify  (ID) likes +1
            
           
        }
    }
}
