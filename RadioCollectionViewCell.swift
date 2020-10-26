//
//  RadioCollectionViewCell.swift
//  4Music
//
//  Created by Ivana Fidanovska on 9/29/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit

class RadioCollectionViewCell: UICollectionViewCell {

    @IBOutlet var radioImageView: UIImageView!
    @IBOutlet var favouriteButton: UIButton!
    
    let star = UIImage(named: "fullStar") as UIImage?
    let fullStar = UIImage(named: "favourite") as UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    @IBAction func favouriteButtonAction(_ sender: Any) {
////        let logoFImage = UIImage.self
////        let radioFName = ""
////        let radioFUrl = ""
//
        
//            favouriteButton.setBackgroundImage(star, for: .normal)
//        
//    }
}
