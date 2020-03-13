//
//  ReservationsViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 05/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift
protocol GetReservation {
  func getReservation(withObject reserv: Reservation)
}
class ReservationsViewController: UIViewController,UITableViewDelegate {
    var delegate: GetReservation?
    var reservationController: ReservationViewController?
    @IBOutlet weak var tableView: UITableView!
   
 
    
    func  listToString(tables:List<Int>)-> String
    {let formattedArray = tables.map{String($0)}.joined(separator: ", ")
        return "Table №"+formattedArray }
    
    func getReservations()-> Results<Reservation>
    {   let realm = try! Realm()
        let date = Date()
        let id = UserDefaults.standard.string(forKey: "UserId")!
        var user = realm.objects(User.self).filter("id==  %@", id).first
        let reserv = realm.objects(Reservation.self).filter("time > %@ AND person == %@", date, user!)
            return reserv}
    
    
    
      func formatDate(value: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.y HH:mm"
            return dateFormatter.string(from: value)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate=self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        self.tableView.allowsSelectionDuringEditing = true

     
            }
    }

   extension ReservationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getReservations().count
    }
        
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
    
    var reserv=self.getReservations()
    cell.RestLabel.text=reserv[indexPath.row].restaurant?.name
  cell.DateLabel.text=formatDate(value: reserv[indexPath.row].time)
    cell.TableLabel.text =  listToString(tables:reserv[indexPath.row].tables)
    //2.

     return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
let reservation = getReservations()[indexPath.row]
    print("good")
//self.delegate?.getReservation(withObject: reservation)
//let storyboard = UIStoryboard(name: "Main", bundle: nil)
//let controller = storyboard.instantiateViewController(withIdentifier: "ReservationViewController")
//self.present(controller, animated: true, completion: nil)

// Safe Present
//if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReservationViewController") as? ReservationViewController
//{
 //   present(vc, animated: true, completion: nil)
//}
    
     performSegue(withIdentifier: "toReserv", sender: nil)
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
