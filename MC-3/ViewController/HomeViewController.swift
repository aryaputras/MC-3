//
//  HomeViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 26/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit


class HomeViewController: UIViewController {
   
    @IBOutlet weak var usernameLabel: UILabel!
    
    var name = [CKRecord]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        // Do any additional setup after loading the view.
        
        //Get Username
        CKContainer.default().fetchUserRecordID { userID, error in
             if let userID = userID {
                 //print(userID)
             }
            let database = CKContainer.default().publicCloudDatabase
             //let reference = CKRecord.Reference(recordID: userID!, action: .none)
             let predicate = NSPredicate(format: "creatorID == %@", userID?.recordName ?? "")
             let query = CKQuery(recordType: "profile", predicate: predicate)
             query.sortDescriptors = [NSSortDescriptor(key: "signUpDate", ascending: false)]
            
            let queryOp = CKQueryOperation(query: query)
            queryOp.resultsLimit = 1
            
             database.perform(query, inZoneWith: nil) { (records, error) in
                 if let fetchedRecords = records {
                     self.name = fetchedRecords
                     DispatchQueue.main.async {
                        
                        let username = self.name[0].object(forKey: "username") as! String
                            //print(username)
                        
                        
                        
                        
                        self.usernameLabel.text = "Hai, " + username
                    
                        
                     }
                     //                        print(reference)
                     //                        print(query)
                     //                        print(predicate)
                     //                        print(fetchedRecords)
                     //print(self.name)
                 }
             }
         }
        
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
    }
    
    @objc func swipeGesture(sender: UISwipeGestureRecognizer?){
        if let swipeGesture = sender {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                performSegue(withIdentifier: "swipeToSend", sender: Any?.self)
                
            case UISwipeGestureRecognizer.Direction.down :
                performSegue(withIdentifier: "swipeToReceive", sender: Any?.self)
            default:
                break
            }
        }
        
    }
    
}
