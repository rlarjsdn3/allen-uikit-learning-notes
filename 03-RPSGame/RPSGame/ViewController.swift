//
//  ViewController.swift
//  RPSGame
//
//  Created by 김건우 on 2023/03/13.
//

import UIKit

class ViewController: UIViewController {
    let readyText = "준비"
    let readyImage = UIImage(named: "ready")
    
    var userChoice: RPS!
    var computerChoice: RPS!
    
    @IBOutlet var lblGameResult: UILabel!
    
    @IBOutlet var imgUserChoice: UIImageView!
    @IBOutlet var imgComputerChoice: UIImageView!

    @IBOutlet var lblUserChoice: UILabel!
    @IBOutlet var lblComputerChoice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reset()
    }

    @IBAction func btnChoiceRPS(_ sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case "가위":
                userChoice = .scissors
            case "바위":
                userChoice = .rock
            case "보":
                userChoice = .paper
            default:
                break
            }
        }
    }
    
    @IBAction func btnSelect(_ sender: UIButton) {
        // 유저와 컴퓨터의 선택값을 출력
        showChoice(.user, choice: userChoice)
        showChoice(.computer, choice: computerChoice)
        
        // 유저의 선택과 컴퓨터의 선택이 같으면
        if userChoice == computerChoice {
            lblGameResult.text = "무승부"
        // 유저의 선택과 컴퓨터의 선택이 같지 않으면
        } else {
            switch userChoice {
            // 유저가 승리하면
            case .rock where computerChoice == .scissors:
                fallthrough
            case .paper where computerChoice == .rock:
                fallthrough
            case .scissors where computerChoice == .paper:
                lblGameResult.text = "승리"
            // 유저가 패배하면
            default:
                lblGameResult.text = "패배"
            }
        }
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        reset()
    }
    
    func randomRPS() -> RPS? {
        return RPS(rawValue: Int.random(in: 0...2))
    }
    
    func showChoice(_ who: Who, choice: RPS) {
        switch who {
        case .user:
            setUserImageLabel(rps: choice)
        case .computer:
            setComputerImageLabel(rps: choice)
        }
    }
    
    func setUserImageLabel(rps: RPS) {
        imgUserChoice.image = UIImage(named: rps.image)
        lblUserChoice.text = rps.label
    }
    
    func setComputerImageLabel(rps: RPS) {
        imgComputerChoice.image = UIImage(named: rps.image)
        lblComputerChoice.text = rps.label
    }
    
    func reset() {
        lblGameResult.text = "선택하세요"
        
        imgComputerChoice.image = readyImage
        imgUserChoice.image = readyImage
        
        lblComputerChoice.text = readyText
        lblUserChoice.text = readyText
        
//        userChoice = randomRPS()
        computerChoice = randomRPS()
    }
}

