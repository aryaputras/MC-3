//
//  AnimasiLipatKertasViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 28/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class AnimasiLipatKertasViewController: UIViewController {
    @IBOutlet var labelAtas: UILabel!
    @IBOutlet var labelBawah: UILabel!
    @IBOutlet var labelKalimat:UILabel!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var kertasLipat: UIImageView!
    @IBOutlet var borderOmbak:UIImageView!
    var imageNamed:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action:
            #selector(swipeGestureHandler(_:)))
        leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action:
            #selector(swipeGestureHandler(_:)))
        rightRecognizer.direction = .right
        let downRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        downRecognizer.direction = .down
        let upRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        upRecognizer.direction = .up
        self.view.addGestureRecognizer(upRecognizer)
        self.view.addGestureRecognizer(leftRecognizer)
        self.view.addGestureRecognizer(downRecognizer)
        self.view.addGestureRecognizer(rightRecognizer)
    }
    @IBAction func myUnwindSegue(unwindSegue: UIStoryboardSegue){
    }
    @IBAction func NextAnimationButton(_ sender: Any){
        if(imageNamed == ""){
            self.labelAtas.text = "Lepaskan pelan-pelan..."
            self.labelBawah.text = "Bersama dengan perahu kertas ini\nkamu akan melepaskan bebanmu"
            imageNamed = "tampilan 1"
        }
        if(imageNamed == "tampilan 1"){
            self.labelAtas.isHidden = true
            self.labelBawah.isHidden = true
            self.shadowView.isHidden = true
            self.borderOmbak.isHidden = true
            self.labelKalimat.isHidden = true
            imageNamed = "Lipat_kertas1"
            kertasLipat.image = UIImage.init(named: imageNamed)
        }
        if(imageNamed == "Lipat_kertas3"){
            self.labelAtas.isHidden = true
            self.labelBawah.isHidden = true
            self.shadowView.isHidden = true
            self.borderOmbak.isHidden = true
            self.labelKalimat.isHidden = true
            imageNamed = "Lipat_kertas4"
            kertasLipat.image = UIImage.init(named: imageNamed)
        }
        if(imageNamed == "Lipat_kertas7"){
            self.labelAtas.isHidden = true
            self.labelBawah.isHidden = true
            self.shadowView.isHidden = true
            self.borderOmbak.isHidden = true
            self.labelKalimat.isHidden = true
            imageNamed = "Lipat_kertas8"
            kertasLipat.image = UIImage.init(named: imageNamed)
        }
        if(imageNamed == "Selesai"){
            performSegue(withIdentifier: "MelipatkeKirim", sender: Any?.self)
        }
    }
    @IBAction func swipeGestureHandler(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if imageNamed == "Lipat_kertas4"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas5")
                imageNamed = "Lipat_kertas5"
                print("4To5")
            }
            if imageNamed == "Lipat_kertas6"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas7")
                imageNamed = "Lipat_kertas7"
                self.labelAtas.text = "Ya seperti itu!"
                self.labelBawah.text = "Aku bangga sekali denganmu.\nAyo sedikit lagi!"
                self.borderOmbak.image = UIImage.init(named: "Otter_Menari2")
                self.labelAtas.isHidden = false
                self.labelBawah.isHidden = false
                self.shadowView.isHidden = false
                self.borderOmbak.isHidden = false
                self.labelKalimat.isHidden = false
                print("6To7")
            }
            if imageNamed == "Lipat_kertas11"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas12")
                imageNamed = "Lipat_kertas12"
                print("11To12")
            }
            if imageNamed == "Lipat_kertas15"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas16")
                imageNamed = "Lipat_kertas16"
                print("15To16")
            }
            if imageNamed == "Lipat_kertas16"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas17")
                imageNamed = "Selesai"
                self.labelAtas.text = "Kamu Berhasil!"
                self.labelBawah.text = "Aku sangat bangga padamu!"
                self.borderOmbak.image = UIImage.init(named: "Otter_Menari3")
                self.labelAtas.isHidden = false
                self.labelBawah.isHidden = false
                self.shadowView.isHidden = false
                self.borderOmbak.isHidden = false
                self.labelKalimat.isHidden = false
                print("segue")
            }
        }
        if sender.direction == .right {
            if imageNamed == "Lipat_kertas5"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas6")
                imageNamed = "Lipat_kertas6"
                print("5To6")
            }
            if imageNamed == "Lipat_kertas10"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas11")
                imageNamed = "Lipat_kertas11"
                print("10To11")
            }
            if imageNamed == "Lipat_kertas15"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas16")
                imageNamed = "Lipat_kertas16"
                print("15To16")
            }
            if imageNamed == "Lipat_kertas16"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas17")
                imageNamed = "Selesai"
                self.labelAtas.text = "Kamu Berhasil!"
                self.labelBawah.text = "Aku sangat bangga padamu!"
                self.borderOmbak.image = UIImage.init(named: "Otter_Menari3")
                self.labelAtas.isHidden = false
                self.labelBawah.isHidden = false
                self.shadowView.isHidden = false
                self.borderOmbak.isHidden = false
                self.labelKalimat.isHidden = false
                print("segue")
            }
        }
        if sender.direction == .down {
            if imageNamed == "Lipat_kertas1"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas3")
                imageNamed = "Lipat_kertas3"
                self.labelAtas.text = "Terus tarik napas dan keluarkan"
                self.labelBawah.text = "seiring kamu melipat\nperahu kertas ini"
                self.borderOmbak.image = UIImage.init(named: "Otter_Menari1")
                self.labelAtas.isHidden = false
                self.labelBawah.isHidden = false
                self.shadowView.isHidden = false
                self.borderOmbak.isHidden = false
                self.labelKalimat.isHidden = false
                print("1To3")
            }
            if imageNamed == "Lipat_kertas12"
            {
                imageNamed = "Lipat_kertas13"
                kertasLipat.image = UIImage.init(named: imageNamed)
                print("13To14")
                
            }
        }
        if sender.direction == .up {
            if imageNamed == "Lipat_kertas8"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas10")
                imageNamed = "Lipat_kertas10"
                print("8To10")
            }
            if imageNamed == "Lipat_kertas13"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas14")
                imageNamed = "Lipat_kertas14"
                print("13To14")
            }
            if imageNamed == "Lipat_kertas14"
            {
                kertasLipat.image = UIImage.init(named: "Lipat_kertas15")
                imageNamed = "Lipat_kertas15"
                print("14To15")
            }
        }
    }
    
    
}
