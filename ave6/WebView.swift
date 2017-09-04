//
//  WebView.swift
//  ave6
//
//  Created by Alex Beattie on 8/26/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import SafariServices

class WebView: UIViewController, SFSafariViewControllerDelegate, UITabBarControllerDelegate, UITabBarDelegate {



    
    

    
//    func showSite() {
//        let theUrl = "http://avenueproperties.com"
//        let newUrl = URL(string:theUrl)
//
//        let safariVC = SFSafariViewController(url: newUrl!)
//        safariVC.delegate = self
//        tabBarController?.present(safariVC, animated: true, completion: nil)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self

        
        
//        showSite()
        
        // Do any additional setup after loading the view.
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        controller.dismiss(animated: true, completion: nil)
        print(controller)
//        let tvc = ListingsTVC()

//        unwind(for: UIStoryboardSegue, towardsViewController: tvc)
//        present(tvc, animated: true, completion: nil)
        
    }
 
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 3 {
            //do your stuff
            print("fuck you")
            let theUrl = "http://avenueproperties.com"
            let newUrl = URL(string:theUrl)
            
            let safariVC = SFSafariViewController(url: newUrl!)
            safariVC.delegate = self
            showDetailViewController(safariVC, sender: self)
//            present(safariVC, animated: true, completion: nil)

        }
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
