//
//  ProfileSettingsViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileSettingsViewController: UIViewController {
  
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Mail: UITextField!
    @IBOutlet weak var Name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        var users = realm.objects(User.self)
        Name.text=users[0].name
        Mail.text=users[0].email
        Phone.text=users[0].number
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
