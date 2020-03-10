//
//  SignInViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
     
    @IBAction func SignIn(_ sender: Any) {

        guard let email = emailTextField.text, let password = passwordTextField.text,
            !email.isEmpty, !password.isEmpty else {
                
                let alertController = UIAlertController(title: "Validation Error",
                              message: "Please fill in both fields", preferredStyle: .alert)
                  
                  let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                      alertController.dismiss(animated: true, completion: nil)}
                 
                  alertController.addAction(alertAction)
                return  present(alertController, animated: true, completion: nil)
               
        }
       
         let realm = try! Realm()
        if let user = realm.objects(User.self).filter("email==  %@", email).first {
            if user.password == password {
                
               UserDefaults.standard.set(user.id, forKey:"UserId")

               self.performSegue(withIdentifier: "SignIn", sender: nil)
                
            } else {
               let alertController = UIAlertController(title: "Validation Error",
                                message: "Wrong login or password", preferredStyle: .alert)
                                 
                let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                                     alertController.dismiss(animated: true, completion: nil)}
                                
                                 alertController.addAction(alertAction)
                return  present(alertController, animated: true, completion: nil)
            }
            
            
        } else{
            let alertController = UIAlertController(title: "Validation Error",
                            message: "Login does not exist", preferredStyle: .alert)
                             
            let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                                 alertController.dismiss(animated: true, completion: nil)}
                            
                             alertController.addAction(alertAction)
            return  present(alertController, animated: true, completion: nil)
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
