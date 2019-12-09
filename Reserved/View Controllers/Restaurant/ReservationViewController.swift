//
//  ReservationViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

protocol ModalDelegate {
    func changeValue(value: Date)
}
class ReservationViewController: UIViewController, ModalDelegate {
    
    
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var date: UILabel!
    @IBAction func showDatePicker(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "datepickerVC") as! DatePickerViewController
       vc.modalPresentationStyle = .overCurrentContext
       vc.modalTransitionStyle = .crossDissolve
       vc.delegate=self
       present(vc, animated: true, completion: nil)
        
       }

    func formatDate(value: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.y HH:mm"
        return dateFormatter.string(from: value)
    }
    func changeValue(value: Date) {
        date.text = formatDate(value: value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var components = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: Date())

        if components.hour! < 7 {
            components.hour = 7
            components.minute = 0
            let d = Calendar.current.date(from: components)
            date.text = formatDate(value: d!)
            
        } else if (components.hour! == 21 && components.minute! > 29) || components.hour! > 21 {

            components.day = components.day!+1
            components.hour = 7
            components.minute = 0
            let d = Calendar.current.date(from: components)
            date.text = formatDate(value: d!)
    
        } else {
            let calendar = Calendar.current
            let rightNow = Date()
            let interval = 15
            let nextDiff = interval - calendar.component(.minute, from: rightNow) % interval
            let nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: rightNow) ?? Date()
            date.text = formatDate(value: nextDate)
        }
       
        buttons[4].isEnabled = false
        buttons[8].isEnabled = false
        
        for button in buttons {
            button.setImage(UIImage.init(named: String(button.tag)+"w"), for: UIControl.State.normal)
            button.setImage(UIImage.init(named: String(button.tag)+"g"), for: UIControl.State.disabled)
            button.setImage(UIImage.init(named: String(button.tag)+"s"), for: UIControl.State.selected)
            button.adjustsImageWhenHighlighted = false
        }


        // Do any additional setup after loading the view.
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
