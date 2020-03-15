//
//  delegate.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-03-15.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation

protocol DataManagerDelegate: class {
    func gotData(plans: [Plan])
}
