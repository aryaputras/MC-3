//
//  MercusuarViewController.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit

class MercusuarViewController: UIViewController{
    
    @IBOutlet weak var mercusuarCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mercusuarCollectionView.register(MercusuarCollectionViewCell.nib(),forCellWithReuseIdentifier: "MercusuarCollectionViewCell")
        mercusuarCollectionView.delegate = self
        mercusuarCollectionView.dataSource = self
    }
}
extension MercusuarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //barang di collectionnya biasa pake counter
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MercusuarCollectionViewCell", for: indexPath) as! MercusuarCollectionViewCell
        // buat masukin isinya dari mana
        //        let item = Member[indexPath.item]
        //        cell.imageView.image = item.imageName
        //        cell.label1.text = item.role
        //        cell.label2.text = item.name
        return cell
    }
}
