//
//  RiwayatCollectionCell.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 20/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class RiwayatCollectionCell: UICollectionViewCell {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var suratLabel: UILabel!
    @IBOutlet var replyCountLabel: UILabel!
    @IBOutlet var tanggalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "RiwayatCollectionCell", bundle: nil)
    }
    
}
