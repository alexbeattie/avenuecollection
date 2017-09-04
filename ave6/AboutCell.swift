//
//  AboutCell.swift
//  ave6
//
//  Created by Alex Beattie on 8/22/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse

class AboutCell: UITableViewCell {



    
    @IBOutlet weak var bioDescLbl: UILabel!
    
    @IBOutlet weak var theName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
