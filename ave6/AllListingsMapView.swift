//
//  AllListingsMapView.swift
//  ave6
//
//  Created by Alex Beattie on 8/13/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class AllListingsMapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    var propObj = PFObject(className: PROP_CLASS_NAME)
    var annotation:MKAnnotation!
    var pointAnnotation: MKPointAnnotation!
    var pinView:MKPinAnnotationView!
    var listingClass = PFObject(className: "allListings")
    var addressItems = PFGeoPoint()
    var coords: CLLocationCoordinate2D?
    
    let vc = UIViewController()
    
    @IBOutlet weak var mapView: MKMapView!
    var mapItems = NSMutableArray()
    var recentListings = NSMutableArray()
    var locationManager:CLLocationManager!
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    
    @IBOutlet var propImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                navigationItem.title? = "ALL LISTINGS MAP"
        
        
        
    }
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        


        mapView.showsUserLocation = true
        let initialLocation = CLLocationCoordinate2D(latitude: 48.331965, longitude: -122.323164)
        let span = MKCoordinateSpan(latitudeDelta: 1.75, longitudeDelta: 1.75)
        let region = MKCoordinateRegion(center: initialLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        if mapView.annotations.count != 0 {
            annotation = mapView.annotations[0]
            mapView.removeAnnotation(annotation)
            
        }
    

        addAnnotations()
        


        

    }
    func addAnnotations() {
        let annotationQuery = PFQuery(className: PROP_CLASS_NAME)
        let swOfSF = PFGeoPoint(latitude:46.623988, longitude:-123.485756)
        let neOfSF = PFGeoPoint(latitude:48.878275, longitude:-120.307961)
        annotationQuery.cachePolicy = .networkElseCache

        annotationQuery.whereKey("addressItems",withinGeoBoxFromSouthwest: swOfSF, toNortheast: neOfSF)
        annotationQuery.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                
                print("Success")
                let mappedItems = objects! as [PFObject]
                
                for mappedItem in mappedItems {
                    
                    let point = mappedItem["addressItems"] as! PFGeoPoint
                    let theTitle = mappedItem["name"] as! String
                    let subTitle = mappedItem["cost"] as! String
                    //                    print(theTitle)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                    
                    //                    print(annotation.coordinate)
                    annotation.title = theTitle
                    annotation.subtitle = subTitle
                
                    self.mapView.addAnnotation(annotation)
                    print(annotation.coordinate.latitude, annotation.coordinate.longitude)
                    //                    print(mappedItem)
                }
                
            } else {
                print(error!)
            }
        }
    }
   
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
//                let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
                let swiftColor = #colorLiteral(red: 0.4352941215, green: 0.4431372583, blue: 0.4745098054, alpha: 1)

                pinView.pinTintColor = swiftColor
                pinView.animatesDrop = true
                pinView.canShowCallout = true
                
                
                let rightButton = UIButton(type: UIButtonType.detailDisclosure)
                rightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
                rightButton.clipsToBounds = true
                pinView.rightCalloutAccessoryView = rightButton
                
            }
      
        return pinView
       
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
        if control == view.rightCalloutAccessoryView {
            
            
            let annotation = MKPointAnnotation()
            let point = PFGeoPoint()
            annotation.title = propObj["name"] as? String
//            print(view.annotation?.title)
            
            
            annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)

            let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
            
            let mapItem = MKMapItem(placemark: placemark)

//            mapItem.name = propObj["name"] as? String
            mapItem.name = view.annotation!.title!
            print(mapItem.name)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            
            
            mapItem.openInMaps(launchOptions: launchOptions)
            print(view.annotation!.coordinate)
//            performSegue(withIdentifier: "PinDetails", sender: self)


        }
    }
  
}

