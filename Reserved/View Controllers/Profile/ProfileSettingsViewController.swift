//
//  ProfileSettingsViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift
protocol UpdateLabelTextDelegate {
  func updateLabelText(withText text: String)
}
class ProfileSettingsViewController: UIViewController {
  var delegate: UpdateLabelTextDelegate?
    
    
    
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

            if Password.text==RepeatPassword.text{
                
                 let alert_1 = UIAlertController(title: "Are you sure you want to save changes?", message: " ", preferredStyle: UIAlertController.Style.alert)
                alert_1.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
                alert_1.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
                try! realm.write {
                    users.first?.setValue(self.Name.text, forKey: "name")
                    users.first?.setValue(self.Mail.text, forKey: "email")
                    users.first?.setValue(self.Phone.text, forKey: "number")
                    users.first?.setValue(self.Password.text, forKey: "password")}
                    
                    
                   self.delegate?.updateLabelText(withText: self.Name.text!)
                    self.dismiss(animated: true, completion: nil)
                    
                    
                    let alert = UIAlertController(title: "Profile settings were successfully updated!", message: "", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
                    //var users = realm.objects(User.self)
                    //ProfileController.UpdateName(text: String(users[0].name))
                   // ProfileController.viewDidLoad()
                 
                  
                  
                } ))


                self.present(alert_1, animated: true, completion: nil)
                
                
              
 }
            else{
                        let alert = UIAlertController(title: "Passwords do not match!", message: "Please, try again", preferredStyle: UIAlertController.Style.alert)

                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                        performSegue(withIdentifier: "SignIn", sender: nil)
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
