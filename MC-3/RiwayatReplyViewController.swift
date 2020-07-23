//
//  RiwayatReplyViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class RiwayatReplyViewController: UIViewController{
    
    @IBOutlet weak var riwayatReplyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        riwayatReplyCollectionView.register(RiwayatReplyCollectionViewCell.nib(), forCellWithReuseIdentifier: "RiwayatReplyCollectionViewCell")
        riwayatReplyCollectionView.delegate = self
        riwayatReplyCollectionView.dataSource = self
        
    }
}
extension RiwayatReplyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //barang di collectionnya biasa pake counter
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RiwayatCollectionCell", for: indexPath) as! RiwayatCollectionCell
        // buat masukin isinya dari mana
        //        let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        return cell
    }
}
