//
//  AgentViewController.swift
//  ave6
//
//  Created by Alex Beattie on 9/3/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse
import MapKit
import AVKit
import AVFoundation
import MessageUI
import SafariServices


class AgentDetailViewController: UIViewController, MFMailComposeViewControllerDelegate  {

//    @IBOutlet weak var playBtn: UIButton!
    
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var propName: UILabel!
    @IBOutlet var propImage: UIImageView!
    @IBOutlet weak var propDesc: UITextView!
    
    
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var propObj = PFObject(className: "Team")
    var listingClass = PFObject(className: "Team")

    
    var annotation:MKAnnotation!
    var pointAnnotation:MKPointAnnotation!
    var pinView:MKPinAnnotationView!
    var region: MKCoordinateRegion!
    var mapType: MKMapType!
    
    var movieList:[PFObject] = []
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    

    
    
    
    
    
    
    
    
    
//    @IBAction func playBtn(_ sender: Any) {
//        
//        print("button tapped")
//        playVideo()
//    }
//    func startActivityIndicator() {
//
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//    }
//    func stopActivityIndicator() {
//        activityIndicator.stopAnimating()
//    }
//    func playVideo() {
//
//        startActivityIndicator()
//        var videoUrl:String? = self.propObj["movieFile"] as? String
//        let query = PFQuery(className: "allListings")
//        query.findObjectsInBackground { (object, error) in
//            if (error == nil && object != nil) {
//                if let video = self.propObj["moviefile"] as? String {
//                    let videoFile = video
//                    videoUrl = videoFile
//                }
//            }
//            self.setupVideoPlayerWithURL(url: NSURL(string: videoUrl!)!)
//        }
//    }
//
//    func setupVideoPlayerWithURL(url:NSURL) {
//        let player = AVPlayer(url: url as URL)
//        let playerController = AVPlayerViewController()
//        
//        playerController.player = player
//        present(playerController, animated: true) {
//            player.play()
//            self.stopActivityIndicator()
//        }
//    }
    
    @IBAction func share(_ sender: Any) {
        
        let textToShare = propObj["agentName"]! as! String
        guard let site = NSURL(string: propObj["url"]! as! String) else { return }
        let objectsToShare = [textToShare, site] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        activityVC.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAgentDetails()
//         queryAgentListings()
        containerScrollView.contentSize = CGSize(width:containerScrollView.frame.size.width, height:detailsView.frame.size.height + detailsView.frame.origin.y)

    }
    
    // MARK: UICollectionViewDataSource
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return recentListings.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? AgentCollectionViewCell
//
//        var listingClass = PFObject(className: "Team")
//        listingClass = recentListings[indexPath.row]
//        DispatchQueue.main.async(execute: { () -> Void in
//
//            let imageFile = listingClass["agentImage"] as? PFFile
//            imageFile?.getDataInBackground { (imageData, error) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        cell?.agentImage.image = UIImage(data: imageData)
//                    }
//                    //cell.activityIndicator.stopAnimating()
//                }
//            }
//        })
//        if let listingName = listingClass["agentName"] as? String {
//            cell?.agentName.text = listingName
//        }
//
//        return cell!
//    }
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func queryAgentListings() {
//        agentListings.removeAll()
//
//        let query = PFQuery(className: "AgentListings")
//
//        //        query.order(byDescending: "price")
//        query.cachePolicy = .networkElseCache
//
//        query.findObjectsInBackground { (objects, error) -> Void in
//            if error == nil {
//                if let objects = objects  {
//                    for object in objects {
//                        self.agentListings.append(object)
//                        print(object)
//                    }
//                }
//                self.agentDetailCollectionView.reloadData()
//                //self.view.hideHUD()
//            } else {
//                print("alex")
//
//            }
//        }
//    }
    override func viewWillAppear(_ animated: Bool) {
        print("Im in View Will Appear")
        super.viewWillAppear(animated)
        self.title = propObj["agentName"] as? String
        
   
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.toolbar.isTranslucent = true
        
        
        self.navigationController?.toolbar.tintColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)
        
    }
    
    
    
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var previewScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var image1: UIImageView!

    @IBOutlet weak var descriptionTxt: UITextView!
    
    func getAgentDetails() {
        
        
//        if propObj[PROP_PRICE] != nil { propPrice.text = "\(propObj[PROP_PRICE]!)"
//        } else { propPrice.text = "N/A" }
        if propObj["agentName"] != nil { propName.text = "\(propObj["agentName"]!)"
        } else { propName.text = "N/A" }
        
        
        if propObj["agentDetails"] != nil {  propDesc.text = "\(propObj["agentDetails"]!)"
        } else { propDesc.text = "Details are not available" }
        propDesc.sizeToFit()
        detailsView.frame.origin.y = propDesc.frame.size.height + propDesc.frame.origin.y + 10
        DispatchQueue.global(qos: .userInitiated).async { // 1
            let imageFile = self.propObj["agentImage"] as? PFFile
            imageFile?.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.image1.image = UIImage(data: imageData)
                    } } }
            
