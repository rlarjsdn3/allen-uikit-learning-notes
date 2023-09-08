//
//  RPSViewModel.swift
//  RPSGame
//
//  Created by 김건우 on 2023/09/04.
//

import UIKit

class RPSViewModel {
    
    // 가위바위보 게임의 비지니스 로직 관리를 위한 매니저
    let rpsManager: RPSManagerProtocol
    
    // (뷰 컨트롤러가 아니라) 뷰 모델이 데이터를 소유
    private var gameResult: String = "선택하세요." {
        didSet {
            onCompleted(gameResult)
        }
    }
    
    private var comChoice: RPS = RPS.ready
    private var userChoice: RPS = RPS.ready
    
    // 뷰에 표시할 데이터를 뷰 모델에서 가공해 전달
    var gameResultString: String {
        return gameResult
    }
    
    var computerRPSImage: UIImage {
        return comChoice.rpsInfo.image
    }
    
    var computerRPSText: String {
        return comChoice.rpsInfo.name
    }
    
    var userRPSImage: UIImage {
        return userChoice.rpsInfo.image
    }
    
    var userRPSText: String {
        return userChoice.rpsInfo.name
    }
    
    // 게임 결과가 갱신되면 화면에 표시할 이미지와 텍스트를 변경시킴
    var onCompleted: (String) -> Void = { _ in }
    
    // 의존성 주입(개선)으로 뷰 모델이 여러가지 형태의 매니저를 받을 수 있도록 함
    init(rpsManager: RPSManagerProtocol) {
        self.rpsManager = rpsManager
    }
    
    // 가위바위보 게임 초기화(리셋)
    func gameReset() {
        comChoice = RPS.ready
        userChoice = RPS.ready
        gameResult = "선택하세요."
    }
    
    // 가위바위보 버튼을 클릭하면 동작할 로직
    func getUserSelected(with title: String) {
        userChoice = rpsManager.selectRPS(withString: title)
    }
    
    // 선택 버튼을 클릭하면 동작할 로직
    func selectButtonPressed() {
        comChoice = RPS.allCases[Int.random(in: 1...3)]
        gameResult = rpsManager.getRPSResult(comChoice: comChoice, userChoice: userChoice)
    }
    
}
