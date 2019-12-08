//
//  RestaurantViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class RestaurantViewController: UIViewController {

    var restaurant:Restaurant!
    
    @IBOutlet weak var restImage: UIImageView!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restAddress: UILabel!
    @IBOutlet weak var restPhone: UILabel!
    @IBOutlet weak var restWebsite: UILabel!
    
   

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: restaurant.latitude, longitude:restaurant.longitude)) { (places, error) in
                   if error == nil{
                       if let place = places{
                       
                        self.restAddress.text = place[0].postalAddress?.street              
                       }
                   }
               }

        restImage.image = UIImage(named:restaurant.pic)
        restName.text=restaurant.name
        
        restPhone.text=restaurant.phone
        restWebsite.text=restaurant.website
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
