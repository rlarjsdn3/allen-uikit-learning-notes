//
//  ViewController.swift
//  Practice4
//
//  Created by 김건우 on 7/16/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    // BMI 계산을 위한 매니저(비즈니스 로직) 선언
    let bmiManager = BMICalculatorManager()
    
    // 데이터 모델 선언
    var bmi: Double?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "키와 몸무게를 입력해주세요."
        
        doneButton.setTitle("BMI 계산하기", for: .normal)
        doneButton.clipsToBounds = true
        doneButton.layer.cornerRadius = 10
        
        heightTextField.placeholder = "cm 단위로 입력"
        heightTextField.returnKeyType = .next
        
        weightTextField.placeholder = "kg 단위로 입력"
        weightTextField.returnKeyType = .done
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        // 텍스트필드 중 하나라도 비어있는 경우
        if heightTextField.text == "" || weightTextField.text == "" {
            showWarningAlert()
            
            mainLabel.text = "키와 몸무게를 입력해주세요."
            mainLabel.textColor = UIColor.red
        } else {
            mainLabel.text = "키와 몸무게를 입력해주세요."
            mainLabel.textColor = UIColor.black
            
            if let secondVC = storyboard?.instantiateViewController(
                withIdentifier: "SecondViewController") as? SecondViewController {
                secondVC.bmi = bmiManager.calculateBMI(
                    height: heightTextField.text!,
                    weight: heightTextField.text!
                )
                
                secondVC.modalPresentationStyle = .fullScreen
                self.present(secondVC, animated: true)
                
                heightTextField.text = ""
                weightTextField.text = ""
            }
        }
    }
    
    func showWarningAlert() {
        let alert = UIAlertController(
            title: "계산 실패",
            message: "올바른 형식의 값을 입력해주세요.",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 숫자가 입력되었거나 지우는 경우
        if Int(string) != nil || string == "" {
            return true // 입력 가능
        }
        return false // 입력 불가능
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 텍스트필드 모두 입력된 경우
        if heightTextField.text != "" && weightTextField.text != "" {
            // 키보드 내리기
            weightTextField.resignFirstResponder()
            return true
        // 키(height) 텍스트필드만 입력된 경우
        } else if heightTextField.text != "" {
            // 몸무게(weight) 텍스트필드로 키보드 올리기
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}

