//
//  RestaurantsListViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

protocol SortDelegate
{
    func sortRestaurants(by: String)
}
protocol SearchDelegate
{
    func searchRestaurants(by: String)
}

class RestaurantsListViewController: UIViewController,SortDelegate,SearchDelegate {
    
    var listColl: ListCollectionViewController?
    var sortFilt: SortFilterViewController?
    
    var sortBy: String = "Name"
    var search: String?
    
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
    
    @IBAction func toSortFilter(_ sender: Any) {
        
        performSegue(withIdentifier: "toSortFilter", sender: nil)
        
    }
    
    func sortRestaurants(by: String) {
        sortBy = by
        listColl?.sortBy = by
        
    }

    func searchRestaurants(by:String) {
        search = by
        listColl?.search = by
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        listContainer.isHidden = false
        mapContainer.isHidden = true
        
        segmentedControl.selectedSegmentIndex = 0
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "toSortFilter" {
            let destination = segue.destination as! SortFilterViewController
            destination.sortBy = sortBy
            destination.search = search
            destination.sortDelegate = self
            destination.searchDelegate = self
        } else if segue.identifier == "toList" {
            listColl = segue.destination as? ListCollectionViewController
           
        }
    }
}
