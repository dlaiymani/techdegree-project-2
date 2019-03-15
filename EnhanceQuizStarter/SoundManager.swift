//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 13/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

// Manage the sounds of the game
struct SoundManager {
    
    static func playGameStartSound() {
        var gameSound: SystemSoundID = 0

        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    static func playCorrectAnswerSound() {
        var gameSound: SystemSoundID = 0
        
        let path = Bundle.main.path(forResource: "correct", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    static func playIncorrectAnswerSound() {
        var gameSound: SystemSoundID = 0
        
        let path = Bundle.main.path(forResource: "incorrectSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        AudioServicesPlayAlertSound(gameSound)
    }
    
    

}
