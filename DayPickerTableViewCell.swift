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
    var datePicker : UIDatePicker!
    
   
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
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        self.addSubview(datePicker)
        
        
       
//        self.addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>)
       
        
    }
    
//    func updateCell(date: Date, indexPath: IndexPath) {
//        datePicker.setDate(date, animated: true)
//        self.indexPath = indexPath 
//    }
    
    override func layoutSubviews() {
        //datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let x:CGFloat = self.frame.size.width-self.datePicker.frame.size.width
        datePicker.frame = CGRect(x: x/2, y: 0, width: self.datePicker.frame.size.width, height: self.frame.height)

    }
}
