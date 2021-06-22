//
//  StoreClassCell.swift
//  GameWO
//
//  Created by Belal medhat on 9/25/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
class StoreClassCell:UICollectionViewCell{

    var CallButton:(()->())?
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
    
     }
    @IBAction func Link(_ sender: UIButton) {
        CallButton?()
    }
    @IBOutlet weak var StoreImage: UIImageView!
    
    @IBOutlet weak var GamesCount: UILabel!
    @IBOutlet weak var StoreName: UILabel!
}
