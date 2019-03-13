//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var questionsAsked = 0
    var correctQuestions = 0    
    
    let quizManager = QuizManager(questionsPerRound: 4)
    var currentQuestion: Question?
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerField: UILabel!
    
    @IBOutlet var answersButtons: [UIButton]!

    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize an array containing the four answer buttons
        
        for button in answersButtons {
            button.layer.cornerRadius = 10.0
        }
        
        answerField.isHidden = true
        playAgainButton.layer.cornerRadius = 10.0
                
        SoundManager.playGameStartSound()
        displayQuestionAndAnswers()
    }
    
    // MARK: - Helpers
    
    
    func displayQuestionAndAnswers() {
        currentQuestion = quizManager.randomQuestion()
        questionField.text = currentQuestion?.title
        
        if let currentQuestion = currentQuestion {
            var i = 0
            for button in answersButtons {
                button.setTitle(currentQuestion.options[i], for: .normal)
                i += 1
            }
        }

        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        
        for button in answersButtons {
            button.isHidden = true
        }
       
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(quizManager.questionsPerRound) correct!"
    }
    
    func nextRound() {
        answerField.isHidden = true
        
        for button in answersButtons {
            button.isEnabled = true
        }
        
        if questionsAsked == quizManager.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestionAndAnswers()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        // Disable non answered button and return the answer number
        var numButton = 0
        for (index, button) in answersButtons.enumerated() {
            if button != sender {
                button.isEnabled = false
            } else {
                numButton = index
            }
        }
        
        // Test if the answer is correct
        if let currentQuestion = currentQuestion  {
            let isAnswerCorrect = quizManager.checkAnswer(currentQuestion, userAnswer: numButton)
            if isAnswerCorrect {
                answerField.textColor = UIColor(red: 0/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
                answerField.text = "Correct!"
                answerField.isHidden = false
                correctQuestions += 1

            } else {
                answerField.textColor = UIColor.orange
                answerField.text = "Sorry. That's not it."
                answerField.isHidden = false
            }
        }
        loadNextRound(delay: 2)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        for button in answersButtons {
            button.isHidden = false
        }
        
        questionsAsked = 0
        correctQuestions = 0
        quizManager.reinitQuiz()

        nextRound()
    }
    

}

