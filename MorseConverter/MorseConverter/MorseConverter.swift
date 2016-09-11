//
//  MorseConverter.swift
//  SwiftMorseCode
//
//  Created by Andy Cho on 2014-06-05.
//  Copyright (c) 2014 Andy Cho. All rights reserved.
//

import Foundation

// https://github.com/AcroMace/swift-morse-code/tree/master/SwiftMorseCode
class MorseConverter {
    
    static let alphaNumToMorse = [
        "A": ".-",
        "B": "-...",
        "C": "-.-.",
        "D": "-..",
        "E": ".",
        "F": "..-.",
        "G": "--.",
        "H": "....",
        "I": "..",
        "J": ".---",
        "K": "-.-",
        "L": ".-..",
        "M": "--",
        "N": "-.",
        "O": "---",
        "P": ".--.",
        "Q": "--.-",
        "R": ".-.",
        "S": "...",
        "T": "-",
        "U": "..-",
        "V": "...-",
        "W": ".--",
        "X": "-..-",
        "Y": "-.--",
        "Z": "--..",
        "1": ".----",
        "2": "..---",
        "3": "...--",
        "4": "....-",
        "5": ".....",
        "6": "-....",
        "7": "--...",
        "8": "---..",
        "9": "----.",
        "0": "-----",
        " ": " ",
        ]
    
    class func toMorse(from input: String) -> String {
        var morseString = ""
        
         input.uppercaseString.characters.forEach { char in
            guard let morseCode = alphaNumToMorse[String(char)] else { return }
            morseString += "\(morseCode)/"
        }
        
        return morseString
    }
    
    class func fromMorse(input: String) -> String {
        // http://stackoverflow.com/a/26270721/1748050
        let morseTokens = input.componentsSeparatedByString("/")
        var textString = ""
        
        morseTokens.forEach { token in
            guard let index = Array(alphaNumToMorse.values).indexOf(token)
                else { return }
            
            textString += Array(alphaNumToMorse.keys)[index]
        }
        
        return textString
    }
}

public extension String {
    
    var morseCode: String {
        return MorseConverter.toMorse(from: self)
    }
    
    var fromMorseCode: String {
        return MorseConverter.fromMorse(self)
    }
}
