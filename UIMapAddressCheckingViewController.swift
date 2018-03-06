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


class UIMapAddressCheckingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var checking_address: String! // passed from parent view controller by segie.
    
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
        MapView.showsUserLocation = false
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if(!locations.isEmpty)
        {
            //Change address to location with coordinate.
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(self.checking_address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        // handle no location found
                        return
                }
         
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
                let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                var region = MKCoordinateRegion(center: center, span: span)
                region.center = self.MapView.userLocation.coordinate
                self.MapView.setRegion(region, animated: true)
                
                let pin = myMapAnnotation(coordinate: location.coordinate, title: "Destination", subtitle: "App for automation")
                self.MapView.centerCoordinate = pin.coordinate
                self.MapView.addAnnotation(pin)
            }

        }
   
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






