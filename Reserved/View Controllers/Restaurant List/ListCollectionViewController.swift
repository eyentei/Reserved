//
//  ListCollectionViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 08/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation
import GeoQueries
import MapKit


private let reuseIdentifier = "RestaurantCell"

class ListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    var sortBy: String = "Name"
    var restaurants: Array<Restaurant>!
    var restaurant: Restaurant!
    var realm: Realm!
    
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let itemsPerRow = 2.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        restaurants = Array(realm.objects(Restaurant.self).sorted(byKeyPath: "lowercaseName"))
    }

    override func viewDidAppear(_ animated: Bool) {
       
        switch sortBy {
        case "Name":
            restaurants = Array(realm.objects(Restaurant.self).sorted(byKeyPath: "lowercaseName"))
            break
        case "Price":
            restaurants = Array(realm.objects(Restaurant.self).sorted(byKeyPath: "price"))
            break
        case "Distance":
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
            
            let coords: CLLocationCoordinate2D = locationManager.location!.coordinate
           
            restaurants = try! realm.findNearby(type: Restaurant.self, origin: coords, radius: 50000, sortAscending: true)
            
            break
        default:
            break
        }
        

        self.collectionView.reloadData()

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListCollectionViewCell
       
        let rest = restaurants![indexPath.row]
        cell.restImage.image = UIImage(named: rest.pic)
        cell.restName.text = rest.name
        cell.restPrice.text = rest.price
        
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = insets.left*CGFloat(itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        let heightPerItem =  widthPerItem*1.2

        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        restaurant = restaurants[indexPath.row]
        performSegue(withIdentifier: "toRestaurant", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRestaurant" {
            let vc = segue.destination as! RestaurantViewController
            vc.restaurant = restaurant
        }
    }
    
}
