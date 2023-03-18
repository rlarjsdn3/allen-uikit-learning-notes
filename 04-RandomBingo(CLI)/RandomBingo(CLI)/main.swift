//
//  main.swift
//  RandomBingo(CLI)
//
//  Created by 김건우 on 2023/03/18.
//

import Foundation

var userChoice = 0
let computerChoice = Int.random(in: 1...100)

while true {
    // 사용자로부터 정수 N 입력 받기
    let userInput = readLine()
    
    if let input = userInput {
        if let number = Int(input) {
            userChoice = number
        }
    }
    
    // 사용자의 입력이 컴퓨터의 수보다 더 크면
    if userChoice > computerChoice {
        print("DOWN")
    // 사용자의 입력이 컴퓨터의 수보다 더 작으면
    } else if userChoice < computerChoice {
        print("UP")
    // 사용자의 입력이 컴퓨터의 수와 동일하면
    } else {
        print("Bingo")
        break // while문 탈출
    }
}
