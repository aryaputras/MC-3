//
//  RegisterVC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    var Gender : String = ""
    var Age : Int = 19
   var ImageName : [String] = ["Avatar 1","Avatar 2","Avatar 3","Avatar 4"]
   var index = 0
    @IBOutlet weak var RegisImage: UIImageView!
    @IBOutlet weak var RegisUsername: UITextField!
    @IBOutlet weak var RegisAge: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ButtonLeft(_ sender: Any) {
        if index != 0
        {
        index-=1
               RegisImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
        else if index == 0{
            index = 3
            RegisImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
    }
    
    @IBAction func ButtonRight(_ sender: Any) {
        if index != 3
        {
        index+=1
               RegisImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
        else if index == 3 {
            index = 0
            RegisImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
    }
    
    @IBAction func ButtonMin(_ sender: Any) {
        Age-=1
        RegisAge.text = "\(Age)"
    }
    
    @IBAction func ButtonPlus(_ sender: Any) {
        Age+=1
        RegisAge.text = "\(Age)"
    }
    
    @IBAction func ButtonMale(_ sender: Any) {
        Gender = "Laki-Laki"
    }
    
    @IBAction func ButtonFemale(_ sender: Any) {
        Gender = "Perempuan"
    }
    


}
