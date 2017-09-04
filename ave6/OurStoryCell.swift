//
//  OurStoryCell.swift
//  ave6
//
//  Created by Alex Beattie on 8/27/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class OurStoryCell: UITableViewCell {

    @IBOutlet weak var bioDescLbl: UILabel!
    
    @IBOutlet weak var theName: UILabel!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func startActivityIndicator() {
        
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

}
