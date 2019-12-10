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
    
    @IBOutlet weak var RepeatPassword: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        var users = realm.objects(User.self)
        Name.text=users[0].name
        Mail.text=users[0].email
        Phone.text=users[0].number
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SaveChanges(_ sender: Any) {
        let realm = try! Realm()
               var users = realm.objects(User.self)
        try! realm.write {
            users.first?.setValue(Name.text, forKey: "name")
            users.first?.setValue(Mail.text, forKey: "email")
            users.first?.setValue(Phone.text, forKey: "number")
        }
            if Password.text==RepeatPassword.text{
                try! realm.write{  users.first?.setValue(Password.text, forKey: "password")}
 }
            else{
                        let alert = UIAlertController(title: "Passwords do not match!", message: "Please, try again", preferredStyle: UIAlertController.Style.alert)

                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                    }
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
