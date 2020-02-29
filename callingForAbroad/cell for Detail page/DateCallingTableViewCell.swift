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
    case time = "HH:mm"
    
    /// Date with hours
    case dateWithTime = "EEE, MMMM d, yyyy  H:mm"
    
    /// Date
    case date = "EEE, MMMM d, yyyy"
}

class DateCallingTableViewCell: UITableViewCell {

    @IBOutlet weak var DateCallingLabel: UILabel!
    
    func updateText(date: Date, timeZoneIdentifier: String, indexNumber: Int) {
        DateCallingLabel.text = date.convertToString(dateformat: .date, indexNumber: indexNumber, timeZoneIdentifier: timeZoneIdentifier)
    }
    
    func giveText(date: Date, timeZoneIdentifier: String, indexNumber: Int) -> String{
        return  date.convertToString(dateformat: .date, indexNumber: indexNumber, timeZoneIdentifier: timeZoneIdentifier)
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
    
    func convertToString(dateformat formatType: DateFormatType, indexNumber: Int ,timeZoneIdentifier: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        
        
        switch indexNumber {
        case 0:
            dateFormatter.dateFormat = DateFormatType.date.rawValue
        case 1:
            dateFormatter.dateFormat = DateFormatType.time.rawValue
        case 2:
            dateFormatter.dateFormat = DateFormatType.dateWithTime.rawValue
        default:
            break
        }
        
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
}
