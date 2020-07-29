//
//  HomeViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 26/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
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
