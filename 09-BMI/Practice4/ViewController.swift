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
    
    var bmi: Double?
    
    
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
                subVC.bmi = bmi
                subVC.color = getBackgroundColor()
                subVC.desc = getBMIAdviceString()
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
        guard let h = heightTextField.text,
              let w = weightTextField.text else { return }
        bmi = calculateBMI(height: h, weight: w)
    }
    
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else { return 0.0 }
        var bmi = w / (h * h) * 10_000
        bmi = round(bmi * 10) / 10
        print("BMI 결과값: \(bmi)")
        return bmi
    }
    
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "#" }
            
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
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

