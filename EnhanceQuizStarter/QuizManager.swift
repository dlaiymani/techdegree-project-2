//
//  QuestionProvider.swift
//  EnhanceQuizStarter
//
//  Created by davidlaiymani on 12/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import GameKit

class QuizManager {
    
    var quiz: Quiz
    var questionsPerRound: Int
    var currentRound: Int
    
    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
        quiz = Quiz(questionsPerRound: questionsPerRound)
        self.currentRound = 1
    }
    
    // Reinit the quiz for a new round
    func reinitQuiz() {
        self.quiz.questions.removeAll()
        self.quiz = Quiz(questionsPerRound: questionsPerRound)
        self.currentRound = 1
    }
    
    // Return a question in the quiz
    func randomQuestion() -> Question {
        
        let question = quiz.questions[currentRound - 1]
        currentRound += 1
        return question
    }

    // Check if a user answer is correct
    func checkAnswer(_ question: Question, userAnswer: Int) -> Bool {
        return question.answer == userAnswer
    }
}


