//
//  ViewController.swift
//  SkyRadio101
//
//  Created by Georgy Dyagilev on 19/01/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playpauseButton: UIButton!
    
    let stringURL = "https://www.skyradio.nl/player/skyradio.pls"
    
    var playerItem: AVPlayerItem!
    var player: AVPlayer!
    var audioSession = AVAudioSession.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: stringURL) else {
            print("Error while convert URL")
            return
        }
        
        let audioURLAsset = AVURLAsset(url: url)
        playerItem = AVPlayerItem(asset: audioURLAsset)
        player = AVPlayer(playerItem: playerItem)
    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        if player.rate == 0 {
            player.play()
        } else {
            player.pause()
        }
    }
}


