//
//  RestaurantsListViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

class RestaurantsListViewController: UIViewController {

    
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func SwitchListMap(_ sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0 :
            listContainer.isHidden = false
            mapContainer.isHidden = true
        case 1:
            listContainer.isHidden = true
            mapContainer.isHidden = false
        default: break;
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        listContainer.isHidden = false
        mapContainer.isHidden = true
        
        segmentedControl.selectedSegmentIndex = 0
        
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
