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
        
        row0Item.NameCallingFor = "10:30 AM"
        row1Item.NameCallingFor = "11:30 AM"
        row2Item.NameCallingFor = "12:30 AM"
        
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
