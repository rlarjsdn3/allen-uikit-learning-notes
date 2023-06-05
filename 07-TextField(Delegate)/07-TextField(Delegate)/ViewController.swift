//
//  ViewController.swift
//  07-TextField(Delegate)
//
//  Created by 김건우 on 2023/05/29.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpView() {
        view.backgroundColor = UIColor.lightGray
        
        textField.delegate = self
        
        textField.placeholder = "이메일 입력"
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        
        textField.becomeFirstResponder()
        
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
    // 텍스트필드에 입력되는 각 글자를 개별적으로 처리하는 메소드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil {
            return false
        } else {
            guard let text = textField.text else { return false }
            let newLength = text.count + string.count - range.length
            print("text.count: \(text.count)")  // 현재 텍스트필드 입력의 길이
            print("string.count: \(string.count)")  // 새로운 입력의 길이
            print("range.length: \(range.length)")  // 삭제된 입력의 길이
            return newLength <= 10
        }
    }
    
    // 텍스트필드의 확인 버튼 클릭의 허용 여부를 결정하는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 텍스트필드의 입력이 주어진 경우
        if !checkEmptyTextField() {
            textField.placeholder = "문자열을 입력해주세요!"
            return false
        }
        return true
    }
    
    func checkEmptyTextField() -> Bool {
        guard let text = textField.text else { return false }
        if text.isEmpty {
            return false
        } else {
            return true
        }
    }
}

