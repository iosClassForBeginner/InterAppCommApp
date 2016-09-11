//
//  ViewController.swift
//  InterAppCommViewer
//
//  Created by Fangchen Huang on 2016-08-29.
//  Copyright © 2016 Paul H. All rights reserved.
//

import UIKit
import MorseConverter

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        
        // Updates input text upon app resumes foreground
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(updateInputText),
                                                         name: UIApplicationDidBecomeActiveNotification,
                                                         object: nil)
    }
    
    func updateInputText() {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate,
            let payload = appDelegate.payload {
            inputTextField.text = payload
            outputTextView.text = ""
        }
    }
    
    // MARK: - IBActions
    @IBAction func convertFromMorseCode(sender: AnyObject) {
        inputTextField.endEditing(true)
        
        outputTextView.text = inputTextField.text?.fromMorseCode
    }
}

extension ViewController: UITextFieldDelegate {
    
    // Dismisses keyboard when Done button is tapped
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputTextField.endEditing(true)
        
        return true
    }
}
