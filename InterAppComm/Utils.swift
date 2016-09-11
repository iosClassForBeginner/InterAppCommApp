//
//  Utils.swift
//  InterAppComm
//
//  Created by Fangchen Huang on 2016-09-04.
//  Copyright © 2016 Paul H. All rights reserved.
//

import UIKit

class Utils {
    
    static let viewerURL = "interappcommviewer://"

    class func send(morseCode: String, to url: String = viewerURL, from viewController: UIViewController? = nil ) {
        guard UIApplication.sharedApplication().canOpenURL(NSURL(string: url)!) else {
            let alertController = UIAlertController(title: "Can't Send Data",
                                                    message: "Have you installed the Viewer app?",
                                                    preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(okAction)
            viewController?.presentViewController(alertController, animated: true, completion:nil)
            
            return
        }
        
        // Creates percentage-encoded payload
        let payload = morseCode
            .stringByReplacingOccurrencesOfString(" ", withString: "%20")
            .stringByReplacingOccurrencesOfString(".", withString: "%2E")
            .stringByReplacingOccurrencesOfString("-", withString: "%2D")
            .stringByReplacingOccurrencesOfString("/", withString: "%2F")
        let urlString = "\(url)?payload=\(payload)"
        
        UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        
    }
}

