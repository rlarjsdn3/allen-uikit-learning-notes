//
//  ViewController.swift
//  DiceGame
//
//  Created by 김건우 on 2023/03/13.
//

import UIKit

class ViewController: UIViewController {
    var dice: [UIImage?] = []
    
    @IBOutlet var firstDiceImageView: UIImageView!
    @IBOutlet var secondDiceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for i in 1...6 {
            dice.append(UIImage(named: "black" + "\(i)"))
        }
        
        firstDiceImageView.image = dice[1]
        secondDiceImageView.image = dice[2]
    }

    @IBAction func btnRollDice(_ sender: UIButton) {
        firstDiceImageView.image = dice.randomElement()!
        secondDiceImageView.image = dice.randomElement()!
    }
}

