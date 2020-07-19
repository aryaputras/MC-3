//
//  Register2VC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class Register2VC: UIViewController {
    var genderPrefer : [Int] = []
    var agePrefer : [Int] = []
    
    
    var age = 0
    var name = ""
    var gender = 0
    var avatar = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 


    }
    
    @IBAction func buttonMale(_ sender: Any) {
        genderPrefer = [0]
    }
    
    @IBAction func buttonFemale(_ sender: Any) {
        genderPrefer = [1]
    }
    
    @IBAction func buttonAll(_ sender: Any) {
        genderPrefer = [0,1]
    }

   

    @IBAction func buttonNext(_ sender: Any) {
        
          CKContainer.default().fetchUserRecordID { userID, error in
        if let userID = userID {
            //print(userID)
            let nameRecord = self.name as CKRecordValue
            let ageRecord = self.age as CKRecordValue
            let genderRecord = self.gender as CKRecordValue
            let agePreferRecord = self.agePrefer as CKRecordValue
            let genderPreferRecord = self.genderPrefer as CKRecordValue
            let avatarRecord = self.avatar as CKRecordValue
            let creatorID = userID.recordName as CKRecordValue
            let date = Date() as CKRecordValue
           
          

                            
                let newRecord = CKRecord(recordType: "profile")
                
                let database = CKContainer.default().publicCloudDatabase
                
                //newRecord.setObject(avatar, forKey: "regisimage")
                newRecord.setObject(nameRecord, forKey: "username")
                newRecord.setObject(ageRecord, forKey: "age")
                newRecord.setObject(genderRecord, forKey: "gender")
                newRecord.setObject(agePreferRecord, forKey: "agePreference")
                newRecord.setObject(genderPreferRecord, forKey: "genderPreference")
                newRecord.setObject(avatarRecord, forKey: "avatar")
                newRecord.setObject(creatorID, forKey: "creatorID")
                newRecord.setObject(date, forKey: "signUpDate")
                
                database.save(newRecord) { record , error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("error")
                            
                        } else {
                            print("record was saved")
                          
                        }
                    }
                }
            } }
        
       
        
    }
    
           
           
//

//
//

                   }
              
