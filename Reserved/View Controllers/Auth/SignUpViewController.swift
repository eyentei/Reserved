
    import UIKit
    import RealmSwift


    
    class SignUpViewController: UIViewController {

        @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!
        var user: User!
       
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        
        @IBAction func SignUp(_ sender: Any) {
            
            guard let email = emailTextField.text, let password = passwordTextField.text,
                let name = nameTextField.text,
                !email.isEmpty, !password.isEmpty, !name.isEmpty else {
                    let alertController = UIAlertController(title: "Validation Error",
                                 message: "All fields must be filled", preferredStyle: .alert)
                     
                     let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                         alertController.dismiss(animated: true, completion: nil)}
                    
                     alertController.addAction(alertAction)
                    return present(alertController, animated: true, completion: nil)
                    
            }
            
            
            
            let realm = try! Realm()
            
            guard  realm.objects(User.self).filter("email==  %@", email).first == nil else{
                let alertController = UIAlertController(title: "Validation Error",
                             message: "This Email already exists", preferredStyle: .alert)
                 
                 let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
                     alertController.dismiss(animated: true, completion: nil)}
                
                 alertController.addAction(alertAction)
               return  present(alertController, animated: true, completion: nil)
                
            }
            
           let newUser = User(name: name, email: email, password: password)
          
           try! realm.write {
                realm.add(newUser)
                UserDefaults.standard.set(newUser.email, forKey:"user")
                self.performSegue(withIdentifier: "SignUp", sender: nil)
            }
            
}
}
            
            
            
