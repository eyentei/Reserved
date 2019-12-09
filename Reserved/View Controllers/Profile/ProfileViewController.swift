//
//  ProfileViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBAction func LogOut(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
   
    @IBOutlet weak var profileSettings: UIView!
    @IBOutlet weak var reservations: UIView!
    @IBAction func SwitchProfile(_ sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0 :
            profileSettings.isHidden = false
            reservations.isHidden = true
        case 1:
            profileSettings.isHidden = true
            reservations.isHidden = false
        default: break;
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileSettings.isHidden = false
        reservations.isHidden = true
        let realm = try! Realm()
              var users = realm.objects(User.self)
        NameLabel.text=users[0].name
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
