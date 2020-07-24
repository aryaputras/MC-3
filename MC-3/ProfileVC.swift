//
//  ProfileVC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class ProfileVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileUsername: UITextField!
    @IBOutlet weak var sendCounter: UILabel!
    @IBOutlet weak var receiveCounter: UILabel!
    @IBOutlet weak var haiUser: UILabel!
    @IBOutlet weak var since: UILabel!
    var index : Int = 0
    var ImageName : [String] = ["Avatar 1","Avatar 2","Avatar 3","Avatar 4"]
    var name = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let database = CKContainer.default().publicCloudDatabase
        
        initializeHideKeyboard()
        profileUsername.delegate = self
        textFieldShouldReturn(profileUsername)
        
        
        
        //EXPERIMENTAL
        
              CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
             
            }
            
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "creatorID == %@", userID?.recordName ?? "")
            let query = CKQuery(recordType: "profile", predicate: predicate)
                
                query.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
                
            database.perform(query, inZoneWith: nil) { (records, error) in
                    if let fetchedRecords = records {
                        self.name = fetchedRecords
                        DispatchQueue.main.async {
                            print(self.name)
                            
                            
                        let username = self.name[0].object(forKey: "username")
                        self.haiUser.text = "hai, \(username!)!"
                           
                        let creationDate = self.name[0].object(forKey: "signUpDate")
                        self.since.text = "\(creationDate!)"
                            
                        let avatarImage = self.name[0].object(forKey: "avatar")
                        self.profileImage.image = UIImage(named: avatarImage as! String)
                            
                                                 }
//                        print(reference)
//                        print(query)
//                        print(predicate)
//                        print(fetchedRecords)
                        
                        //print(self.name)
                   
                        
                        
                    }
                }
                
                
        }

        //EXPERIMENTAL

        // Do any additional setup after loading the view.
    }

    
     @IBAction func ButtonLeft(_ sender: Any) {
        if index != 0
        {
        index-=1
               profileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
        else if index == 0{
            index = 3
            profileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
    }
    
    @IBAction func ButtonRight(_ sender: Any) {
        if index != 3
        {
        index+=1
               profileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
        else if index == 3 {
            index = 0
            profileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
    }

    @IBAction func ButtonSave(_ sender: Any) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func initializeHideKeyboard(){
    //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
    target: self,
    action: #selector(dismissMyKeyboard))
    //Add this tap gesture recognizer to the parent view
    view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
    //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
    //In short- Dismiss the active keyboard.
    view.endEditing(true)
    }
    
}
