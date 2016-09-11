//
//  morseCodeActivity.swift
//  InterAppComm
//
//  Created by Fangchen Huang on 2016-09-04.
//  Copyright © 2016 Paul H. All rights reserved.
//

import UIKit

class MorseCodeActivity: UIActivity {
    
    private var morseCode: String = ""

    override class func activityCategory() -> UIActivityCategory {
        return .Action
    }
    
    override func activityType() -> String? {
        return "ca.paulhfch.sendMorseCode"
    }
    
    override func activityTitle() -> String? {
        return NSLocalizedString("Send to Viewer", comment: "")
    }

    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return !activityItems.isEmpty
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        morseCode = activityItems.first as! String
    }
    
    override func performActivity() {
        Utils.send(morseCode)
    }
}