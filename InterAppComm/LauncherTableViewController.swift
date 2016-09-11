//
//  LauncherTableViewController.swift
//  InterAppComm
//
//  Created by Fangchen Huang on 2016-08-29.
//  Copyright © 2016 Paul H. All rights reserved.
//

import UIKit

class LauncherTableViewController: UITableViewController {
    
    struct Apps {
        static let apps: [String: String] = [
            "LINE": "line://",
            "Twitter": "twitter://",
            "Mail": "message://"
        ]
        
        static var count = apps.count
        
        static func name(at index: Int) -> String {
            return Array(apps.keys)[index]
        }
        
        static func url(at index: Int) -> String {
            return Array(apps.values)[index]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "App Launcher"
    }
}

// MARK: - UITableViewDataSource
extension LauncherTableViewController {

    enum Row: Int {
        case Line = 0, NumberOfRows
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Apps.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(Apps.name(at: indexPath.row)) App"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        launchApp(at: Apps.url(at: indexPath.row))
    }
}

// MARK: - Utils
private extension LauncherTableViewController {
    
    // Make sure to whitelist this URL in info.plist under LSApplicationQueriesSchemes
    func launchApp(at urlString: String) {
        let url = NSURL(string: urlString)!
        
        if UIApplication.sharedApplication().canOpenURL(url) {
            UIApplication.sharedApplication().openURL(url)
        }
        else {
            print("Can't launch app at \(urlString)")
        }
    }
}
