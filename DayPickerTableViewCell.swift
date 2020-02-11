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
    
    var indexPath: IndexPath!
    weak var delegate: DatePickerDelegate?
    
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        DatePicker()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func DatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        self.addSubview(datePicker)

    }
    
//    func updateCell(date: Date, indexPath: IndexPath) {
//        datePicker.setDate(date, animated: true)
//        self.indexPath = indexPath 
//    }
}
