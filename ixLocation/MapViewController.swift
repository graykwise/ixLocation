//
//  FirstViewController.swift
//  ixLocation
//
//  Created by Grayson Wise on 6/5/17.
//  Copyright © 2017 Grayson Wise. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, AddActivityDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //apple mapkit
        map.delegate = self
        UserDefaults.standard.set("red", forKey: "color")
        map.showsPointsOfInterest = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //locationManager.requestWhenInUseAuthorization()
        map.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        let span = MKCoordinateSpanMake(5, 5)
        let location = CLLocationCoordinate2D(latitude: -33.918861,longitude: 18.423300)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        map.showsPointsOfInterest = true
        map.isZoomEnabled = true
        setMapType()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setMapType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the users location from the array of locations
        let userLocation: CLLocation = locations[0] as CLLocation

        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.currentUserLocation = userLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        // An error occurred trying to retrieve users location
        print("Error \(error)")
    }
    
    func setMapType(){
        let mapType = UserDefaults.standard.string(forKey: "mapKey")
        
        if mapType != nil {
            if mapType == "hybrid"{
                map.mapType = .hybrid
            }
            if mapType == "satellite"{
                map.mapType = .satellite
            }
            if mapType == "standard"{
                map.mapType = .standard
            }
        }
        else{
            map.mapType = .standard
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        if(annotation.isMember(of: MKPointAnnotation.self)){
            
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myView")
        pinView.pinTintColor = setPinColor()
        pinView.animatesDrop = true
        return pinView
        }
        else{
            return nil
        }
    
    }
    
    func setPinColor() -> UIColor {
        
        if UserDefaults.standard.string(forKey: "color") == "green" {
            return .green
        }
        
        else if UserDefaults.standard.string(forKey: "color") == "blue"{
            return .blue
        }
        else{
            return .red
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addActivity"){
            
                let pinPoint = Pins(lat: currentUserLocation.coordinate.latitude, long: currentUserLocation.coordinate.longitude)
                let activityWithCurrentLocation = Activity()
                activityWithCurrentLocation?.location = pinPoint
                
                let navigationController = segue.destination as! UINavigationController
                let addActivityViewController = navigationController.topViewController as! AddActivityViewController
                addActivityViewController.delegate = self
                addActivityViewController.newActivity = activityWithCurrentLocation
        }
    }
    
    func didSaveActivity(activity: Activity) {
        print(activity)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(activity.location.lat, activity.location.long);
        annotation.title = activity.name
        map.showsUserLocation = true
        map.addAnnotation(annotation)
    }
    
    func didCancelActivity() {
        
    }

}
