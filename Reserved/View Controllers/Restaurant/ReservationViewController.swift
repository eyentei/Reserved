//
//  ReservationViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit
import RealmSwift
import EventKit
import UserNotifications

protocol ModalDelegate {
    func changeValue(value: Date)
}
class ReservationViewController: UIViewController, ModalDelegate,GetReservation {
    
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
        
        if let result = currentUser.reservations.filter("restaurant == %@ AND time == %@", currentRestaurant!, reservationDate!).first {

            if tables.count == 0 {
                try! realm.write() {
                    let eventStore : EKEventStore = EKEventStore()
                    if let ev = result.calendarEventId {
                        let event = eventStore.event(withIdentifier: ev)
                        try? eventStore.remove(event!, span: .thisEvent, commit: true)
                    }
                    
                    realm.delete(result)
                }
            } else {
                try! realm.write() {
                    result.tables.removeAll()
                    result.tables.append(objectsIn: tables)
                }
                let ref = ThreadSafeReference(to: result)
                addToCalendar(ref: ref)
            }
            
        } else {
            let reservation = Reservation()
            reservation.person = currentUser
            reservation.restaurant  = currentRestaurant
            reservation.tables = tables
            reservation.time = reservationDate
            try! realm.write() {
                currentUser.reservations.append(reservation)
                realm.add(reservation)
            }
            let ref = ThreadSafeReference(to: reservation)
            addToCalendar(ref: ref)
        }
    navigationController?.popViewController(animated: true)
    }
    
    
    func getReservation(withObject reserv: Reservation) {
        reservationDate=reserv.time
    }
    
    
    
     func createDate(year: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.timeZone = TimeZone(secondsFromGMT: 0)

        return Calendar.current.date(from: components)!
    }
    
    func addToCalendar(ref: ThreadSafeReference<Reservation>) {
        
       let eventStore : EKEventStore = EKEventStore()
        
       eventStore.requestAccess(to: .event) { (granted, error) in

           if (granted) && (error == nil) {
               print("granted \(granted)")
               print("error \(error)")
           let realm = try! Realm()
           let result = realm.resolve(ref)
            

            if let id = result?.calendarEventId {
                let evt = eventStore.event(withIdentifier: id)!
                try? eventStore.remove(evt, span: .thisEvent, commit: true)
            }
            let event = EKEvent(eventStore: eventStore)

                event.title = result!.restaurant?.name
               event.startDate = result!.time
               event.endDate = result!.time
              
               let stringArray = result!.tables.map { String($0) }
               let tbls = stringArray.joined(separator: ", ")
               
               event.notes = tbls
               event.calendar = eventStore.defaultCalendarForNewEvents
                let alarm1hour = EKAlarm(relativeOffset: -3600) //1 hour
                let alarm1day = EKAlarm(relativeOffset: -86400) //1 day
                event.addAlarm(alarm1day)
                event.addAlarm(alarm1hour)
            
          
                do {
                    
                    try eventStore.save(event, span: .thisEvent)

                    try! realm.write() {
                        result?.calendarEventId = event.eventIdentifier
                    }
                   } catch let error as NSError {
                       print("failed to save event with error : \(error)")
                   }
                   print("Saved Event")

                self.scheduleNotification(res: result!)
            }
                
      
           else{

               print("failed to save event with error : \(error) or access not granted")
           }
       }
    }
    
    func scheduleNotification(res: Reservation) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let content = UNMutableNotificationContent()
        
        content.title = res.restaurant!.name
        
        let df = DateFormatter()
        df.dateFormat = "MMMM d, H:mm"
        let dt = df.string(from:res.time)
        content.body = "You have a reservation for " + dt
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
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

        let allTables = List<Int>()
        let userTables = List<Int>()

        let notUser = realm.objects(Reservation.self).filter("restaurant == %@ AND time == %@ AND NOT person == %@", currentRestaurant!, reservationDate!, currentUser!)
        
        if let user = realm.objects(Reservation.self).filter("restaurant == %@ AND time == %@ AND person == %@", currentRestaurant!, reservationDate!, currentUser!).first {
            userTables.append(objectsIn: user.tables)
        }
        
        for usr in notUser {
            allTables.append(objectsIn: usr.tables)
        }
        
    
        
        for button in buttons {
            button.setImage(UIImage.init(named: String(button.tag)+"w"), for: UIControl.State.normal)
            button.setImage(UIImage.init(named: String(button.tag)+"g"), for: UIControl.State.disabled)
            button.setImage(UIImage.init(named: String(button.tag)+"s"), for: UIControl.State.selected)
            button.adjustsImageWhenHighlighted = false
            
            if userTables.contains(button.tag)  {
                button.isSelected = true
            }
            if allTables.contains(button.tag)  {
                button.isEnabled = false
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
