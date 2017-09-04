//
//  OurStory.swift
//  ave6
//
//  Created by Alex Beattie on 8/27/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse

class OurStory: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{

    @IBOutlet weak var tableView:UITableView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var propObj = PFObject(className: "ourStory")
    var bioStuff:[PFObject] = []
    var imageView = UIImageView()
    var imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))

    var parallexFactor: CGFloat = 0.0
    var imageHeight: CGFloat = 200.0 {
        didSet {
            moveImage()
        }
    }
    var scrollOffset: CGFloat = 0 {
        didSet {
            moveImage()
        }
    }
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    func startActivityIndicator() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
   
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        startActivityIndicator()
//        navigationItem.title? = "OUR STORY"
//        self.title = "Our Story"
        imageView2.contentMode = .scaleAspectFit
        let image = UIImage(named: "avenuelogotype")
        imageView2.image = image
        navigationItem.titleView = imageView2
        

        self.imageView.image = UIImage(named: "partnersMay2017_1")
        self.tableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        self.imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.tableView.addSubview(imageView)
        self.tableView.sendSubview(toBack:imageView)
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.estimatedRowHeight = 140
        //
        queryForTable()
        tableView.reloadData()
        
    }
    

    
   
    func queryForTable() {
        let query = PFQuery(className: "ourStory")
        query.cachePolicy = .networkElseCache

        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects  {
                        self.bioStuff.append(object)
                        //                        print(objects)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    //    get image
    //    let leftIconView = UIImageView()
    //    leftIconView.contentMode = .scaleAspectFill
    //
    //    if let thumbImage = self.propObj["imageFile"] as? PFFile {
    //        thumbImage.getDataInBackground() { (imageData, error) -> Void in
    //            if error == nil {
    //                if let imageData = imageData {
    //                    leftIconView.image = UIImage(data:imageData)
    //                }
    //            }
    //        }
    //    }
    
    //step 8: Define method for image location changes
    func moveImage() {
        let imageOffset = (scrollOffset > 0) ? scrollOffset / parallexFactor : 0
        let imageHeight = (scrollOffset > 0) ? self.imageHeight : self.imageHeight - scrollOffset
        self.imageView.frame = CGRect(x: 0, y: -imageHeight + imageOffset, width: view.bounds.size.width, height: imageHeight)
    }
    
    //Step 9 : update image position after layout changes
    override func viewDidLayoutSubviews() {
        moveImage()
    }
    
    //step 10: update scrolloffset on tableview scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffset = tableView.contentOffset.y + imageHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bioStuff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Our Story", for: indexPath) as? OurStoryCell else {  return UITableViewCell() }
        
        var propObj = PFObject(className: "ourStory")
        propObj = bioStuff[indexPath.row]
        
        
        cell.bioDescLbl?.text = propObj["about"] as? String
        if let eachName = propObj["theTitle"] as? String {
            cell.theName?.text = eachName.uppercased()
            
        }
        stopActivityIndicator()
        activityIndicator.removeFromSuperview()
        return cell
    }
    
}

