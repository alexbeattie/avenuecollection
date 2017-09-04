//
//  AboutNew.swift
//  ave6
//
//  Created by Alex Beattie on 8/22/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse

class AboutNew: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    
    
    @IBOutlet weak var tableView:UITableView!

    
    var propObj = PFObject(className: "Bio")
    var bioStuff:[PFObject] = []
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var imageView2 = UIImageView()
    var parallexFactor: CGFloat = 2.0
    var imageHeight: CGFloat = 380.0 {
        didSet {
            moveImage()
        }
    }
    var scrollOffset: CGFloat = 0 {
        didSet {
            moveImage()
        }
    }
    
    func startActivityIndicator() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView2.image = UIImage(named: "TERE_MOYA_017-1")
        self.tableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        imageView2.contentMode = .scaleAspectFill
        imageView2.clipsToBounds = true
        tableView.addSubview(imageView2)
        tableView.sendSubview(toBack:imageView2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
//
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "team-foster-logo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        startActivityIndicator()
        queryForTable()
        tableView.reloadData()
        activityIndicator.isHidden = true
        activityIndicator.removeFromSuperview()

    }


    func queryForTable() {
    let query = PFQuery(className: "Bio")
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
    
    //step 8: Define method for image location changes
    func moveImage() {
        let imageOffset = (scrollOffset > 0) ? scrollOffset / parallexFactor : 0
        let imageHeight = (scrollOffset > 0) ? self.imageHeight : self.imageHeight - scrollOffset
        self.imageView2.frame = CGRect(x: 0, y: -imageHeight + imageOffset, width: view.bounds.size.width, height: imageHeight)
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "About Description", for: indexPath) as? AboutCell else {  return UITableViewCell() }
        
        var propObj = PFObject(className: "Bio")
        propObj = bioStuff[indexPath.row]
        
       
        cell.bioDescLbl?.text = propObj["bio"] as? String
        if let eachName = propObj["name"] as? String {
            cell.theName?.text = eachName.uppercased()
            
        }

        return cell
    }

}
