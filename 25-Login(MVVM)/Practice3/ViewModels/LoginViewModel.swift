//
//  LoginViewModel.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import UIKit

enum LoginStatus {
    case none // 로그인 전
    case validationFailed // 입력 실패
    case loginDenied // 로그인 거절
    case authenticated // 로그인 성공
}

final class LoginViewModel {
    
    // 유저가 입력한 글자 데이터
    private var emailString: String = ""
    private var passwordString: String = ""
    
    // 로그인 상태 데이터
    private var loginStatus: LoginStatus = .none
    
    // 뷰에서 뷰 모델로 데이터를 보내는 메서드(Input)
    func setEmailText(_ email: String) {
        self.emailString = email
    }
    
    func setPasswordText(_ password: String) {
        self.passwordString = password
    }
    
    // 로그인 버튼을 클릭하면 실행되는 메서드
    func loginButtonPressed(fromVC VC: UIViewController, animated: Bool) {
        // 이메일이나 패스워드가 비어있다면
        guard !(emailString.isEmpty || passwordString.isEmpty) else {
            self.loginStatus = .validationFailed
            return
        }
        
        LoginManager.shared.loginTest(username: emailString, password: passwordString) { [weak self] result in
            switch result {
            case .success(let _):
                // 로그인 상태 변경
                self?.loginStatus = .authenticated
                self?.goToNextVC(fromVC: VC, animated: animated)
            case .failure(let _):
                // 로그인 상태 변경
                self?.loginStatus = .loginDenied
                print("로그인 실패")
            }
        }
    }
    
    func goToNextVC(fromVC VC: UIViewController, animated: Bool) {
        let firstVM = FirstPageViewModel(userEmail: self.emailString)
        let nextVC = FirstPageViewController(viewModel: firstVM)
        nextVC.modalPresentationStyle = .fullScreen
        VC.present(nextVC, animated: animated)
    }
    
}
