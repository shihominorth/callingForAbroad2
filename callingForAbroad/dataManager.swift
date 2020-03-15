//
//  dataManager.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-03-15.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DataManager {
    let db = Firestore.firestore()
    weak var delegate: DataManagerDelegate?
    var plans: [Plan] = []
    
    func getData() {
        db.collection("users").document().collection("plans").addSnapshotListener {
            querySnapshot, error in
                if error != nil {
                    print("Error getting documents: \(String(describing: error))")
                } else {
                    
                    self.plans.removeAll()
                    //For-loop
                    for documents in querySnapshot!.documents
                    {
                        
                        
                        let data = documents.data()
                        
                        print("data count: \(data.count)")
                        
                        
                        let nameCallingFor =  data["nameCallingFor"] as? String
                        let localName = data["nameCallingFor"] as? String
                        let localDate = data["localDate"] as? Date?
                        let destinationTime = data["destinationTime"] as? Date?
                        let jetLag = data["jetLag"] as? String
                        let destinationName = data["destinationName"] as? String
                        let notification = data["notification"] as? Int
                        let placeCallingAt = data["placeCallingAt"] as? String
                        
                        let plan = Plan(nameCallingFor: nameCallingFor!, localName: localName!, localDate: localDate!, destinationTime: destinationTime!, jetLag: jetLag!, destinationName: destinationName!, notification: notification!, placeCallingAt: placeCallingAt!)
                        
                        self.plans.append(plan)
                        
                    }
                }
                
            self.delegate?.gotData(plans: self.plans)
                
        }
    }
    
    
    func addPlan(plan: Plan) {
        db.collection("users").document().collection("plans").document().setData([
            "nameCallingFor": plan.nameCallingFor ?? "NONE",
             "localName": plan.localName  ?? "NONE",
             "localDate": plan.localDate ?? Date(),
             "destinationTime": plan.destinationTime ?? Date(),
             "jetLag": plan.jetLag ?? "NONE",
             "destinationName": plan.destinationName ?? "NONE",
             "notification": plan.notification ?? "NONE",
             "placeCallingAt": plan.placeCallingAt ?? "NONE",
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
    }
}
