//
//  extensions.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-03-05.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToString(dateformat formatType: DateFormatType, timeZoneIdentifier: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        dateFormatter.dateFormat = formatType.rawValue
        //
        //        switch indexNumber {
        //        case 0:
        //            dateFormatter.dateFormat = DateFormatType.date.rawValue
        //        case 1:
        //            dateFormatter.dateFormat = DateFormatType.time.rawValue
        //        case 2:
        //            dateFormatter.dateFormat = DateFormatType.dateWithTime.rawValue
        //        default:
        //            break
        //        }
        
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
}

extension String {
    func convertStringToDate(dateformat formatType: DateFormatType, timeZoneIdentifier: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
//        dateFormatter.dateFormat = formatType.rawValue
        let newDate: Date = dateFormatter.date(from: self)!
        return newDate
    }
}
