//
//  UIMapAddressCheckingViewController.swift
//  App for automation
//
//  Created by Chongzheng Zhang on 2/27/18.
//  Copyright © 2018 Chongzheng Zhang. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation


class UIMapCurrentLoactionCheckingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var MapView: MKMapView!
    
    class myMapAnnotation : NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var subtitle: String?
        //  var label: UILabel?
        
        init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
            self.coordinate = coordinate
            
            self.title = title
            self.subtitle = subtitle
        }
    }
    
    var selectedLocationAddress: String!
    var selectedLocationCoordinate: CLLocationCoordinate2D!
    
    var currentUserAddressCoordinate = CLLocationCoordinate2D()
    
    var locationManager = CLLocationManager()
    
    /*Set location manager parameters for the map view. */
    func setLocationManagerParameters(_ locationManager: CLLocationManager) -> Void {
        
        // Ask for Authorisation from the User. For use in background.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        NSLog("@@@@@@@@@@@@@@@locationServicesEnabled = %d @@@@@@@@@@@@@@")
        
        let temp = CLLocationManager.locationServicesEnabled()
        print("locationServicesEnabled:%d", temp)
        
        if (CLLocationManager.locationServicesEnabled())
        {
            NSLog("@@@@@@@@@@@@@@@locationServicesEnabled@@@@@@@@@@@@@@")
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        MapView.delegate = self
        MapView.mapType = MKMapType.standard
        MapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.03
        let longDelta: CLLocationDegrees = 0.03
        
        let span = MKCoordinateSpanMake(latDelta, longDelta)
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(location, span)
        
        self.MapView.setRegion(region, animated: true)
        
        currentUserAddressCoordinate = location
        
        NSLog("@@@@@@@@@@@@@@@didUpdateToLocations@@@@@@@@@@@@@@")
        NSLog("didUpdateToLocations-location.latitude:%d", location.latitude)
        NSLog("didUpdateToLocations-location.longitude:%d", location.longitude)
        
        NSLog("didUpdateToLocations-currentUserAddressCoordinate.latitude:%d", currentUserAddressCoordinate.latitude)
        NSLog("didUpdateToLocations-currentUserAddressCoordinate.longitude:%d", currentUserAddressCoordinate.longitude)
        
   
        
        self.locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}







