//
//  Register2VC.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 18/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class Register2VC: UIViewController {
    var GenderPrefer : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func ButtonMale(_ sender: Any) {
        GenderPrefer = "Laki-Laki"
    }
    
    @IBAction func ButtonFemale(_ sender: Any) {
        GenderPrefer = "Perempuan"
    }
    
    @IBAction func ButtonAll(_ sender: Any) {
        GenderPrefer = "Semua"
    }
    
}
