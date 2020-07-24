//
//  RiwayatReplyCollectionViewCell.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class RiwayatReplyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var replyLabel: UILabel!
    @IBOutlet var reportButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RiwayatReplyCollectionViewCell", bundle: nil)
    }
}
