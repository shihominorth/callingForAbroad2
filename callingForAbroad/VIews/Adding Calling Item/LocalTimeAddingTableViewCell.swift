//
//  LocalTimeTableViewCell.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-12-18.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class LocalTimeAddingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func updateText(date: Date, timeZoneIdentifier: String, indexNumber: Int) {
        label.text = date.convertToString(dateformat: .time, timeZoneIdentifier: timeZoneIdentifier)
          }
          
       func giveText(date: Date, timeZoneIdentifier: String, indexNumber: Int) -> String{
        return  date.convertToString(dateformat: .time, timeZoneIdentifier: timeZoneIdentifier)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
