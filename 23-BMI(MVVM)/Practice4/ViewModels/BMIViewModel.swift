//
//  BMIViewModel.swift
//  Practice4
//
//  Created by 김건우 on 2023/09/04.
//

import Foundation
import UIKit.UIColor

class BMIViewModel {
    
    // BMI 계산을 담당하는 매니저(비즈니스 로직)
    var bmiCalculatorManager: BMICalculatorManagerProtocol
    
    // 뷰를 위한 데이터
    private var mainText: String = "키와 몸무게를 입력하세요."
    
    private var heightString: String = ""
    private var weightString: String = ""
    
    private var bmi: BMI?
    
    // 뷰로 데이터를 내보내는 계산 프로퍼티
    var mainTextString: String {
        return mainText
    }
    
    var mainLabelTextColor: UIColor {
        return UIColor.black
    }
    
    var bmiNumberString: String {
        return String(bmi?.value ?? 0.0)
    }
    
    var bmiAdviceString: String {
        return bmi?.advice ?? ""
    }
    
    var bmiColor: UIColor {
        return bmi?.matchColor ?? UIColor.white
    }
    
    // 의존성 주입(개선)
    init(bmiManager: BMICalculatorManagerProtocol) {
        self.bmiCalculatorManager = bmiManager
    }
    
    // 뷰로부터 입력을 받는 메서드
    func setHeightString(_ height: String) {
        self.heightString = height
    }
    
    func setWeightString(_ weight: String) {
        self.weightString = weight
    }
    
    // 계산 버튼을 클릭하면 동작하는 메서드
    func doneButtonPressed(storyBoard: UIStoryboard?, fromVC VC: UIViewController, animated: Bool) {
        if self.makeBMI() {
            segueSecondVC(storyBoard: storyBoard, fromVC: VC, animated: animated)
        } else {
            print("Error: BMI 계산 실패")
        }
    }
    
    // 주어진 키, 몸무게 값으로 BMI를 계산하는 메서드
    func makeBMI() -> Bool {
        do {
            bmi = try bmiCalculatorManager.calculateBMI(
                height: self.heightString,
                weight: self.weightString
            )
            return true // 정상적으로 BMI 계산을 하면 true 반환
        } catch {
            guard let error = error as? CalculatorError else { return false }
            switch error {
            case .noNumberError:
                print("noNumberError: 숫자가 아닌 값이 입력됨")
            case .minusNumberError:
                print("minusNumberError: 0미만 수가 입력됨")
            default:
                break
            }
            return false // BMI 계산에 실패하면 false 반환
        }
    }
    
    // 입력값을 초기화(리셋)하는 메서드
    func resetBMI() {
        heightString = ""
        weightString = ""
        
        bmi = nil
    }
    
    // 다음 화면으로 이동하는 메서드
    func segueSecondVC(storyBoard: UIStoryboard?, fromVC VC: UIViewController, animated: Bool) {
        
        // 커스텀 이니셜라이저를 통해 뷰 컨트롤러 생성
        guard let secondVC = storyBoard?.instantiateViewController(identifier: "SecondViewController", creator: { coder in
            SecondViewController(coder: coder, viewModel: self) }) else {
            return
        }
        
        secondVC.modalPresentationStyle = .fullScreen
        VC.present(secondVC, animated: true)
    }
}
