//
//  PlanDelegate.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-06.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation
import CoreData

class PlanDelegate {
    
    // probably make it accessible to coredata
    var plans = [Plan]()
    
    func move(item: Plan, index: Int) {
        guard let currentIndex = plans.firstIndex(of: item) else {
            return
        }
        plans.remove(at: currentIndex)
        plans.insert(item, at: index)
    }
    
    func remove(items: [Plan]) -> [Plan] {
            
            for item in items {
                if let index = items.firstIndex(of: item) {
                    plans.remove(at: index)
                }
            }
        return plans
    }
    
    func addPlan(item: Plan) -> [Plan] {
        plans.append(item)
        return plans
    }
}
