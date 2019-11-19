//
//  checklistItem.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-08.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import Foundation

class callingCellItem {
    
    var NameCallingFor = ""
    var localTime = ""
    var checked = false
   
    
    func toggleChecked() {
        checked = !checked
    }
}
