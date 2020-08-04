//
//  Register2VC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit
import RangeSeekSlider


class Register2VC: UIViewController {
    var genderPrefer = 0
    var agePreferMin = 17
    var agePreferMax = 45
    var GenderCowokisOn:Bool = false
    var GenderCewekisOn:Bool = false
    var GenderSemuaisOn:Bool = false
    
    var age = 0
    var name = ""
    var gender = 0
    var avatar = ""
    
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    @IBOutlet weak var buttonFemale: UIButton!
    @IBOutlet weak var buttonMale: UIButton!
    @IBOutlet weak var buttonAll: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    
    @IBAction func buttonMale(_ sender: Any) {
        if(GenderCewekisOn == true){
            GenderCewekisOn = true
            GenderCewekisOn.toggle()
            setButtonBackGround(view: buttonFemale as! UIButton, on:#imageLiteral(resourceName: "button_Cewek_Tapped") ,off:#imageLiteral(resourceName: "Button_Cewe") ,onOffStatus:GenderCewekisOn)
        }
        if(GenderSemuaisOn == true){
            GenderSemuaisOn = true
            GenderSemuaisOn.toggle()
            setButtonBackGround(view: buttonAll as! UIButton, on: #imageLiteral(resourceName: "button_Semua_Tapped"), off:  #imageLiteral(resourceName: "Button_Semua"), onOffStatus: GenderSemuaisOn)
        }
        GenderCowokisOn.toggle()
        setButtonBackGround(view: sender as! UIButton, on: #imageLiteral(resourceName: "button_Cowok_Tapped"), off:  #imageLiteral(resourceName: "Button_Cowo"), onOffStatus: GenderCowokisOn)
        genderPrefer = 1
    }
    
    @IBAction func buttonFemale(_ sender: Any) {
        if(GenderCowokisOn == true){
            GenderCowokisOn = true
            GenderCowokisOn.toggle()
            setButtonBackGround(view: buttonMale as! UIButton, on: #imageLiteral(resourceName: "button_Cowok_Tapped"), off:  #imageLiteral(resourceName: "Button_Cowo"), onOffStatus: GenderCowokisOn)
        }
        if(GenderSemuaisOn == true){
            GenderSemuaisOn = true
            GenderSemuaisOn.toggle()
            setButtonBackGround(view: buttonAll as! UIButton, on: #imageLiteral(resourceName: "button_Semua_Tapped"), off:  #imageLiteral(resourceName: "Button_Semua"), onOffStatus: GenderSemuaisOn)
        }
        GenderCewekisOn.toggle()
        setButtonBackGround(view: sender as! UIButton, on: #imageLiteral(resourceName: "button_Cewek_Tapped"), off:  #imageLiteral(resourceName: "Button_Cewe"), onOffStatus: GenderCewekisOn)
        genderPrefer = 2
    }
    
    @IBAction func buttonAll(_ sender: Any) {
        if(GenderCowokisOn == true){
            GenderCowokisOn = true
            GenderCowokisOn.toggle()
            setButtonBackGround(view: buttonMale as! UIButton, on: #imageLiteral(resourceName: "button_Cowok_Tapped"), off:  #imageLiteral(resourceName: "Button_Cowo"), onOffStatus: GenderCowokisOn)
        }
        if(GenderCewekisOn == true){
            GenderCewekisOn = true
            GenderCewekisOn.toggle()
            setButtonBackGround(view: buttonFemale as! UIButton, on:#imageLiteral(resourceName: "button_Cewek_Tapped") ,off:#imageLiteral(resourceName: "Button_Cewe") ,onOffStatus:GenderCewekisOn)
        }
        GenderSemuaisOn.toggle()
        setButtonBackGround(view: sender as! UIButton, on: #imageLiteral(resourceName: "button_Semua_Tapped"), off:  #imageLiteral(resourceName: "Button_Semua"), onOffStatus: GenderSemuaisOn)
        genderPrefer = 0
    }
    
    
    @IBAction func dadadada(_ sender: RangeSeekSlider) {
        
        agePreferMin = Int(sender.selectedMinValue)
        agePreferMax = Int(sender.selectedMaxValue)
        print(agePreferMin, agePreferMax)
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        
        CKContainer.default().fetchUserRecordID { userID, error in
            if let userID = userID {
                //print(userID)
                let nameRecord = self.name as CKRecordValue
                let ageRecord = self.age as CKRecordValue
                let genderRecord = self.gender as CKRecordValue
                let agePreferMinRecord = self.agePreferMin as CKRecordValue
                let agePreferMaxRecord = self.agePreferMax as CKRecordValue
                let genderPreferRecord = self.genderPrefer as CKRecordValue
                let avatarRecord = self.avatar as CKRecordValue
                let creatorID = userID.recordName as CKRecordValue
                let date = Date() as CKRecordValue
                
                
                
                
                let newRecord = CKRecord(recordType: "profile")
                
                let database = CKContainer.default().publicCloudDatabase
                
                
                newRecord.setObject(nameRecord, forKey: "username")
                newRecord.setObject(ageRecord, forKey: "senderAge")
                newRecord.setObject(genderRecord, forKey: "senderGender")
                newRecord.setObject(agePreferMinRecord, forKey: "agePreferenceMin")
                newRecord.setObject(agePreferMaxRecord, forKey: "agePreferenceMax")
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
