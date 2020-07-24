//
//  AskViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 24/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class AskViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    var creatorID = ""
    var username = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get userID
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                self.creatorID = userID.recordName
                self.fetchUsername()
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func selesaiButton(_ sender: Any) {
        
        let usernameRecord = username as CKRecordValue
        let question = textfield.text as! CKRecordValue
        let likes = 0 as CKRecordValue
        
        let database = CKContainer.default().publicCloudDatabase
        let newRecord = CKRecord(recordType: "question")
        
        newRecord.setObject(usernameRecord, forKey: "username")
        newRecord.setObject(question, forKey: "question")
        newRecord.setObject(likes, forKey: "likes")
        
        database.save(newRecord) { (record, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("error")
                } else {
                    print("record was saved")
                }
            }
        }
        
    }
    func fetchUsername() {
        let database = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(format: "creatorID == %@", creatorID)
        let query = CKQuery(recordType: "profile", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (record, error) in
            if let fetchedRecords = record {
                DispatchQueue.main.async {
                    
                    self.username = record![0].object(forKey: "username") as! String
                    
                    print(self.username)
                }
                //store in var
                
            }
        }
    }
    
    func createQuestionRecord() {
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
