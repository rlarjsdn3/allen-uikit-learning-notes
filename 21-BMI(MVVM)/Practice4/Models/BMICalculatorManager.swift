//
//  BMICalculatorManager.swift
//  Practice4
//
//  Created by 김건우 on 2023/09/04.
//

import UIKit

enum CalculatorError: Error {
    case noNumberError
    case minusNumberError
    case notAnError
}

protocol BMICalculatorManagerProtocol {
    func calculateBMI(height: String, weight: String) throws -> BMI
}

class BMICalculatorManager: BMICalculatorManagerProtocol {
    
    // BMI 계산을 위한 메서드
    func calculateBMI(height: String, weight: String) throws -> BMI {
        
        // 문자열을 숫자로 변환하기
        guard let h = Double(height), let w = Double(weight) else {
            throw CalculatorError.noNumberError
        }
        
        // 숫자가 0이상인지 확인하기
        guard h > 0, w > 0 else {
            throw CalculatorError.minusNumberError
        }
        
        // BMI 계산하기
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255,
                                green: 231/255,
                                blue: 207/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "저체중", matchColor: color)
            
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255,
                                green: 251/255,
                                blue: 121/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "표준", matchColor: color)
            
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255,
                                green: 127/255,
                                blue: 163/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "과체중", matchColor: color)
                
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255,
                                green: 150/255,
                                blue: 141/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "중도비만", matchColor: color)
                
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255,
                                green: 100/255,
                                blue: 78/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "고도비만", matchColor: color)
                
        default:
            throw CalculatorError.notAnError
        }
    }
    
}
