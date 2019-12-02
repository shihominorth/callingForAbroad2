//
//  callingCellList.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-11.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import Foundation

class callingCellList {
    var callingList = [callingCellItem]()
    
    init() {
        let row0Item = callingCellItem()
        let row1Item = callingCellItem()
        let row2Item = callingCellItem()
        
        row0Item.NameCallingFor = "Mako"
        row1Item.NameCallingFor = "Risa"
        row2Item.NameCallingFor = "Usshi"
        
        row0Item.localTime = "10:30 AM"
        row1Item.localTime = "11:30 AM"
        row2Item.localTime = "12:30 AM"
        
        row0Item.localName = "Vacouver"
        row1Item.localName = "Vancouver"
        row2Item.localName = "Vancouver"
        
        row0Item.dateCalling = "Fri, 01/11/2019"
        row1Item.dateCalling = "Fri, 01/11/2019"
        row2Item.dateCalling = "Fri, 01/11/2019"
        
        row0Item.destinationName = "Tokyo"
        row1Item.destinationName = "Buenos Aires"
        row2Item.destinationName = "Manilla"
        
        row0Item.jetLag = "+ 17 HRS"
        row1Item.jetLag = "+ 17 HRS"
        row2Item.jetLag = "+ 17 HRS"
        
        row0Item.destinationTime = "6:00 PM"
        row1Item.destinationTime = "01:00 AM"
        row2Item.destinationTime = "04:00 PM"
        
        
        
        callingList.append(row0Item)
        callingList.append(row1Item)
        callingList.append(row2Item)
    }
    
    func newToDo() -> callingCellItem {
        let item = callingCellItem()
        item.localTime = "11: 30 PM"
        callingList.append(item)
        return item
    }
    
    
}
