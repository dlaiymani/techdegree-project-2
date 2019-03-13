//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var questionsAsked = 0
    var correctQuestions = 0    
    var gameSound: SystemSoundID = 0
    
    let quizManager = QuizManager(questionsPerRound: 4)
    var currentQuestion: Question?
    
    var answersButtons = [UIButton]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerField: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!

    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize an array containing the four answer buttons
        answersButtons = [answerOneButton, answerTwoButton, answerThreeButton, answerFourButton]
        for i in 0...3 {
            answersButtons[i].layer.cornerRadius = 10.0
        }
        
        answerField.isHidden = true
        playAgainButton.layer.cornerRadius = 10.0
                
        loadGameStartSound()
        playGameStartSound()
        displayQuestionAndAnswers()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestionAndAnswers() {
        currentQuestion = quizManager.randomQuestion()
        questionField.text = currentQuestion?.title
        
        if let currentQuestion = currentQuestion {
            for i in 0...3 {
                answersButtons[i].setTitle(currentQuestion.options[i], for: .normal)
            }
        }

        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer uttons
        for i in 0...3 {
            answersButtons[i].isHidden = true
        }
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(quizManager.questionsPerRound) correct!"
    }
    
    func nextRound() {
        answerField.isHidden = true
        for i in 0...3 {
            answersButtons[i].isEnabled = true
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
        
        let index = answersButtons.index(where: {$0 == sender})
        
        if let currentQuestion = currentQuestion, let i = index {
            for button in 0...3 {
                if button != i {
                    answersButtons[button].isEnabled = false
                }
            }
            
            let isAnswerCorrect = quizManager.checkAnswer(currentQuestion, userAnswer: i)
            if isAnswerCorrect {
                answerField.textColor = UIColor(red: 0/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
                answerField.text = "Correct!"
                answerField.isHidden = false

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
        answerOneButton.isHidden = false
        answerTwoButton.isHidden = false
        answerThreeButton.isHidden = false
        answerFourButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        quizManager.reinitQuiz()

        nextRound()
    }
    

}

