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
    
    init(questionsPerRound: Int) {
        self.questionsPerRound = questionsPerRound
        quiz = Quiz(questionsPerRound: questionsPerRound)
    }
    
    func reinitQuiz() {
        self.quiz.questions.removeAll()
        self.quiz = Quiz(questionsPerRound: questionsPerRound)
    }
    
    
    func randomQuestion() -> Question {
        var randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
        return quiz.questions[randomNumber]
    }
    
    func checkAnswer(_ question: Question, userAnswer: Int) -> Bool {
        return question.answer == userAnswer
    }
}


