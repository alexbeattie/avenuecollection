//
//  AveTeamCollectionViewController.swift
//  ave6
//
//  Created by Alex Beattie on 9/1/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse


class AveTeamCollectionViewController: UICollectionViewController {

    @IBOutlet var aveCollectionView: UICollectionView!
    var recentListings:[PFObject] = []

    @IBOutlet weak var agentImage: UIImageView!

    
//    override func viewWillAppear(_ animated: Bool) {
//        queryAllListings()
//    
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = collectionView!.frame.width / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "avenuelogotype")
        imageView.image = image
        navigationItem.titleView = imageView

        queryAllAgents()


    }
    @IBAction func refresh(_ sender: Any) {
        queryAllAgents()
        aveCollectionView?.reloadData()
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return recentListings.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as? AgentCollectionViewCell
    
        var listingClass = PFObject(className: "Team")
        listingClass = recentListings[indexPath.row]
        DispatchQueue.main.async(execute: { () -> Void in
            
            let imageFile = listingClass["agentImage"] as? PFFile
            imageFile?.getDataInBackground { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        cell?.agentImage.image = UIImage(data: imageData)
                    }
                    //cell.activityIndicator.stopAnimating()
                }
            }
        })
        if let listingName = listingClass["agentName"] as? String {
            cell?.agentName.text = listingName
        }
        
        return cell!
    }
    func queryAllAgents() {
        recentListings.removeAll()
        
        let query = PFQuery(className: "Team")
        
//        query.order(byDescending: "price")
        query.cachePolicy = .networkElseCache
        
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects  {
                    for object in objects {
                        self.recentListings.append(object)
                         print(object)
                    }
                }
                self.aveCollectionView.reloadData()
                //self.view.hideHUD()
            } else {
                print("alex")
                
            }
        }
    }
    var cellSelected : Int = 0
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected = indexPath.item
        print("Did select!")
        let barBtn = UIBarButtonItem()
        barBtn.title = ""
        navigationItem.backBarButtonItem = barBtn
        
        var listingClass = PFObject(className: "Team")
        listingClass = recentListings[indexPath.row]
        
        let agentVC =  storyboard!.instantiateViewController(withIdentifier: "AgentDetails") as! AgentDetailViewController
        agentVC.propObj = listingClass
        navigationController?.pushViewController(agentVC, animated: true)
        
    }

}
