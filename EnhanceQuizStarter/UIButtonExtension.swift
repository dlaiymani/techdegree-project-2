//
//  UIButtonExtension.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 15/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
import Foundation

// Animate a button
extension UIButton {
    
    // Flash the button
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        
        layer.add(flash, forKey: nil)
    }
}

