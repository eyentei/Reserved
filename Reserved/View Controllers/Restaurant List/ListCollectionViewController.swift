//
//  ListCollectionViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 08/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift


private let reuseIdentifier = "RestaurantCell"

class ListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var restaurants: Results<Restaurant>!
    var restaurant: Restaurant!
    var realm: Realm!
    
    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let itemsPerRow = 2.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        realm = try! Realm()
        restaurants = realm.objects(Restaurant.self)
    //self.collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


    override func viewWillAppear(_ animated: Bool) {
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
