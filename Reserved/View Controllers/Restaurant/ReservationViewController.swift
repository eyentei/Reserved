//
//  ReservationViewController.swift
//  Reserved
//
//  Created by Мария Коровина on 04/12/2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {

    
    @IBOutlet var buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
