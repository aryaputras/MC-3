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
    var newLikes = ""
    
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
        cell.tag = indexPath.row
        
        let likesNumber = record.object(forKey: "likesLog") as! [String]
        
        
        
        
        
        if (indexPath.row == 0){
            cell.top3Label.text = "1"
        }
        else if(indexPath.row == 1){
            cell.top3Label.text = "2"
        }
        else if(indexPath.row == 2){
            cell.top3Label.text = "3"
        }
        else if (indexPath.row >= 3) {
            cell.top3Label.text = ""
        }
        cell.replyLabel.text = record.object(forKey: "question") as? String
        cell.numberOfLikes.text = "\(likesNumber.count)"
        cell.userNameLabel.text = record.object(forKey: "username") as? String
        // = record.recordID.recordName
        
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapLikes(sender:)))
        tapRecognizer.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tapRecognizer)
        cell.recordName = record.recordID.recordName
        
        cell.likesLog = record.object(forKey: "likesLog") as! [String]
        
        

        //GET IT WERKIN
        CKContainer.default().fetchUserRecordID { userID, error in
             if let userID = userID {
               
                 var likesLog = cell.likesLog
                 
                 
                 if likesLog.contains(userID.recordName){
                     print("you already liked this")
                    DispatchQueue.main.async {
                    cell.likesButton.imageView?.image = #imageLiteral(resourceName: "Ikan_isi")
                        
                    
                    }
                 } else {
                   
                     print("not liked yet")
                    DispatchQueue.main.async {
                    cell.likesButton.imageView?.image = #imageLiteral(resourceName: "Ikan")
                    }
                 }
    
             }
         }
        
        
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
            //print()
            var likesNumber =  cellOwner.likesLog.count
            
           
                print("false,,\(likesIsON)")
                
                CKContainer.default().fetchUserRecordID { userID, error in
                    if let userID = userID {
                        let database = CKContainer.default().publicCloudDatabase
                        let record = CKRecord.ID(recordName: cellOwner.recordName)
                        let newRecord = CKRecord(recordType: "question", recordID: record)
                        var likesLog = cellOwner.likesLog
                        
                        
                        if likesLog.contains(userID.recordName){
                            print("you already liked this")
                            likesLog.removeAll { $0 == "\(userID.recordName)" }
                            DispatchQueue.main.async {
                                cellOwner.likesButton.imageView?.image = #imageLiteral(resourceName: "Ikan")
                                
                                self.records[cellOwner.tag].setValue(likesLog, forKey: "likesLog")
                                
                            }
                        } else {
                            likesLog.append(userID.recordName)
                            print("ok liked!")
                            DispatchQueue.main.async {
                                cellOwner.likesButton.imageView?.image = #imageLiteral(resourceName: "Ikan_isi")
                                
                                self.records[cellOwner.tag].setValue(likesLog, forKey: "likesLog")
                                
                            }
                        }
                        
                        
                        let newLikesLog = likesLog
                        self.newLikes = "\(newLikesLog.count)"
                        DispatchQueue.main.async {
                            
                            
                            cellOwner.numberOfLikes.text = self.newLikes
                        }
                        print(newLikesLog)
                        
                        newRecord.setValue(newLikesLog, forKey: "likesLog")
                        
                        let operation = CKModifyRecordsOperation(recordsToSave: [newRecord], recordIDsToDelete: nil)
                        
                        operation.savePolicy = .changedKeys
                        
                        operation.modifyRecordsCompletionBlock = {
                            records, ids , error in
                            print(error)
                            //print(records)
                            DispatchQueue.main.async {
                         
                            }
                            
                        }
                        database.add(operation)
                        
                    }
                }
                
            
            
                // ini kalo dia hidup dimatiin dan likesnya ngurang
                
                //likesNumber! -= 1
                //CellOwner.numberOfLikes.text = "\(likesNumber ?? 99)"
                //print(likesNumber!)
            
            
            
            
            
        }
    }
    
    func setButtonBackGround(view: UIButton, on: UIImage, off: UIImage, onOffStatus: Bool ) {
        switch onOffStatus {
        case true:
            // Chnage backgroundImage to hart image
            DispatchQueue.main.async {
                
                
                view.setImage(on, for: .normal)
            }
            // Test
            print("Button Pressed")
        default:
            DispatchQueue.main.async {
                
                
                view.setImage(off, for: .normal)
                print("Button Unpressed")
            }
        }
    }
}
