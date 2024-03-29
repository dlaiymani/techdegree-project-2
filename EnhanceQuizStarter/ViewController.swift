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

    var questionsAsked = 0 // nb of questions asked
    var correctQuestions = 0   //nb of correct answers
    
    let quizManager = QuizManager(questionsPerRound: 4)
    var currentQuestion: Question?
    
    var timer = Timer()
    // 14 seconds since it takes 1 second for the timer to initiate the countdown
    var secondsPerQuestion = 14
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet var answersButtons: [UIButton]!

    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Rounding the corner of the buttons
        for button in answersButtons {
            button.layer.cornerRadius = 10.0
        }
        playAgainButton.layer.cornerRadius = 10.0
    
        SoundManager.playGameStartSound()
        displayQuestionAndAnswers()
    }
    
    // MARK: - Helpers
    func displayQuestionAndAnswers() {
        currentQuestion = quizManager.randomQuestion()
        questionLabel.text = currentQuestion?.title
        answerLabel.textColor = UIColor.orange
        startTimer()

        if let currentQuestion = currentQuestion {
            // Display 3 or 4 buttons depending of the number of
            // options of the current question
            
            if currentQuestion.options.count == 3 {
                answersButtons[3].isHidden = true
            }
            for (index, option) in currentQuestion.options.enumerated() {
                answersButtons[index].setTitle(option, for: .normal)                
            }
        }
        playAgainButton.isHidden = true
    }
    
    
    func displayScore() {
        // Hide the answer buttons
        for button in answersButtons {
            button.isHidden = true
        }
       
        SoundManager.playEndGame()
        // Display play again button
        playAgainButton.isHidden = false
        answerLabel.text = ""
        
        questionLabel.text = "Way to go!\nYou got \(correctQuestions) out of \(quizManager.questionsPerRound) correct!"
    }
    
    func nextRound() {
        
        // Re-enable the buttons
        for button in answersButtons {
            button.isEnabled = true
            button.isHidden = false
            button.setTitleColor(UIColor.lightGray, for: .disabled)
        }
        
        // End of a round
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
            self.reinitTimer()
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        // Disable non answered button and return the answer number
        var buttonNumber = 0
        for (index, button) in answersButtons.enumerated() {
            if button != sender {
                button.isEnabled = false
            } else {
                buttonNumber = index
            }
        }
        
        // Test if the answer is correct
        if let currentQuestion = currentQuestion  {
            let isAnswerCorrect = quizManager.checkAnswer(currentQuestion, userAnswer: buttonNumber)
            if isAnswerCorrect {
                answerLabel.textColor = UIColor(red: 0/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
                answerLabel.text = "Correct!"
                SoundManager.playCorrectAnswerSound()
                answerLabel.isHidden = false
                correctQuestions += 1

            } else {
                answerLabel.textColor = UIColor.orange
                answerLabel.text = "Sorry. That's not it."
                SoundManager.playIncorrectAnswerSound()
                answerLabel.isHidden = false
                // Display the correct answer by animating the button
                answersButtons[currentQuestion.answer].setTitleColor(UIColor.orange, for: .disabled)
                answersButtons[currentQuestion.answer].flash()
            }
        }
        loadNextRound(delay: 2)
        reinitTimer()
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
    
    
    // MARK: Timer
    func startTimer() {
        answerLabel.text = "\(secondsPerQuestion+1)"
        timer = Timer.scheduledTimer(timeInterval: 1 ,
                                     target: self,
                                     selector: #selector(self.changeDisplayLabel),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // Function called eaxh second by the timer
    @objc func changeDisplayLabel()
    {
        // End of the timer (i.e. 15s)
        if secondsPerQuestion == 0  || secondsPerQuestion < 0 {
            timer.invalidate()
            answerLabel.text = "Sorry, Too Late"
            loadNextRound(delay: 2)
            
        } else {
            answerLabel.text = "\(secondsPerQuestion)"
            secondsPerQuestion -= 1
        }
    }
    
    // Re-init the timer
    func reinitTimer() {
        timer.invalidate()
        secondsPerQuestion = 14
    }
    
}

