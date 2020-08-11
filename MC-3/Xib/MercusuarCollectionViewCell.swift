//
//  MercusuarCollectionViewCell.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import CloudKit

class MercusuarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var replyLabel: UILabel!
    @IBOutlet var numberOfLikes: UILabel!
    @IBOutlet var top3Label: UILabel!
    @IBOutlet var reportButton: UIButton!
    @IBOutlet var likesButton: UIButton!
    var recordName = ""
    var recordID: CKRecord.ID?
    var likesLog = [""]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let tapGR = UITapGestureRecognizer(target: self, action: #selector(PostlistViewController.handleTap(_:)))
//        tapGR.delegate = self
//        tapGR.numberOfTapsRequired = 2
//        view.addGestureRecognizer(tapGR)
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "MercusuarCollectionViewCell", bundle: nil)
    }

    @IBAction func reportButton(_ sender: Any) {
        cell.view.performSegue
        view.performSegue(withIdentifier: "MercusuarToReport", sender: UIButton.self)
    }
}

