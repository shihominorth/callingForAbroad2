//
//  Plan+CoreDataProperties.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-10.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//
//

import Foundation
import CoreData


extension Plan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plan> {
        return NSFetchRequest<Plan>(entityName: "Plan")
    }

    @NSManaged public var destinationName: String?
    @NSManaged public var destinationTime: String?
    @NSManaged public var jetLag: String?
    @NSManaged public var localDate: String?
    @NSManaged public var localName: String?
    @NSManaged public var localTime: String?
    @NSManaged public var nameCallingFor: String?
    @NSManaged public var notification: String?
    @NSManaged public var placeCallingAt: String?

}
