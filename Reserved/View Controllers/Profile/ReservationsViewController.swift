//
//  ReservationsViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

class ReservationsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    func  listToString(tables:List<Int>)-> String
    {let formattedArray = tables.map{String($0)}.joined(separator: ", ")
        return "Table №"+formattedArray }
    
    func getReservations()-> Results<Reservation>
    { let realm = try! Realm()
        return realm.objects(Reservation.self)}
    
      func formatDate(value: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.y HH:mm"
        return dateFormatter.string(from: value)
    }
    func registerTableViewCell()
    {let textFieldCell=UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "TableViewCell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        //self.registerTableViewCell()
       // self.tableView.dataSource=self as? UITableViewDataSource
               //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
         // self.tableView.reloadData()
       self.tableView.dataSource = self as! UITableViewDataSource
       
            }
    }

   extension ReservationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getReservations().count
    }
        
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)//1.
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    
    var reserv=self.getReservations()
    cell.RestLabel.text=reserv[indexPath.row].restaurant?.name
    cell.DateLabel.text=formatDate(value: reserv[indexPath.row].time)
    cell.TableLabel.text =  listToString(tables:reserv[indexPath.row].tables)
    //2.
    //cell.textLabel?.text =  listToString(tables:reserv[indexPath.row].tables)
    //cell.textLabel?.text =  formatDate(value: reserv[indexPath.row].time)
   // cell.textLabel?.text =  reserv[indexPath.row].restaurant?.name
   // cell.detailTextLabel?.text =  reserv[indexPath.row].restaurant?.name
     return cell
}
}
    
    //        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //           let realm = try! Realm()
     //           var users = realm.objects(User.self)
     //           var reservations=realm.objects(Reservation.self)
     //           let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
     //           let item = reservations[indexPath.item]
     //           cell.textLabel?.text = item.restaurant?.name
     //           return cell
      //      }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

