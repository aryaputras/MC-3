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
    var gender : Int = 0
    var age : Int = 19
    var imageName : [String] = ["Avatar 1","Avatar 2","Avatar 3","Avatar 4"]
    var index = 0
    @IBOutlet weak var regisImage: UIImageView!
    @IBOutlet weak var regisUsername: UITextField!
    @IBOutlet weak var regisAge: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        buttonMale.setImage(UIImage(named: "Button_Cowok_Tapped"),for: .normal)
        gender = 1
    }
    
    @IBAction func buttonFemale(_ sender: Any) {
        buttonMale.setImage(UIImage(named: "Button_Cewek_Tapped"),for: .normal)
        gender = 2
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        
        //  print(imageName[index])
        
        
        
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




