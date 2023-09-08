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
    
    // 모델과 비즈니스 로직을 담은 뷰 모델 선언
    let viewModel = RPSViewModel(rpsManager: RPSManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onCompleted = { [weak self] gameResult in
            self?.imgComputerChoice.image = self?.viewModel.computerRPSImage
            self?.lblComputerChoice.text = self?.viewModel.computerRPSText
            
            self?.imgUserChoice.image = self?.viewModel.userRPSImage
            self?.lblUserChoice.text = self?.viewModel.userRPSText
            
            self?.lblGameResult.text = gameResult
        }
        
        viewModel.gameReset()
    }

    @IBAction func rpsButtonPressed(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        viewModel.getUserSelected(with: title)
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        viewModel.selectButtonPressed()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        viewModel.gameReset()
    }
}

