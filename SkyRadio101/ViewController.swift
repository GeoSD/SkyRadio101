//
//  ViewController.swift
//  SkyRadio101
//
//  Created by Georgy Dyagilev on 19/01/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playpauseButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    let stringURL = "https://www.skyradio.nl/player/skyradio.pls"
    
    var playerItem: AVPlayerItem!
    var player: AVPlayer!
    var audioSession = AVAudioSession.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioSession()
        setupPlayer()
        setupCommandCenter()
    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        if player.rate == 0 {
            statusLabel.text = "Playing"
            player.play()
        } else {
            statusLabel.text = "Paused"
            player.pause()
        }
        
    }
    
    func setupPlayer() {
        guard let url = URL(string: stringURL) else {
            print("Error while convert URL")
            return
        }
        statusLabel.text = "Paused"

        player = AVPlayer(url: url)
    }
    
    func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.allowAirPlay, .allowBluetooth, .allowBluetoothA2DP, .mixWithOthers])
            try audioSession.setActive(true)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            print("do block works fine.")
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.\(error)")
        }
    }
    
    func setupCommandCenter() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "SkyRadio 101"]
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.player.play()
            self.statusLabel.text = "Playing"
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.player.pause()
            self.statusLabel.text = "Paused"
            return .success
        }
    }
    
}


