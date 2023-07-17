//
//  BMICalculatorManager.swift
//  Practice4
//
//  Created by 김건우 on 7/17/23.
//

import UIKit

class BMICalculatorManager {
    
    private var bmi: BMIModel?
    
    func getBMI(height: String, weight: String) -> BMIModel {
        // BMI값 계산 후 bmi 변수에 결과 대입
        calculateBMI(height: height, weight: weight)
        // BMI 정보 반환
        return bmi ?? BMIModel(bmiValue: 0.0, bmiColor: .white, bmiAdviseText: "다시 시도하세요.")
    }
    
    private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMIModel(bmiValue: 0.0, bmiColor: .white, bmiAdviseText: "다시 시도하세요.")
            return
        }
        
        var bmiNum = w / (h * h) * 10_000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(
                displayP3Red: 22/255,
                green: 231/255,
                blue: 207/255,
                alpha: 1
            )
            bmi = BMIModel(bmiValue: bmiNum, bmiColor: color, bmiAdviseText: "저체중")
        case 18.6..<23.0:
            let color = UIColor(
                displayP3Red: 212/255,
                green: 251/255,
                blue: 121/255,
                alpha: 1
            )
            bmi = BMIModel(bmiValue: bmiNum, bmiColor: color, bmiAdviseText: "표준")
        case 23.0..<25.0:
            let color = UIColor(
                displayP3Red: 218/255,
                green: 127/255,
                blue: 163/255,
                alpha: 1
            )
            bmi = BMIModel(bmiValue: bmiNum, bmiColor: color, bmiAdviseText: "과체중")
        case 25.0..<30.0:
            let color = UIColor(
                displayP3Red: 255/255,
                green: 150/255,
                blue: 141/255,
                alpha: 1
            )
            bmi = BMIModel(bmiValue: bmiNum, bmiColor: color, bmiAdviseText: "중도비만")
        case 30.0...:
            let color = UIColor(
                displayP3Red: 255/255,
                green: 100/255,
                blue: 78/255,
                alpha: 1
            )
            bmi = BMIModel(bmiValue: bmiNum, bmiColor: color, bmiAdviseText: "고도비만")
        default:
            bmi = BMIModel(bmiValue: 0.0, bmiColor: .white, bmiAdviseText: "다시 시도하세요.")
        }
    }
}
