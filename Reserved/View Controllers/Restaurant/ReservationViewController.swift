//
//  ReservationViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift

protocol ModalDelegate {
    func changeValue(value: Date)
}
class ReservationViewController: UIViewController, ModalDelegate {
    
    var currentUser:User!
    var realm: Realm!
    var reservationDate: Date!
    var currentRestaurant: Restaurant!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var date: UILabel!
    
    @IBAction func selectTable(_ sender: UIButton) {
        realm = try! Realm()
        
        let tables=List<Int>()
        for button in buttons {
            if button.isSelected {
                tables.append(button.tag)
            }
        }
        
        try! realm.write() {
            if let result = currentUser.reservations.filter("restaurant == %@ AND time == %@", currentRestaurant!, reservationDate!).first {
                
        
              result.tables.removeAll()
              result.tables.append(objectsIn: tables)
                
            } else {
            
            let reservation = Reservation()
                
                reservation.person = currentUser
                reservation.restaurant  = currentRestaurant
                
                reservation.tables = tables
                reservation.time = reservationDate
                
            currentUser.reservations.append(reservation)
                realm.add(reservation)
            
            }
            
        }
    
    navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showDatePicker(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "datepickerVC") as! DatePickerViewController
       vc.modalPresentationStyle = .overCurrentContext
       vc.modalTransitionStyle = .crossDissolve
       vc.delegate = self
       present(vc, animated: true, completion: nil)
        
       }

    func formatDate(value: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.y HH:mm"
        return dateFormatter.string(from: value)
    }
    func changeValue(value: Date) {
        reservationDate = value
        date.text = formatDate(value: value)
        let tables = List<Int>()

        if let reservation = currentUser.reservations.filter("restaurant == %@ AND time == %@", currentRestaurant!, reservationDate!).first {
        tables.append(objectsIn: reservation.tables)
        }
        
        for button in buttons {
            
            if tables.contains(button.tag)  {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()

        let pk = UserDefaults.standard.string(forKey: "UserId")!
        currentUser = realm.object(ofType: User.self, forPrimaryKey: pk)
        
        var components = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: Date())

        if components.hour! < 7 {
            components.hour = 7
            components.minute = 0
            let d = Calendar.current.date(from: components)
            reservationDate = d
            date.text = formatDate(value: d!)
            
        } else if (components.hour! == 21 && components.minute! > 29) || components.hour! > 21 {

            components.day = components.day!+1
            components.hour = 7
            components.minute = 0

            let d = Calendar.current.date(from: components)
            reservationDate = d
            date.text = formatDate(value: d!)
    
        } else {
            let calendar = Calendar.current
            let rightNow = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date()))
            
            let interval = 15
            let nextDiff = interval - calendar.component(.minute, from: rightNow!) % interval
            print(nextDiff)
            let nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: rightNow!)
          
            reservationDate = nextDate
            date.text = formatDate(value: nextDate!)
        }

        let tables = List<Int>()

        if let reservation = currentUser.reservations.filter("restaurant == %@ AND time == %@", currentRestaurant!, reservationDate!).first {
            tables.append(objectsIn: reservation.tables)
        }
    
        
        for button in buttons {
            button.setImage(UIImage.init(named: String(button.tag)+"w"), for: UIControl.State.normal)
            button.setImage(UIImage.init(named: String(button.tag)+"g"), for: UIControl.State.disabled)
            button.setImage(UIImage.init(named: String(button.tag)+"s"), for: UIControl.State.selected)
            button.adjustsImageWhenHighlighted = false
            
            if tables.contains(button.tag)  {
                button.isSelected = true
            }
        }

    }
    

    @IBAction func tableClicked(_ sender: UIButton) {
    
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
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
