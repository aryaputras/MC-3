//
//  ProfileVC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileUsername: UITextField!
    @IBOutlet weak var SendCounter: UILabel!
    @IBOutlet weak var ReceiveCounter: UILabel!
    var index : Int = 0
    var ImageName : [String] = ["Avatar 1","Avatar 2","Avatar 3","Avatar 4"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

     @IBAction func ButtonLeft(_ sender: Any) {
        if index != 0
        {
        index-=1
               ProfileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
        else if index == 0{
            index = 3
            ProfileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
    }
    
    @IBAction func ButtonRight(_ sender: Any) {
        if index != 3
        {
        index+=1
               ProfileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
        else if index == 3 {
            index = 0
            ProfileImage.image = UIImage(imageLiteralResourceName: ImageName[index])
        }
    }

    @IBAction func ButtonSave(_ sender: Any) {
    }
    
}
