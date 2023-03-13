//
//  RPS.swift
//  RPSGame
//
//  Created by 김건우 on 2023/03/13.
//

import Foundation

enum RPS: Int {
    case rock
    case paper
    case scissors
    
    var label: String {
        switch self {
        case .rock:
            return "바위"
        case .paper:
            return "보"
        case .scissors:
            return "가위"
        }
    }
    
    var image: String {
        switch self {
        case .rock:
            return "rock"
        case .paper:
            return "paper"
        case .scissors:
            return "scissors"
        }
    }
}
