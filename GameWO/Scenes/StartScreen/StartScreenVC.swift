//
//  ViewController.swift
//  GameWO
//
//  Created by Belal medhat on 6/6/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import AVFoundation
class StartScreenVC: BaseViewController {
    var player :AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
            self.playStartVideo()
            self.view.backgroundColor = .clear
        
  
        // Do any additional setup after loading the view.
    }
    @IBOutlet var content: UIView!
    @IBAction func StartButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeRootNC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
//
    func playStartVideo(){
        if let path = Bundle.main.path(forResource: "GameWO", ofType: "mov") {
            player = AVPlayer(url: URL(fileURLWithPath: path))
            player!.automaticallyWaitsToMinimizeStalling = false
            player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
            let playerlayer = AVPlayerLayer(player: player)
            playerlayer.frame = self.view.frame

        playerlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view?.layer.insertSublayer(playerlayer, at: 0)
        player!.seek(to: CMTime.zero)
        self.player?.isMuted = true
        player!.play()
    NotificationCenter.default.addObserver(self, selector: #selector(playeritemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        }
        }
        @objc func playeritemDidReachEnd(){
        player!.seek(to: CMTime.zero)
        }

}

