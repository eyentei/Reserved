//
//  DatePickerViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 09/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    var delegate: ModalDelegate?
    @IBOutlet weak var datepickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var error: UILabel!
    
    @objc func datePickerChanged() {
        var components = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: datePicker.date)

        if components.hour! < 7 {
            components.hour = 7
            components.minute = 0
            error.text = "Please pick hours from 7:00 to 21:00"
            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
        }
        else if components.hour! > 21 {
            components.hour = 21
            components.minute = 0
            error.text = "Please pick hours from 7:00 to 21:00"
            datePicker.setDate(Calendar.current.date(from: components)!, animated: true)
            
        }
        else {
            error.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.text = ""
        
        let calendar = Calendar.current
        let rightNow = Date()
        let interval = 15
        let nextDiff = interval - calendar.component(.minute, from: rightNow) % interval
        let nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: rightNow) ?? Date()


        datePicker.minimumDate = nextDate
            //datePickerChanged()
        datePicker.minuteInterval = 15
        datepickerView.layer.cornerRadius = 24
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        self.definesPresentationContext = true
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.4
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.insertSubview(blurEffectView, at: 0)
    }
    
    @IBAction func ok(_ sender: Any) {
        
        if let delegate = self.delegate {
            delegate.changeValue(value: datePicker!.date)
        }
        dismiss(animated: true, completion: nil)
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
