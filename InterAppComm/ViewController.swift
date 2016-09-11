//
//  ViewController.swift
//  InterAppComm
//
//  Created by Fangchen Huang on 2016-08-29.
//  Copyright © 2016 Paul H. All rights reserved.
//

import UIKit
import MorseConverter

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.delegate = self
    }

    // MARK: - IBActions
    @IBAction func convertToMorseCode(sender: AnyObject) {
        inputTextField.endEditing(true)

        outputTextView.text = inputTextField.text?.morseCode
    }
    
    @IBAction func playMorseCode(sender: AnyObject) {
        guard let morseCode = outputTextView.text else { return }
        
        playButton.enabled = false
        morseCode.playMorseCode {
            self.playButton.enabled = true
        }
    }
    
    @IBAction func sendMorseCode(sender: AnyObject) {
        guard let morseCode = outputTextView.text else { return }
        
        sendButton.enabled = false
        morseCode.playMorseCode {
            self.sendButton.enabled = true
            
            Utils.send(morseCode, from: self)
        }
    }
    
    @IBAction func showActions(sender: AnyObject) {
        guard let morseCode = outputTextView.text else { return }

        let morseCodeActivity = MorseCodeActivity()
        let activityViewController = UIActivityViewController(activityItems: [morseCode], applicationActivities: [morseCodeActivity])
        presentViewController(activityViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        outputTextView.text = ""
    }
    
    // Dismisses keyboard when Done button is tapped
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputTextField.endEditing(true)
        
        return true
    }
}