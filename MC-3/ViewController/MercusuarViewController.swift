//
//  MercusuarViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class MercusuarViewController: UIViewController{
    var username = ""
    var label = ""
    var likesIsON:Bool = false
    var records = [CKRecord]()
    @IBOutlet weak var mercusuarCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
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
                    //print(fetchedRecords)
                }
                
            }
        }
        
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
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
        if (indexPath == 0){
            cell.top3Label.text = "1"
        }
        else if(indexPath == 1){
            cell.top3Label.text = "2"
        }
        else if(indexPath == 2){
            cell.top3Label.text = "3"
        }
        else if (indexPath >= 3) {
            cell.top3Label.text = ""
        }
        cell.replyLabel.text = record.object(forKey: "question") as? String
        cell.numberOfLikes.text = "\(likesNumber)"
        cell.userNameLabel.text = record.object(forKey: "username") as? String
        // = record.recordID.recordName
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapLikes(sender:)))
        tapRecognizer.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tapRecognizer)
        cell.recordName = record.recordID.recordName
        
        //print(record)
        
        
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
            //print(cellOwner.)
            //print(cellOwner.recordName)
            
            var likesNumber =  Int(cellOwner.numberOfLikes.text!)
            
            if likesIsON == false {
                // ini kalo dia mati dinyalain dan likesnya nambah
                
                likesNumber! += 1
                
                cellOwner.numberOfLikes.text = "\(likesNumber ?? 99)"
                
                print(likesNumber!)
                likesIsON = false
                likesIsON.toggle()
                setButtonBackGround(view: cellOwner.likesButton!, on: #imageLiteral(resourceName: "Ikan_isi"), off:  #imageLiteral(resourceName: "Ikan"), onOffStatus: likesIsON)
                
                
                   let database = CKContainer.default().publicCloudDatabase
                   let record = CKRecord.ID(recordName: cellOwner.recordName)
                   let newRecord = CKRecord(recordType: "question", recordID: record)
                   
                   
                   newRecord.setValue(likesNumber, forKey: "likes")
                   
                   let operation = CKModifyRecordsOperation(recordsToSave: [newRecord], recordIDsToDelete: nil)
                   
                   operation.savePolicy = .changedKeys
                   
                   operation.modifyRecordsCompletionBlock = {
                       records, ids , error in
                       print(error)
                       //print(records)
                       
                   }
                   database.add(operation)
                   //RELOADDATA
                   //Make ID for each record and get from cellOwner.(ID) and pass it to CKModify  (ID) likes +1
                   
                   mercusuarCollectionView.reloadData()
                
            }
            if likesIsON == true {
                // ini kalo dia hidup dimatiin dan likesnya ngurang
               
                likesNumber! -= 1
                cellOwner.numberOfLikes.text = "\(likesNumber ?? 99)"
                print(likesNumber!)
                likesIsON = true
                likesIsON.toggle()
                setButtonBackGround(view: cellOwner.likesButton!, on: #imageLiteral(resourceName: "Ikan_isi"), off:  #imageLiteral(resourceName: "Ikan"), onOffStatus: likesIsON)
                
                
                   let database = CKContainer.default().publicCloudDatabase
                   let record = CKRecord.ID(recordName: cellOwner.recordName)
                   let newRecord = CKRecord(recordType: "question", recordID: record)
                   
                   
                   newRecord.setValue(likesNumber, forKey: "likes")

 //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME //OLD SCHEME
                
                
                
                   let operation = CKModifyRecordsOperation(recordsToSave: [newRecord], recordIDsToDelete: nil)
                   
                   operation.savePolicy = .changedKeys
                   
                   operation.modifyRecordsCompletionBlock = {
                       records, ids , error in
                       print(error)
                       //print(records)
                       
                   }
                
                   database.add(operation)
                
                
                
//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME//NEW SCHEME
                
                
                
                   //RELOADDATA
                   //Make ID for each record and get from cellOwner.(ID) and pass it to CKModify  (ID) likes +1
                   
                   mercusuarCollectionView.reloadData()
            }
            
   
            
        }
    }
    
    func setButtonBackGround(view: UIButton, on: UIImage, off: UIImage, onOffStatus: Bool ) {
        switch onOffStatus {
        case true:
            // Chnage backgroundImage to hart image
            view.setImage(on, for: .normal)
            // Test
            print("Button Pressed")
        default:
            view.setImage(off, for: .normal)
                print("Button Unpressed")
        }
    }
}
