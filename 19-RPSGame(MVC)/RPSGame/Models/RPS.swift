//
//  RPS.swift
//  RPSGame
//
//  Created by 김건우 on 2023/03/13.
//

import UIKit

enum RPS: CaseIterable {
    case ready
    case rock
    case scissors
    case paper
    
    // RPS의 이미지 정보와 이름을 반환하는 계산 프로퍼티
    var rpsInfo: (image: UIImage, name: String) {
        switch self {
        case .ready:
            return (UIImage(named: "ready")!, "준비")
        case .rock:
            return (UIImage(named: "rock")!, "바위")
        case .scissors:
            return (UIImage(named: "scissors")!, "가위")
        case .paper:
            return (UIImage(named: "paper")!, "보")
        }
    }
}
