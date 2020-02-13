//
//  TableViewCell.swift
//  
//
//  Created by 北島　志帆美 on 2019-12-17.
//

import UIKit

// Date Format type
enum DateFormatType: String {
    /// Time
    case time = "HH:mm:ss"
    
    /// Date with hours
    case dateWithTime = "dd-MMM-yyyy  H:mm"
    
    /// Date
    case date = "dd-MMM-yyyy"
}

class DateCallingTableViewCell: UITableViewCell {

    @IBOutlet weak var DateCallingLabel: UILabel!
    
    func updateText(date: Date) {
        DateCallingLabel.text = date.convertToString(dateformat: .date)
    }
    
    func giveText(date: Date) -> String{
        return  date.convertToString(dateformat: .date)
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


extension Date {
    
    func convertToString(dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
}
