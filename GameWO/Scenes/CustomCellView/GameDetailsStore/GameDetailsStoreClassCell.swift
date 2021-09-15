//
//  GameDetailsStoreClassCell.swift
//  GameWO
//
//  Created by Belal medhat on 12/15/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
class GameDetailsStoreClassCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        StoreImage.clipsToBounds = true
       StoreImage.cornerRadius = StoreImage.layer.frame.width/2
    }
    private var StoresImagesDic:[Int:UIImage] = [1:#imageLiteral(resourceName: "Steam"),2:#imageLiteral(resourceName: "Xbox"),3:#imageLiteral(resourceName: "Playstation"),4:#imageLiteral(resourceName: "appstore"),5:#imageLiteral(resourceName: "gog"),6:#imageLiteral(resourceName: "nitindo"),7:#imageLiteral(resourceName: "Xbox"),8:#imageLiteral(resourceName: "GooglePlay"),9:#imageLiteral(resourceName: "itch"),11:#imageLiteral(resourceName: "epicgames")]
    
    @IBOutlet weak var StoreImage: UIImageView!
    
    @IBOutlet weak var StoreName: UILabel!
   
    func SetStore(name:String,id:Int){
        StoreImage.image = StoresImagesDic[id]
        StoreName.text = name
    }
}
