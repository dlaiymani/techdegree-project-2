//
//  Quiz.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 13/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import GameKit


class Quiz {
    
   let questionsSet = [Question(title: "This was the only US President to serve more than two consecutive terms.", options: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answer: 1),
                        Question(title: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: 0),
                        Question(title: "In what year was the United Nations founded?", options: ["1918", "1919", "1945", "1954"], answer: 2),
                        Question(title: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", options: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: 2),
                        Question(title: "Which nation produces the most oil?", options: ["Iran", "Iraq", "Brazil", "Canada"], answer: 3),
                        Question(title: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Italy", "Brazil", "Argetina", "Spain"], answer: 1),
                        Question(title: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo", "Mekong"], answer: 1),
                        Question(title: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: 0),
                        Question(title: "Which country was the first to allow women to vote in national elections?", options: ["Poland", "United States", "Sweden", "Senegal"], answer: 0),
                        Question(title: "Which of these countries won the most medals in the 2012 Summer Games? ", options: ["France", "Germany", "Japan", "Great Britian"], answer: 3),
                        Question(title: "250 x 3 + 12 = ?", options: ["762", "752", "3750"], answer: 0),
                        Question(title: "In what year was the French Revolution?", options: ["1789", "1792", "1968"], answer: 0),
                        Question(title: "27 / 0 = ?", options: ["27", "1", "Impossible"], answer: 2),
                        Question(title: "Who won the Literature Nobel Prize in 1971?", options: ["Albert Camus", "Samuel Beckett", "Pablo Neruda"], answer: 2)
                        ]
    
    var questions: [Question] // a sub-set of questionsSet
    var questionsPerRound: Int
    
    init(questionsPerRound: Int) {
       
        self.questionsPerRound = questionsPerRound
        self.questions = [Question]()
        
        // Ensure no duplicate questions in the quiz. questionSet have 4 elements at least
        var alreadyChoosenQuestion = [Int]()
        for _ in 0..<questionsPerRound {
            var randomNumber = 0
            repeat {
                randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionsSet.count)
            } while alreadyChoosenQuestion.index(where: {$0 == randomNumber}) != nil
            alreadyChoosenQuestion.append(randomNumber)
            
            self.questions.append(questionsSet[randomNumber])
        }
    }
}
