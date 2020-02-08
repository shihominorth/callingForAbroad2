//
//  DayPickerTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-08.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: class {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DayPickerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dayPicker: UIDatePicker!
    var indexPath: IndexPath!
    weak var delegate: DatePickerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func reuseIdentier() -> String {
        return "dayPicker"
    }
    
    func updateCell(date: Date, indexPath: IndexPath) {
        dayPicker.setDate(date, animated: true)
        self.indexPath = indexPath
    }
}
