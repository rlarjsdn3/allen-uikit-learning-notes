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
    
    var bmiCalculateManger = BMICalculatorManager()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        makeUI()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text != "" && weightTextField.text != "" {
            return true
        }
        mainLabel.textColor = UIColor.red
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSubView" {
            if let subVC = segue.destination as? SubViewController {
                subVC.bmi = bmiCalculateManger.getBMI(
                    height: heightTextField.text!,
                    weight: weightTextField.text!
                )
            }
        }
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func makeUI() {
        mainLabel.text = "키와 몸무게를 입력해주세요"
        
        doneButton.setTitle("BMI 계산하기", for: .normal)
        doneButton.clipsToBounds = true
        doneButton.layer.cornerRadius = 10
        
        heightTextField.placeholder = "cm 단위로 입력"
        heightTextField.returnKeyType = .next
        
        weightTextField.placeholder = "kg 단위로 입력"
        weightTextField.returnKeyType = .done
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        // subViewController로 화면 이동(풀스크린)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 숫자가 입력되었거나 지우는 경우
        if Int(string) != nil || string == "" {
            return true // 글자 입력을 허용함
        }
        return false // 글자 입력을 허용하지 않음
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "" && weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
}

