//
//  MercusuarCollectionViewCell.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class MercusuarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var replyLabel: UILabel!
    @IBOutlet var numberOfLikes: UILabel!
    @IBOutlet var top3Label: UILabel!
    @IBOutlet var reportButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "MercusuarCollectionViewCell", bundle: nil)
    }
    
}
