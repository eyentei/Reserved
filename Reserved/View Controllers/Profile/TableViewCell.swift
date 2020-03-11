//
//  TableViewCell.swift
//  Reserved
//
//  Created by Elena on 16.12.2019.
//  Copyright © 2019 Мария Коровина. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var RestLabel: UILabel!
   // @IBOutlet weak var TableLabel: UILabel!
   // @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TableLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
