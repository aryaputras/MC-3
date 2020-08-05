//
//  RegisterVC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit


class RegisterVC: UIViewController, UITextFieldDelegate {
    var GenderCowoisOn:Bool = false
    var GenderCeweisOn:Bool = false
    var gender : Int = 0
    var age : Int = 19
    var imageName : [String] = ["Avatar 1","Avatar 2","Avatar 3","Avatar 4"]
    var index = 0
    
    @IBOutlet weak var regisImage: UIImageView!
    @IBOutlet weak var regisUsername: UITextField!
    @IBOutlet weak var regisAge: UILabel!
    
    @IBOutlet weak var buttonFemale: UIButton!
    @IBOutlet weak var buttonMale: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        initializeHideKeyboard()
        regisUsername.delegate = self
        textFieldShouldReturn(regisUsername)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! Register2VC
        
        destinationVC.age = age
        destinationVC.gender = gender
        destinationVC.name = regisUsername.text!
        destinationVC.avatar = imageName[index]
        
        
    }
    
    
    
    
    @IBAction func buttonLeft(_ sender: Any) {
        if index != 0
        {
            index-=1
            regisImage.image = UIImage(imageLiteralResourceName: imageName[index])
        }
        else if index == 0{
            index = 3
            regisImage.image = UIImage(imageLiteralResourceName: imageName[index])
        }
    }
    
    @IBAction func buttonRight(_ sender: Any) {
        if index != 3
        {
            index+=1
            regisImage.image = UIImage(imageLiteralResourceName: imageName[index])
        }
        else if index == 3 {
            index = 0
            regisImage.image = UIImage(imageLiteralResourceName: imageName[index])
        }
    }
    
    @IBAction func buttonMin(_ sender: Any) {
        age-=1
        regisAge.text = "\(age)"
    }
    
    @IBAction func buttonPlus(_ sender: Any) {
        age+=1
        regisAge.text = "\(age)"
    }
    
    @IBAction func buttonMale(_ sender: Any) {
        if(GenderCeweisOn == true){
            GenderCeweisOn = true
            GenderCeweisOn.toggle()
            setButtonBackGround(view: buttonFemale as! UIButton, on:#imageLiteral(resourceName: "button_Cewek_Tapped") ,off:#imageLiteral(resourceName: "Button_Cewe") ,onOffStatus:GenderCeweisOn)
        }
        GenderCowoisOn.toggle()
        setButtonBackGround(view: sender as! UIButton, on: #imageLiteral(resourceName: "button_Cowok_Tapped"), off:  #imageLiteral(resourceName: "Button_Cowo"), onOffStatus: GenderCowoisOn)
        gender = 1
    }
    
    @IBAction func buttonFemale(_ sender: Any) {
        if(GenderCowoisOn == true){
            GenderCowoisOn = true
            GenderCowoisOn.toggle()
            setButtonBackGround(view: buttonMale as! UIButton, on: #imageLiteral(resourceName: "button_Cowok_Tapped"), off:  #imageLiteral(resourceName: "Button_Cowo"), onOffStatus: GenderCowoisOn)
        }
        GenderCeweisOn.toggle()
        setButtonBackGround(view: sender as! UIButton, on: #imageLiteral(resourceName: "button_Cewek_Tapped"), off:  #imageLiteral(resourceName: "Button_Cewe"), onOffStatus: GenderCeweisOn)
        gender = 2
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        
        //  print(imageName[index])
        
        
        
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




