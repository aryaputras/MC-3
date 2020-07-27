//
//  WriteMercusuarViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 24/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class WriteMercusuarViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var mercusuarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeHideKeyboard()
        mercusuarTextField.delegate = self
        textFieldShouldReturn(mercusuarTextField)

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
