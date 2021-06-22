//
//  PopulorClassCell.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class PopulorClassCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderingtext.adjustsFontSizeToFitWidth = true
        orderingtext.minimumScaleFactor = 0.1
    
    }
    @IBOutlet weak var orderingtext: UILabel!
}
