//
//  addCallingItemScrollview.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-26.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

class addCallingItemScrollview: UIView {

    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer){
        let traslation = recognizer.translation(in: self)
        bounds.origin.y = bounds.origin.y - traslation.y
        
        recognizer.setTranslation(CGPoint.zero, in: self)
    }

}
