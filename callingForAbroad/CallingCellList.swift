//
//  callingCellList.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-11.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import Foundation

class CallingCellList {
    var callingList :[Plan] = []
    
//    func move(item: Plan, to index:Int) {
//        guard let currentIndex = callingList.firstIndex(of: item) else {
//            return
//        }
//        callingList.remove(at: currentIndex)
//        callingList.insert(item, at: index)
//    }
//    
//    func remove(items: [Plan]) {
//        
//        for item in items {
//            if let index = items.firstIndex(of: item) {
//                callingList.remove(at: index)
//            }
//        }
//    }
    
    func newToDo(item: Plan) -> Plan {
        
        callingList.append(item)
        return item
    }
    
    
    
}
