//
//  ViewController.swift
//  RPSGame
//
//  Created by 김건우 on 2023/03/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblGameResult: UILabel!
    
    @IBOutlet var imgUserChoice: UIImageView!
    @IBOutlet var imgComputerChoice: UIImageView!

    @IBOutlet var lblUserChoice: UILabel!
    @IBOutlet var lblComputerChoice: UILabel!
    
    // 가위바위보 게임의 비즈니스 로직 관리를 위한 매니저
    let rpsManager = RPSManager()
    
    // 뷰 컨트롤러가 데이터를 소유
    var comChoice: RPS = RPS.allCases[Int.random(in: 1...3)]
    var userChoice: RPS = RPS.allCases[Int.random(in: 1...3)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getReady()
    }
    
    func getReady() {
        lblGameResult.text = "선택하세요."
        
        imgComputerChoice.image = RPS.ready.rpsInfo.image
        lblComputerChoice.text = RPS.ready.rpsInfo.name
        
        imgUserChoice.image = RPS.ready.rpsInfo.image
        lblUserChoice.text = RPS.ready.rpsInfo.name
        
        comChoice = RPS.allCases[Int.random(in: 1...3)]
        userChoice = RPS.allCases[Int.random(in: 1...3)]
    }

    @IBAction func rpsButtonPressed(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        userChoice = rpsManager.selectRPS(withString: title)
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        imgComputerChoice.image = comChoice.rpsInfo.image
        lblComputerChoice.text = comChoice.rpsInfo.name
        
        imgUserChoice.image = userChoice.rpsInfo.image
        lblUserChoice.text = userChoice.rpsInfo.name
        
        lblGameResult.text = rpsManager.getRPSResult(comChoice: self.comChoice, userChoice: self.userChoice)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        getReady()
    }
}

