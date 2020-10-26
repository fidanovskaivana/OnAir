//
//  FavouritesTableViewCell.swift
//  4Music
//
//  Created by Ivana Fidanovska on 10/14/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    
    @IBOutlet var nameRadioLabel: UILabel!
    
    @IBOutlet var radioStationLogoImageView: UIImageView!
    
    var logoImage: UIImage?
    var logoName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
