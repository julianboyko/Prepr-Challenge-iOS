//
//  Julian_Boyko_iOS_Developer_MainVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-20.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit
import AVKit

class Julian_Boyko_iOS_Developer_MainVC: UIViewController {
    
    // MARK: Attributes
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpBackgroundVideo()
    }
    
    func setUpAttributes() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpBackgroundVideo() {
        
        let bundlePathToVideo = Bundle.main.path(forResource: "Ocean", ofType: "mp4")
        
        guard bundlePathToVideo != nil else { return }
        
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: bundlePathToVideo!))
        
        videoPlayer = AVPlayer(playerItem: playerItem)
        videoPlayer?.isMuted = true
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = CGRect(x: -50, y: 0, width: self.view.frame.size.width * 4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 1)
    }
}
