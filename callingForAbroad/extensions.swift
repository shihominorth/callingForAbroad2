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
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
     func getTimeDifference(date: Date, LocalTimeZone: String, DestinationTimeZone: String) -> String {
          
          print(self.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: LocalTimeZone))
          print(date.convertToString(dateformat: .dateWithTime, timeZoneIdentifier:  DestinationTimeZone))
          print(date.getHour(timeZoneIdentifier: LocalTimeZone))
          print(self.getHour(timeZoneIdentifier: DestinationTimeZone))
          
          let tupleLocaltime = self.getHour(timeZoneIdentifier: LocalTimeZone)
          let tupleDestinationtime = date.getHour(timeZoneIdentifier: DestinationTimeZone)
          
          if tupleLocaltime.date < tupleDestinationtime.date {
              var temp = 24 - tupleLocaltime.hour
              temp += tupleDestinationtime.hour
              return "+ \(temp) HOURS"
          }
          else if tupleLocaltime.date == tupleDestinationtime.date {
              if tupleLocaltime.hour - tupleDestinationtime.hour > 0 {
                  return "- \(tupleLocaltime.hour - tupleDestinationtime.hour) HOURS"
              }
              else if tupleLocaltime.hour - tupleDestinationtime.hour < 0 {
                  return "+ \(tupleDestinationtime.hour - tupleLocaltime.hour) HOURS"
              }
              else {
                  return "0 HOUR"
              }
          }
          else {
              var temp = 24 - tupleDestinationtime.hour
              temp += tupleLocaltime.hour
              return "- \(temp) HOURS"
          }
      }
    
    func getHour(timeZoneIdentifier: String) -> (date: Int, hour:Int){
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "dd"
        let date = Int(dateFormatter.string(from: self))
        
        return (date!, hour!)
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
