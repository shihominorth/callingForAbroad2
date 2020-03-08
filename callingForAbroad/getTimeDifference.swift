import Foundation
import UIKit


class GetTimeDifference {
    var localName: String?
    var destinationName: String?
    
    var date: Date?
    
    init(localName: String?, destinationName: String?, date: Date?) {
        
        self.localName = localName
        self.destinationName = destinationName
        self.date = date
    }
    
    //MARK: how to tell Date() timezone???
    // if i cant calculate it, im gonna use lat and log from cllocation
    
    func timeDifferenceWithCityNames() -> String {
        
        let currentLocalDate = Date()
        let currentDestinationDate = Date()
        
        let dateFormatterForLocal = DateFormatter()
        let dateFormatterForDestination = DateFormatter()
        
        
        
        dateFormatterForLocal.dateFormat = "yyyy/MM/dd HH:mm, EEE"
        dateFormatterForLocal.calendar = Calendar.current
        //        print(localName)
        dateFormatterForLocal.timeZone = TimeZone(identifier: self.localName ?? TimeZone.current.identifier)
        let localDateString = dateFormatterForLocal.string(from: currentLocalDate)
        let localDate = dateFormatterForLocal.date(from: localDateString)
        
        dateFormatterForDestination.dateFormat = "yyyy/MM/dd HH:mm, EEE"
        dateFormatterForDestination.timeZone = TimeZone(identifier: self.destinationName ?? TimeZone.current.identifier)
        dateFormatterForDestination.calendar = Calendar.current
        //        print(dateFormatterForDestination.timeZone)
        
        let destinationDateString = dateFormatterForLocal.string(from: currentDestinationDate)
        let destinationDate = dateFormatterForLocal.date(from: destinationDateString)!
        
        
        
        return localDate!.getTimeDifference(date: destinationDate, LocalTimeZone: localName!, DestinationTimeZone: destinationName!)
        
    }
}
