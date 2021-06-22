//
//  GenreClassCell.swift
//  GameWO
//
//  Created by Belal medhat on 9/5/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class GenreClassCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }
    @IBOutlet weak var GamesCount: UILabel!
    @IBOutlet weak var GenreName: UILabel!
    @IBOutlet weak var GenreImage: UIImageView!
    
}
