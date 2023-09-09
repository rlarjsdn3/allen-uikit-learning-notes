//
//  ViewController.swift
//  Practice3
//
//  Created by 김건우 on 7/20/23.
//

import UIKit

final class LoginViewController: UIViewController {

    let viewModel = LoginViewModel()
    
    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTarget()
    }
    
    func setUpTarget() {
        loginView.viewModel = viewModel
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        self.viewModel.loginButtonPressed(fromVC: self, animated: true)
    }
    
    @objc func resetButtonPressed() {
        let alert = UIAlertController(
            title: "비밀번호 재설정",
            message: "비밀번호를 재설정하시겠습니까?",
            preferredStyle: .actionSheet
        )
        
        let okButton = UIAlertAction(
            title: "확인", style: .default) { action in
            print("OK Button Pressed")
        }
        let cancelButton = UIAlertAction(
            title: "취소", style: .cancel) { action in
            print("Cancel Button Pressed")
        }
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}
