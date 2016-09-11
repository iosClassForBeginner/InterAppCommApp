//
//  MorseCodePlayer.swift
//  MorseConverter
//
//  Created by Fangchen Huang on 2016-09-01.
//  Copyright © 2016 Paul H. All rights reserved.
//

import Foundation
import AVFoundation

class MorseCodePlayer {
    
    var audioPlayer: AVAudioPlayer?
    var playIndex = 0
    var soundURLs = [String: NSURL]()
    var timers: [NSTimer] = []
    var completionCallBack: (()->())?
    
    init(completion: (()->())?) {
        self.completionCallBack = completion
        
        guard let frameworkBundle = NSBundle(identifier: "ca.paulhfch.MorseConverter") else { return }
        
        if let dotSound = frameworkBundle.pathForResource("dot", ofType: "wav") {
            soundURLs["."] = NSURL(fileURLWithPath: dotSound)
        }
        if let dashSound = frameworkBundle.pathForResource("dash", ofType: "wav") {
            soundURLs["-"] = NSURL(fileURLWithPath: dashSound)
        }
    }
    
    func play(code: String) {
        // Rests intermediate values
        // TODO: This timer-based implementation seems clunky...Is there a better way?
        playIndex = 0
        timers.forEach { timer in
            timer.invalidate()
        }
        timers = []
        
        for (index, char) in code.characters.enumerate() {
            let timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(index) * 0.1, target: self, selector: #selector(onTimerExpires(_:)), userInfo: String(char), repeats: false)
            timers.append(timer)
        }
    }
    
    @objc private func onTimerExpires(timer: NSTimer) {
        playIndex++
        if playIndex >= timers.count {
            guard let callback = self.completionCallBack else { return }
            callback()
        }
        
        guard let char = timer.userInfo as? String,
            let soundURL = self.soundURLs[char] else { return }
        
        var error:NSError?
        self.audioPlayer = try? AVAudioPlayer(contentsOfURL: soundURL, fileTypeHint: "wav")
        
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
        
        if error != nil {
            print(error?.localizedDescription)
        }
    }
    
}

public extension String {
    
    func playMorseCode(completion: (()->())? = nil) {
        MorseCodePlayer(completion: completion).play(self)
    }
    
}
