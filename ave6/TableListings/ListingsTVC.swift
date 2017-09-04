//
//  ListingsTVC.swift
//  ave6
//
//  Created by Alex Beattie on 8/25/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse



class ListingsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    
    
    @IBOutlet var listingTableView: UITableView!
    
    var propObj = PFObject(className: "allListings")
    var myArray:[PFObject] = []
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var imageView = UIImageView()
    var parallexFactor: CGFloat = 2.0
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

   

    func queryForTable() {
        let query = PFQuery(className: "allListings")
        query.order(byDescending: "price")
        query.cachePolicy = .networkElseCache
//        query.cachePolicy = .cacheOnly
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects  {
                        self.myArray.append(object)
                        
                        //                        print(objects)
                    }
                    self.listingTableView.reloadData()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: "avenue-logo-three")
        self.listingTableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        self.imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.listingTableView.addSubview(imageView)
        self.listingTableView.sendSubview(toBack:imageView)
        listingTableView.tableFooterView = UIView(frame: CGRect.zero)

        
        listingTableView.delegate = self
        listingTableView.dataSource = self
        listingTableView.rowHeight = UITableViewAutomaticDimension
        listingTableView.rowHeight = 250
        listingTableView.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.7607843137, blue: 0.8196078431, alpha: 1)

        listingTableView.separatorColor = UIColor.clear
        
        startActivityIndicator()
        queryForTable()
        
        stopActivityIndicator()
        activityIndicator.isHidden = true
        activityIndicator.removeFromSuperview()
    }
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
        scrollOffset = listingTableView.contentOffset.y + imageHeight
    }
  

    // MARK: - Table view data source

 
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArray.count
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        activityIndicator.removeFromSuperview()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as? ListingsCell else { return UITableViewCell() }
        stopActivityIndicator()
        cell.listingImage.image = nil
        cell.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.7607843137, blue: 0.8196078431, alpha: 1)
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)

        var listingClass = PFObject(className: "allListings")
        listingClass = myArray[indexPath.row]
       
        if let theName = listingClass["name"] as? String {
            cell.nameLbl.text = theName.uppercased()
        }
        
        if let thePrice = listingClass["cost"] as? String {
            cell.priceLbl.text = thePrice
        }

//        activityIndicator.startAnimating()
//        activityIndicator.removeFromSuperview()
        
//        DispatchQueue.main.async(execute: { () -> Void in

            let imageFile = listingClass[PROP_IMAGE] as? PFFile

        imageFile?.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
//                        self.activityIndicator.stopAnimating()
//                        self.activityIndicator.removeFromSuperview()
//                        self.activityIndicator.startAnimating()

                        cell.listingImage.image = UIImage(data: imageData)
//                        self.activityIndicator.removeFromSuperview()

                    }
                    
                }
            }

//        })
//        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
//        cell.clipsToBounds = true

        return cell
    }
 

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var listingClass = PFObject(className: "allListings")
        listingClass = myArray[indexPath.row]
        let barBtn = UIBarButtonItem()
        barBtn.title = ""
        navigationItem.backBarButtonItem = barBtn
        let pdVC =  storyboard!.instantiateViewController(withIdentifier: "PropertyDetails") as! NewDetailViewController
        pdVC.propObj = listingClass
        navigationController?.pushViewController(pdVC, animated: true)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setToolbarHidden(true, animated: false)
        startActivityIndicator()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
