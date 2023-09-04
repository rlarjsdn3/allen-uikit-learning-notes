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
    
    // (데이터)와 (비즈니스+화면 로직)을 동시에 가진 뷰 모델 선언
    let viewModel: BMIViewModel
    
    // 뷰 컨트롤러의 커스텀 이니셜라이저
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.resetBMI()
        clearTextField()
    }
    
    func setup() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        heightTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
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
    
    func clearTextField() {
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == heightTextField {
            viewModel.setHeightString(textField.text ?? "")
        }
        if textField == weightTextField {
            viewModel.setWeightString(textField.text ?? "")
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        viewModel.doneButtonPressed(storyBoard: self.storyboard, fromVC: self, animated: true)
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

