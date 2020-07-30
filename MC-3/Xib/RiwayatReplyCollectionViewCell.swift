//
//  RiwayatReplyCollectionViewCell.swift
//  MC-3
//
//  Created by Andrew Novansky Ignatius on 23/07/20.
//  Copyright © 2020 Abigail Aryaputra Sudarman. All rights reserved.
//

import UIKit
import AVFoundation
import CloudKit

class RiwayatReplyCollectionViewCell: UICollectionViewCell, AVAudioPlayerDelegate {
    
    var audio: CKAsset?
       var audioPlayerItem: AVPlayerItem?
       var avPlayer = AVAudioPlayer()
       var audioURL: NSURL?
       var audioAsset: AVAsset?
       var audioPath: URL?
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var replyLabel: UILabel!
    @IBOutlet var reportButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func playButtonReply(_ sender: Any) {
        preparePlayer()
               avPlayer.play()
    }
    static func nib() -> UINib {
        return UINib(nibName: "RiwayatReplyCollectionViewCell", bundle: nil)
    }
    func preparePlayer() {
        let path = getDocumentsDirectory().appendingPathComponent("ReceivedAudio.m4a")
        do {
            
            avPlayer = try AVAudioPlayer(contentsOf: path)
            avPlayer.delegate = self
            avPlayer.prepareToPlay()
            avPlayer.volume = 100
            print(path)
        } catch {
            print("error1")
        }
    }
    
    func getDocumentsDirectory() -> URL {
           var paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           
           
           return paths[0]
       }

}
