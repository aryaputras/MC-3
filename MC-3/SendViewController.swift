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

    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var textField: UITextField!
    var color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickReset(_ sender: Any) {
           canvasView.clearDraw()
       }
    
    @IBAction func onClickBrushSz(_ sender: UISlider) {
        canvasView.strokeWidth = CGFloat(sender.value)
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

    @IBAction func buttonWhite(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func buttonBlack(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func buttonBlue(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.2532024682, green: 0.812871635, blue: 0.9448824525, alpha: 1)
    }
    
    @IBAction func buttonGreen(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0, green: 0.7813212872, blue: 0, alpha: 1)
    }
    
    @IBAction func buttonYellow(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0.8500413299, blue: 0, alpha: 1)
    }
    
    @IBAction func buttonOrange(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0.5840916038, blue: 0, alpha: 1)
    }
    
    @IBAction func buttonSoftPink(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.9786210656, green: 0.4592483044, blue: 0.9287266135, alpha: 1)
    }
    
    @IBAction func buttonDarkPink(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0.525508225, alpha: 1)
    }
    
    @IBAction func buttonPurple(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.5280317664, green: 0.1064086631, blue: 0.7941021323, alpha: 1)
    }
    
}
