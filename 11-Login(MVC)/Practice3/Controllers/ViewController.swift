//
//  ViewController.swift
//  Practice3
//
//  Created by 김건우 on 7/20/23.
//

import UIKit

final class ViewController: UIViewController {

    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpAddTarget()
    }
    
    func setUpAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        let alert = UIAlertController(title: "로그인", message: "김문어님, 환영합니다!", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
    
    @objc func resetButtonPressed() {
        let alert = UIAlertController(title: "비밀번호 재설정", message: "비밀번호를 재설정하시겠습니까?", preferredStyle: .actionSheet)
        
        let okButton = UIAlertAction(title: "확인", style: .default) { action in
            print("OK Button Pressed")
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel) { action in
            print("Cancel Button Pressed")
        }
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}
