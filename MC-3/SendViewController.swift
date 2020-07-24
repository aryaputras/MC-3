//
//  ViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 17/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class SendViewController: UIViewController {
    var age = 0
    var gender = 0
    var profile = [CKRecord]()
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetching age
        CKContainer.default().fetchUserRecordID { userID, error in
                 if let userID = userID {
                    let database = CKContainer.default().publicCloudDatabase
                    
                    let predicate = NSPredicate(format: "creatorID == %@", userID.recordName)
                    let queryProfile = CKQuery(recordType: "profile", predicate: predicate)
                    queryProfile.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
                    
                    database.perform(queryProfile, inZoneWith: nil) { (records, error) in
                           if let fetchedRecords = records {
                               self.profile = fetchedRecords
                               DispatchQueue.main.async {
                                 //get sender age
                                self.age = self.profile[0].object(forKey: "age") as! Int
                               
                                
                                
                                //get sender gender
                                self.gender = self.profile[0].object(forKey: "gender") as! Int
                               
                                
                                  
                                   
                               }
                               
                           }
                       }
                    
                    
            }
            
        
    }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
                let creatorID = userID.recordName as CKRecordValue
                let date = Date() as CKRecordValue
                let story = self.textField.text! as CKRecordValue
                //let audio =
                let ageRecord = self.age as CKRecordValue
                let genderRecord = self.gender as CKRecordValue
                let newRecord = CKRecord(recordType: "perahuKertas")
                let database = CKContainer.default().publicCloudDatabase
                
                newRecord.setObject(genderRecord, forKey: "senderGender")
                newRecord.setObject(ageRecord, forKey: "senderAge")
                newRecord.setObject(story, forKey: "message")
                newRecord.setObject(creatorID, forKey: "creatorID")
                newRecord.setObject(date, forKey: "sendingDate")
                
                database.save(newRecord) { record , error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("error")
                            
                        } else {
                            print("record was saved")
                            
                        }
                    }
                }
            }
        }
    }
}
