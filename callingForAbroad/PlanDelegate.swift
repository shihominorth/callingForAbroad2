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
    
//    // probably make it accessible to coredata
//    
//    // MARK: - Core Data stack
//    lazy var persistentContainer: NSPersistentContainer = {
//      
//      let container = NSPersistentContainer(name: "Plan")
//      
//      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//        
//        if let error = error as NSError? {
//          fatalError("Unresolved error \(error), \(error.userInfo)")
//        }
//      })
//      return container
//    }()
//    
//    lazy var plan = Plan(context: persistentContainer)
//    
//    
//    
//    
//    func move(item: Plan, index: Int) {
//        guard let currentIndex = plans.firstIndex(of: item) else {
//            return
//        }
//        plans.remove(at: currentIndex)
//        plans.insert(item, at: index)
//    }
//    
//    func remove(items: [Plan]) -> [Plan] {
//            
//            for item in items {
//                if let index = items.firstIndex(of: item) {
//                    plans.remove(at: index)
//                }
//            }
//        return plans
//    }
//    
//    func addPlan(item: Plan) -> [Plan] {
//        plans.append(item)
//        return plans
//    }
}
