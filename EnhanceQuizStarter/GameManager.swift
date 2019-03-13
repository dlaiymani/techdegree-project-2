//
//  QuestionProvider.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 12/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import GameKit

class GameManager {
    
//    let questions = [Question(title: "Only female koalas can whistle", answer: false),
//                   Question(title: "Blue whales are technically whales", answer: true),
//                   Question(title: "Camels are cannibalistic", answer: false),
//                   Question(title: "All ducks are birds", answer: true)
//    ]
    
    let questions = [Question(title: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 2),
        Question(title: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 1),
        Question(title: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], answer: 3),
        Question(title: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: 3),
        Question(title: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], answer: 4),
        Question(title: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argetina", "Spain"], answer: 2),
        Question(title: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: 2),
        Question(title: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: 1),
        Question(title: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], answer: 1),
        Question(title: "Which of these countries won the most medals in the 2012 Summer Games? ", options: ["France", "Germany", "Japan", "Great Britian"], answer: 4)
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


