//
//  ViewController.swift
//  BullsEye
//
//  Created by Esteban Trevino on 8/13/18.
//  Copyright © 2018 Esteban Trevino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var round = 1
    var randomNumberGenerated = 0
    
    
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var horizontalSlider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var previousGuessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomNumber()
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        previousGuessLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func hitmeButtonPressed(_ sender: UIButton) {
        //determine user guess
        let userGuess = Int(horizontalSlider.value)
        //call function to determine points scored this round
        let pointsScored = (determinePointsScored(randomNumber: randomNumberGenerated, userGuess: userGuess))
        //call function to determine notification title for alert
        let notificationTitle = determineNotificationTitle(pointsScoredInput: pointsScored)
        //alert set up
        let alert = UIAlertController(title: notificationTitle, message: "You scored \(pointsScored) points", preferredStyle: UIAlertControllerStyle.alert)
        //add alert ok action button
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.updateScoreAndRound(pointsScored: pointsScored, userGuess: String(userGuess))
        }))
        //present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
            resetGame()
    }
    
    
    
    //function that generates a random number
    func generateRandomNumber(){
        let randomNumber = arc4random_uniform(99) + 1
        randomNumberLabel.text = String(randomNumber)
        randomNumberGenerated = Int(randomNumber)
    }
    //function to determine how many points earned
    func determinePointsScored(randomNumber: Int, userGuess: Int) -> Int{
        var score = 0
        let pointDecision = abs(randomNumber - userGuess)
        //conditional logic
        if pointDecision == 0{
            score = 200
        } else if pointDecision <= 2{
            score = 150
        } else if pointDecision <= 5 {
            score = 100
        } else if pointDecision <= 10 {
            score = 50
        } else{
            score = 25
        }
        return score
    }
    //function to determine title notification in popup
    func determineNotificationTitle(pointsScoredInput: Int) -> String{
        var titleNotification = ""
        if pointsScoredInput == 200{
            titleNotification = "Perfect!"
        } else if pointsScoredInput >= 100{
           titleNotification = "Almost had it!"
        }else{
            titleNotification = "Better luck next time"
        }
        return titleNotification
    }
    //function to update score and round
    func updateScoreAndRound(pointsScored : Int, userGuess : String){
        score = score + pointsScored
        round = round + 1
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
        previousGuessLabel.isHidden = false
         previousGuessLabel.text = "\(userGuess)"
    }
    //function to reset the game
    func resetGame(){
        score = 0
        round = 1
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
        generateRandomNumber()
        previousGuessLabel.isHidden = true
    }
}

