//
//  RPSManager.swift
//  RPSGame
//
//  Created by 김건우 on 2023/09/04.
//

import Foundation

protocol RPSManagerProtocol {
    func getRPSResult(comChoice: RPS, userChoice: RPS) -> String
    func selectRPS(withString name: String) -> RPS
}

class RPSManager: RPSManagerProtocol {
    
    func getRPSResult(comChoice: RPS, userChoice: RPS) -> String {
        if comChoice == userChoice {
            return "비겼습니다."
        } else if comChoice == .rock && userChoice == .paper {
            return "이겼습니다."
        } else if comChoice == .scissors && userChoice == .rock {
            return "이겼습니다."
        } else if comChoice == .paper && userChoice == .scissors {
            return "이겼습니다."
        } else {
            return "졌습니다."
        }
    }
    
    func selectRPS(withString name: String) -> RPS {
        switch name {
        case "가위":
            return RPS.scissors
        case "바위":
            return RPS.rock
        case "보":
            return RPS.paper
        default:
            return RPS.ready
        }
    }
}
