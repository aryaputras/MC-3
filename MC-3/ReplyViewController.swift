//
//  ReplyViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    @IBOutlet weak var sliderSize: UISlider!
    @IBOutlet weak var sliderimage: UIImageView!
    @IBOutlet weak var canvasView: canvasView!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var softPinkButton: UIButton!
    @IBOutlet weak var darkPinkButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    @IBOutlet weak var record1Label: UILabel!
    @IBOutlet weak var record2Label: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    
    @IBOutlet weak var selesaiButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    
    
    @IBOutlet weak var isiTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderSize.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        recordButton.isHidden = false
        drawButton.isHidden = false
        sliderSize.isHidden = true
        sliderimage.isHidden = true
        canvasView.isHidden = true
        whiteButton.isHidden = true
        blackButton.isHidden = true
        blueButton.isHidden = true
        greenButton.isHidden = true
        yellowButton.isHidden = true
        orangeButton.isHidden = true
        softPinkButton.isHidden = true
        darkPinkButton.isHidden = true
        purpleButton.isHidden = true
        isiTextField.isHidden = false
        record1Label.isHidden = true
        record2Label.isHidden = true
        recordingButton.isHidden = true
    }
    
    @IBAction func recordButton(_ sender: Any) {
        recordButton.isHidden = true
        drawButton.isHidden = true
        sliderSize.isHidden = true
        sliderimage.isHidden = true
        canvasView.isHidden = true
        whiteButton.isHidden = true
        blackButton.isHidden = true
        blueButton.isHidden = true
        greenButton.isHidden = true
        yellowButton.isHidden = true
        orangeButton.isHidden = true
        softPinkButton.isHidden = true
        darkPinkButton.isHidden = true
        purpleButton.isHidden = true
        deleteButton.setTitle("Urungkan", for: .normal)
        isiTextField.isHidden = true
        record1Label.isHidden = false
        record2Label.isHidden = false
        recordingButton.isHidden = false
        
    }
    
    @IBAction func drawButton(_ sender: Any) {
        recordButton.isHidden = true
        drawButton.isHidden = true
        sliderSize.isHidden = false
        sliderimage.isHidden = false
        canvasView.isHidden = false
        whiteButton.isHidden = false
        blackButton.isHidden = false
        blueButton.isHidden = false
        greenButton.isHidden = false
        yellowButton.isHidden = false
        orangeButton.isHidden = false
        softPinkButton.isHidden = false
        darkPinkButton.isHidden = false
        purpleButton.isHidden = false
        isiTextField.isHidden = true
        record1Label.isHidden = true
        record2Label.isHidden = true
        recordingButton.isHidden = true
    }
    
    @IBAction func whiteButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    @IBAction func blackButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    @IBAction func blueButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.2532024682, green: 0.812871635, blue: 0.9448824525, alpha: 1)
    }
    @IBAction func greenButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0, green: 0.7813302875, blue: 0, alpha: 1)
    }
    @IBAction func yellowButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0.8500413299, blue: 0, alpha: 1)
    }
    @IBAction func orangeButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0.5840916038, blue: 0, alpha: 1)
    }
    @IBAction func softPinkButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.9786210656, green: 0.4592483044, blue: 0.9287266135, alpha: 1)
    }
    @IBAction func darkPinkButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0.525508225, alpha: 1)
    }
    @IBAction func purpleButton(_ sender: Any) {
        canvasView.strokeColor = #colorLiteral(red: 0.5280317664, green: 0.1064086631, blue: 0.7941021323, alpha: 1)
    }
   
    @IBAction func sliderSize(_ sender: UISlider) {
        canvasView.strokeWidth = CGFloat(sender.value)
    }
    
}
