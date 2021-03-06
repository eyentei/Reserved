//
//  MainViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        realm = try! Realm()

        if realm.objects(Restaurant.self).count == 0 {
            
        try! realm.write() {
            let caro2 = Restaurant()
            caro2.name = "CARO Restaurant"
            caro2.price = "$$$"
            caro2.lat = 55.752
            caro2.lng = 37.622
            caro2.pic = "caro2"
            caro2.website = "caro-r.com"
            realm.add(caro2)
            
            let caro = Restaurant()
            caro.name = "CARO Bistro&Lounge"
            caro.price = "$$"
            caro.lat = 55.751
            caro.lng = 37.623
            caro.pic =  "caro"
            caro.website = "caro-bl.com"
            realm.add(caro)
            
            let katlerio = Restaurant()
            katlerio.name = "Katlerio Restaurant"
            katlerio.price = "$$"
            katlerio.lat = 55.755
            katlerio.lng = 37.625
            katlerio.pic = "katlerio"
            katlerio.website = "katlerio.com"
            realm.add(katlerio)
            
            let cassies = Restaurant()
            cassies.name = "CASSIE'S"
            cassies.price = "$$$"
            cassies.lat = 55.758
            cassies.lng = 37.621
            cassies.pic = "cassies-kitchen"
            cassies.website = "cassies-kitchen.com"
            realm.add(cassies)
            
            let elegance = Restaurant()
            elegance.name = "Elegance Restaurant"
            elegance.price = "$$"
            elegance.lat = 55.78
            elegance.lng = 37.61
            elegance.pic = "elegance"
            elegance.website = "elegance-restaurant.com"

            realm.add(elegance)

            
            let casa = Restaurant()
            casa.name = "Casa Carreno"
            casa.price = "$"
            casa.lat = 55.79
            casa.lng = 37.62
            casa.pic = "casa-carreno"
            casa.website = "casa-restaurant.com"

            realm.add(casa)

            
            let hailey = User()
            hailey.name = "Hailey Bieber"
            hailey.email = "hailey@bieber.com"
            
            hailey.password = "123"
            hailey.number = "+1(999)123-12-23"
            hailey.pic = "user"
            realm.add(hailey)
            
        UserDefaults.standard.set(hailey.id, forKey: "UserId")
        }
            }
            
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar for current view controller
        self.navigationController?.isNavigationBarHidden = true;
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
