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
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func doneAction(_ sender: Any) {
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
                let creatorID = userID.recordName as CKRecordValue
                let date = Date() as CKRecordValue
                let story = self.textField.text! as CKRecordValue
                //let audio =
                
                let newRecord = CKRecord(recordType: "perahuKertas")
                let database = CKContainer.default().publicCloudDatabase
                
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