//            let imageFile2 = self.propObj[PROP_IMAGE2] as? PFFile
//            imageFile2?.getDataInBackground{ (imageData, error) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        self.image2.image = UIImage(data:imageData)
//                        self.image2.frame.origin.x = self.view.frame.size.width
//                    } } }
//
//            let imageFile3 = self.propObj[PROP_IMAGE3] as? PFFile
//            imageFile3?.getDataInBackground { (imageData, error) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        self.image3.image = UIImage(data:imageData)
//                        self.image3.frame.origin.x = self.view.frame.size.width*2
//                    } } }
            
            // Set previewScrollView content size
//            self.previewScrollView.contentSize = CGSize(width:self.view.frame.size.width * 3.0, height: self.previewScrollView.frame.size.height-44)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
//        annoView.pinTintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
//        annoView.animatesDrop = true
//        annoView.canShowCallout = true
//        let swiftColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
//        annoView.centerOffset = CGPoint(x: 100, y: 400)
//        annoView.pinTintColor = swiftColor
//
//        // Add a RIGHT CALLOUT Accessory
//        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
//        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
//        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
//        rightButton.clipsToBounds = true
//        rightButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
//
//        annoView.rightCalloutAccessoryView = rightButton
//
//
//        let leftIconView = UIImageView()
//        leftIconView.contentMode = .scaleAspectFill
//        if let thumbImage = propObj["imageFile"] as? PFFile {
//            thumbImage.getDataInBackground() { (imageData, error) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        leftIconView.image = UIImage(data:imageData)
//
//
//                    }
//                }
//            }
//        }
//        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
//        leftIconView.bounds = newBounds
//        annoView.leftCalloutAccessoryView = leftIconView
//
//
//        return annoView
//
//    }
    
//    func goOutToGetMap() {
//        let addressItems = PFGeoPoint(latitude: (self.propObj["addressItems"] as AnyObject).latitude, longitude: (self.propObj["addressItems"] as AnyObject).longitude)
//        if let theLocation = self.propObj["addressItems"] as? PFGeoPoint {
//            CLLocationCoordinate2DMake(addressItems.latitude, addressItems.longitude)
//            print(theLocation)
//        }
//        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake((self.propObj["addressItems"] as AnyObject).latitude, (self.propObj["addressItems"] as AnyObject).longitude)
//        
//        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
//        
//        let item = MKMapItem(placemark: placemark)
//        item.name = self.propObj["name"] as? String
//        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 2,
//                                         MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: placemark.coordinate),
//                                         MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
//        
//        
//    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//        
//        let alertController = UIAlertController(title: nil, message: "Driving directions", preferredStyle: .actionSheet)
//        let OKAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
//            self.goOutToGetMap()
//        }
//        alertController.addAction(OKAction)
//        
//        present(alertController, animated: true) {
//            
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            
//        }
//        alertController.addAction(cancelAction)
//    }
    
    
    @IBAction func mailButt(sender: AnyObject) {
        //        let listingClass = PFObject(className: "Recipe")
        _ = sender as! UIBarButtonItem
        
        let mailComposer = MFMailComposeViewController()
        
        
        
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["artisanb@me.com"])
        mailComposer.setSubject("[iPhone App Contact] Interested in \(title!)")
        mailComposer.setMessageBody("Hello,<br>I saw <strong>\(propObj["name"]!)</strong> and would like some more information about this property<br>Thanks,<br>Regards", isHTML: true)
        
        if MFMailComposeViewController.canSendMail() {
            present(mailComposer, animated: true, completion: nil)
        } else {
            
            let alertController = UIAlertController(title: "Li Read Group", message: "Your device cannot send emails. Please configure an email address into Settings -> Mail, Contacts, Calendars.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func gotToAllMap(_ sender: Any) {
        performSegue(withIdentifier: "toAllListingsMapVC", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        startActivityIndicator()
    }
    
    
    
    
    
    // Goto weblink
    @IBOutlet weak var goToLinkNow: UIButton!
    @IBOutlet weak var webLinkBtn: UIBarButtonItem!
    @IBAction func goToWebLink(_ sender: UIBarButtonItem) {
        if let videoURL = propObj["url"] as? String {
            if let newVideoUrl = URL(string: videoURL) {
                
                let safariVC = SFSafariViewController(url: newVideoUrl)
                present(safariVC, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    
    
}

