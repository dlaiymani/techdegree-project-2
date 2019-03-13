//
//  QuestionProvider.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 12/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import GameKit

class GameManager {
    
    let questions = [Question(title: "Only female koalas can whistle", answer: false),
                   Question(title: "Blue whales are technically whales", answer: true),
                   Question(title: "Camels are cannibalistic", answer: false),
                   Question(title: "All ducks are birds", answer: true)
    ]
    var questionsPerRound = 4
    
    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
    }
    
    
    func randomQuestion() -> Question {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        return questions[randomNumber]
    }
    
    func checkAnswer(_ question: Question, userAnswer: Bool) -> String {
        if question.answer == userAnswer {
            return "Correct!"
        } else {
            return "Sorry, wrong answer!"
        }
    }
    
    
}


