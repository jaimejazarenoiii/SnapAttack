//
//  ViewController.swift
//  SnapAttack
//
//  Created by Jaime Jazareno III on 03/01/2018.
//  Copyright © 2018 Jaime Jazareno III. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var firstCard: UIImageView!
    @IBOutlet weak var secondCard: UIImageView!
    @IBOutlet weak var startGameButton: UIButton!
    
    var timer = Timer()
    var cardTimer = Timer()
    var timeInt = 20
    var score = 0
    var gameMode = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startGame(_ sender: Any) {
        if timeInt == 20 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            cardTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCards), userInfo: nil, repeats: true)
            
            startGameButton.isEnabled = false
            startGameButton.alpha = 0.25
            startGameButton.setTitle("Snap", for: UIControlState.normal)
        }
        
        if gameMode == 1 {
            if firstCard.image == secondCard.image {
                score += 1
                scoreLabel.text = String("Score: \(score)")
            }
            else{
                if score > 0 {
                    score -= 1
                    scoreLabel.text = String("Score: \(score)")
                }
            }
        }
        else{
            score = 0
            timeInt = 20
            gameMode = 0
            
            scoreLabel.text = String("Score: \(score)")
            startGameButton.setTitle("Start", for: UIControlState.normal)
            timeLabel.text = String("Time: \(timeInt)")
            
            firstCard.image = UIImage(named: "blue_cover")
            secondCard.image = UIImage(named: "blue_cover")
        }
    }
    
    @objc func updateTimer(){
        timeInt -= 1
        timeLabel.text = String("Time: \(timeInt)")
        startGameButton.isEnabled = true
        startGameButton.alpha = 1
        
        gameMode = 1
        if timeInt == 0 {
            timer.invalidate()
            cardTimer.invalidate()
            gameMode = 0
            startGameButton.setTitle("Restart", for: UIControlState.normal)
        }
    }
    
    @objc func updateCards() {
        
        let cardList = ["ace_of_hearts",
                        "2_of_hearts",
                        "3_of_hearts",
                        "4_of_hearts",
                        "5_of_hearts",
                        "6_of_hearts",
                        "7_of_hearts",
                        "8_of_hearts",
                        "9_of_hearts",
                        "10_of_hearts"]
        
        let random1 = Int(arc4random_uniform(UInt32(cardList.count)))
        firstCard.image = UIImage(named: cardList[random1])
        let random2 = Int(arc4random_uniform(UInt32(cardList.count)))
        secondCard.image = UIImage(named: cardList[random2])
        
    }
    
}

