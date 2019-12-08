//
//  MapViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var restaurants: Results<Restaurant>!
    var restaurant: Restaurant!
    var realm: Realm!
    let locationManager = CLLocationManager()
    let regionRadius: Double = 1000

    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        restaurants = realm.objects(Restaurant.self)
        
        
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        map.delegate = self
        
        for rest in restaurants {
            let annotation = Annotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: rest.latitude, longitude: rest.longitude)
            annotation.title = rest.name
            annotation.restaurant = rest
            map.addAnnotation(annotation)
        }
        
        if let coor = map.userLocation.location?.coordinate{
            map.setCenter(coor, animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate

    map.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: locValue, span: span)
    map.setRegion(region, animated: true)

    let annotation = MKPointAnnotation()
    annotation.coordinate = locValue
    annotation.title = "You"
    annotation.subtitle = "current location"
    map.addAnnotation(annotation)

    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if view.annotation is Annotation {
            restaurant = (view.annotation as! Annotation).restaurant
            performSegue(withIdentifier: "toRestaurant", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toRestaurant" {
        let vc = segue.destination as! RestaurantViewController
        vc.restaurant = restaurant
        }
        
    }
}

class Annotation : MKPointAnnotation {
    var restaurant : Restaurant?
}
