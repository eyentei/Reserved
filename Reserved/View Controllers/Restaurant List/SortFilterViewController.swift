//
//  SortFilterViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class SortFilterViewController: UITableViewController {
    
    var realm: Realm!
    var sortBy: String = "Name"
    var sortable = [2:"Name",3:"Price",4:"Distance"]
    var delegate:SortDelegate?
    
    
    @IBAction func applySort(_ sender: Any) {
        if let delegate = self.delegate {
            if let cell =  self.tableView.indexPathForSelectedRow?.row {
            
                sortBy = sortable[cell]!
                delegate.sortRestaurants(by: sortable[cell]!)
            
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
    }
    
    override func viewWillAppear(_ animated: Bool) {

            
            let ind = (sortable as NSDictionary).allKeys(for: sortBy) as! [Int]
            let indexPath = IndexPath(row: ind[0], section: 0)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
            self.tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
        
           
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if [0,1,5].contains(indexPath.row) {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        
           case 2,3,4:
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                
               break
           
            default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        
      switch indexPath.row {
     
        case 2:
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            break
        case 3:
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            break
        case 4:
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            break
        
        case 6,7,8:
            performSegue(withIdentifier: "toFilter", sender: nil)
            break
      case 0, 1, 5:
        break
      default:
            break
        }
    }
}
