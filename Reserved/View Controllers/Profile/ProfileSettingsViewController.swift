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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realm = try! Realm()
        let id = UserDefaults.standard.string(forKey: "UserId")!
        let user = realm.objects(User.self).filter("id==  %@", id).first
        Name.text=user!.name
        Mail.text=user!.email
        Phone.text=user!.number
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SaveChanges(_ sender: Any) {
        let realm = try! Realm()
        let id = UserDefaults.standard.string(forKey: "UserId")!
        let user = realm.objects(User.self).filter("id==  %@", id).first
        let password=Password.text
        if (Password.text==RepeatPassword.text && !password!.isEmpty)
        {
                
                 let alert_1 = UIAlertController(title: "Are you sure you want to save changes?", message: " ", preferredStyle: UIAlertController.Style.alert)
                alert_1.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
                alert_1.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
                try! realm.write {
                    user!.setValue(self.Name.text, forKey: "name")
                    user!.setValue(self.Mail.text, forKey: "email")
                    user!.setValue(self.Phone.text, forKey: "number")
                    user!.setValue(self.Password.text, forKey: "password")}
                    
                    
                   self.delegate?.updateLabelText(withText: self.Name.text!)
                    self.dismiss(animated: true, completion: nil)
                    
                    
                    let alert = UIAlertController(title: "Profile settings were successfully updated!", message: "", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))

                    self.present(alert, animated: true, completion: nil)

                 
                  
                  
                } ))


                self.present(alert_1, animated: true, completion: nil)
                
                
              
 }
        else
        { if password!.isEmpty {
            
             let alert_1 = UIAlertController(title: "Are you sure you want to save changes?", message: " ", preferredStyle: UIAlertController.Style.alert)
            alert_1.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
            alert_1.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {action in
            try! realm.write {
                user!.setValue(self.Name.text, forKey: "name")
                user!.setValue(self.Mail.text, forKey: "email")
                user!.setValue(self.Phone.text, forKey: "number")}
               self.delegate?.updateLabelText(withText: self.Name.text!)
                self.dismiss(animated: true, completion: nil)

                let alert = UIAlertController(title: "Profile settings were successfully updated!", message: "", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)

             
              
              
            } ))


            self.present(alert_1, animated: true, completion: nil)
            
        }
        else{
                        let alert = UIAlertController(title: "Passwords do not match!", message: "Please, try again", preferredStyle: UIAlertController.Style.alert)

                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                        //performSegue(withIdentifier: "SignIn", sender: nil)
                    }
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
