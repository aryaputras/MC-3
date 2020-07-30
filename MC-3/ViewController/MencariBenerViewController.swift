//
//  MencariBenerViewController.swift
//  MC-3
//
//  Created by Abigail Aryaputra Sudarman on 25/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class MencariBenerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let path = getDocumentsDirectory().appendingPathComponent("ReceivedAudio.m4a")
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print("error removing audio")
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
        
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            performSegue(withIdentifier: "mencariToMenangkap", sender: Any?.self)
            //show some alert here
        }
    }
    func getDocumentsDirectory() -> URL {
        var paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        return paths[0]
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
