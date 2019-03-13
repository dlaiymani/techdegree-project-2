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
    
    // TODO: Rework with a GameManager!!!
    // such as randomly generating a question to be displayed, handing that question over to whatever object needs it and checking if the user guessed correctly. Your view controller then asks for the question, updates it’s UI and responds to user interaction.
    var questionsAsked = 0
    var correctQuestions = 0    
    var gameSound: SystemSoundID = 0
    
    let gameManager = GameManager(questionsPerRound: 4)
    var currentQuestion: Question?
    
    
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
        
        answerOneButton.layer.cornerRadius = 10.0
        answerTwoButton.layer.cornerRadius = 10.0
        answerThreeButton.layer.cornerRadius = 10.0
        answerFourButton.layer.cornerRadius = 10.0
        answerField.isHidden = true
        playAgainButton.layer.cornerRadius = 10.0
                
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
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
    
    func displayQuestion() {
        currentQuestion = gameManager.randomQuestion()
        questionField.text = currentQuestion?.title
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer uttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(gameManager.questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == gameManager.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
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
        
        if let currentQuestion = currentQuestion {
            if sender == trueButton {
                questionField.text = gameManager.checkAnswer(currentQuestion, userAnswer: true)
            } else {
                questionField.text = gameManager.checkAnswer(currentQuestion, userAnswer: false)

            }
        }
        
        loadNextRound(delay: 2)
        
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

}

