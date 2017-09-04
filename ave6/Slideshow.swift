//
//  Slideshow.swift
//  ave6
//
//  Created by Alex Beattie on 8/27/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse

class Slideshow: UIViewController, UIScrollViewDelegate {
    
    var newObj = PFObject(className: "ourStory")
    var myArray:[PFObject] = []
    
//    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var image:UIImageView!
    var data:[PFObject]!
    
    @IBOutlet weak var theNameLbl: UILabel!
    override func viewDidLoad() {
        let query = PFQuery(className: "ourStory")
        query.findObjectsInBackground { (results, error) -> Void in
            self.data = results
            print(self.data)

        }
        if let listingName = self.newObj["about"] as? String {
            self.descriptionTxt.text = listingName
            print(descriptionTxt)
        }
    
//        self.descriptionTxt.text = self.newObj["about"] as? String
        self.theNameLbl.text = self.newObj["theTitle"] as? String
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let query = PFQuery(className: "ourStory")
//        query.findObjectsInBackground { (objects, error) in
//            if error == nil {
//                if let objects = objects {
//                    for object in objects  {
//                        //
//                        if self.newObj["theTitle"] != nil { self.theNameLbl.text = "\(self.newObj["theTitle"]!)"
//                        } else { self.theNameLbl.text = "N/A" }
//                        if self.newObj["about"] != nil { self.theNameLbl.text = "\(self.newObj["about"]!)"
//                        } else { self.descriptionTxt.text = "N/A" }
//
//                        //                                self.descriptionTxt.text = self.propObj["about"] as? String
//                        //                                self.theNameLbl.text = self.propObj["theTitle"] as? String
//                        //                                print(self.theNameLbl.text)
//                        //                                DispatchQueue.main.async(execute: { () -> Void in
//                        //
//                        //                                    let imageFile = self.propObj[PROP_IMAGE] as? PFFile
//                        //                                    imageFile?.getDataInBackground { (imageData, error) -> Void in
//                        //                                        if error == nil {
//                        //                                            if let imageData = imageData {
//                        //                                                self.image.image = UIImage(data: imageData)
//                        //                                            }
//                        //                                            //cell.activityIndicator.stopAnimating()
//                        //                                        }
//                        //                                    }
//                        //                                })
//                        self.myArray.append(object)
//                        print(objects)
//
//                    }
//                }
//            }
//        }
//        getDetails()
//
//
//    }
    
//    func getDetails() {
////                if let theName = newObj["about"] as? String {
////                    self.descriptionTxt.text = theName
////                    print(theName)
////                }
//                let query = PFQuery(className: "ourStory")
//                query.findObjectsInBackground { (objects, error) -> Void in
//                    if error == nil {
//                        if let objects = objects {
//                            for object in objects  {
////
//                                if self.newObj["theTitle"] != nil { self.theNameLbl.text = "\(self.newObj["theTitle"]!)"
//                                } else { self.theNameLbl.text = "N/A" }
//                                if self.newObj["about"] != nil { self.theNameLbl.text = "\(self.newObj["about"]!)"
//                                } else { self.descriptionTxt.text = "N/A" }
//
////                                self.descriptionTxt.text = self.propObj["about"] as? String
////                                self.theNameLbl.text = self.propObj["theTitle"] as? String
////                                print(self.theNameLbl.text)
////                                DispatchQueue.main.async(execute: { () -> Void in
////
////                                    let imageFile = self.propObj[PROP_IMAGE] as? PFFile
////                                    imageFile?.getDataInBackground { (imageData, error) -> Void in
////                                        if error == nil {
////                                            if let imageData = imageData {
////                                                self.image.image = UIImage(data: imageData)
////                                            }
////                                            //cell.activityIndicator.stopAnimating()
////                                        }
////                                    }
////                                })
//                                self.myArray.append(object)
//                                print(objects)
//
//                            }
//                        }
//                    }
//                }
//
//    }
    
    
}

