//
//  TrailerClassCell.swift
//  GameWO
//
//  Created by Belal medhat on 9/28/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import AVKit
class TrailerClassCell: UICollectionViewCell {
    var video = AVPlayer()
    let videoPlayerInView = AVPlayerViewController()
     
    override func awakeFromNib() {
        super.awakeFromNib()
        
            VideoArea.addSubview(videoPlayerInView.view)
            videoPlayerInView.view.translatesAutoresizingMaskIntoConstraints = false
            videoPlayerInView.view.center = VideoArea.center
            videoPlayerInView.view.widthAnchor.constraint(equalTo: VideoArea.widthAnchor).isActive = true
            videoPlayerInView.view.heightAnchor.constraint(equalTo: VideoArea.heightAnchor).isActive = true
            videoPlayerInView.entersFullScreenWhenPlaybackBegins = true
        
    }
    @IBOutlet weak var VideoArea: UIView!
    func AddVideo(TrailerUrl:String){
        guard let Url = URL(string: TrailerUrl) else {return}
        video = AVPlayer(url:(Url))
        videoPlayerInView.player = video
     }

 

}
