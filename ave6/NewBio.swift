//
//  NewBio.swift
//  ave6
//
//  Created by Alex Beattie on 9/2/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class NewBio: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewTwo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        textViewTwo.textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "team-foster-logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
