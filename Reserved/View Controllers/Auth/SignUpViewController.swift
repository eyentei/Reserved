//
//  SignUpViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        do {
            let realm = try Realm()
            // realm.write
            performSegue(withIdentifier: "SignUp", sender: nil)

        } catch {
            print(error.localizedDescription)
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