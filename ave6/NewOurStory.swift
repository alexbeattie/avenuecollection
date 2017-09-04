//
//  NewOurStory.swift
//  ave6
//
//  Created by Alex Beattie on 9/2/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class NewOurStory: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var textView: UITextView!
    var imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        imageView2.contentMode = .scaleAspectFit
        let image = UIImage(named: "avenuelogotype")
        imageView2.image = image
        navigationItem.titleView = imageView2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
