//
//  Question.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 12/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//


struct Question {
    let title: String
    let answer: Bool
    
    func isCorrectAnswer(_ answer: Bool) -> Bool {
        return answer == self.answer
    }
}

