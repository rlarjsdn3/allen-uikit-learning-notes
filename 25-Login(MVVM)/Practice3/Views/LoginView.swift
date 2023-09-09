//
//  LoginView.swift
//  Practice3
//
//  Created by 김건우 on 7/21/23.
//

import UIKit

class LoginView: UIView {
    
    var viewModel: LoginViewModel!
    
    // MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    // "이메일 또는 전화번호" 안내 문구
    private lazy var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private let emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = UIColor.clear
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // "비밀번호" 안내 문구
    private lazy var passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = UIColor.clear
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = true
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // 패스워드에 "표시" 버튼 - 비밀번호 가리기 기능
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(
            red: 0.8374180198, green: 0.8374378085, blue:0.8374271393, alpha: 1), for: .normal
        )
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 로그인 버튼
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor.init(gray: 1.0, alpha: 0.8)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.isEnabled = false
        //button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let st = UIStackView(
            arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton]
        )
        st.axis = .vertical
        st.spacing = 18
        st.alignment = .fill
        st.distribution = .fillEqually
        return st
    }()
    
    // 비밀번호 재설정 버튼
    let passwordResetButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //button.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // 3개의 각 텍스트필드 및 버튼 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토 레이아웃 향후 변경을 위한 변수
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupAutoLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        backgroundColor = UIColor.black
        [stackView, passwordResetButton].forEach { addSubview($0) }
    }
    
    private func setupAutoLayout() {
        emailInfoLabelConstraints()
        emailTextFieldConstraints()
        passwordInfoLabelConstraints()
        passwordTextFieldConstraints()
        passwordSecureButtonConstraints()
        stackViewConstraints()
        passwordResetButtonConstraints()
    }
    
    private func emailInfoLabelConstraints() {
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailInfoLabelCenterYConstraint
        ])
    }
    
    private func emailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8)
        ])
    }
    
    private func passwordInfoLabelConstraints() {
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordInfoLabelCenterYConstraint
        ])
    }
    
    private func passwordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8)
        ])
        
    }
    
    private func passwordSecureButtonConstraints() {
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8)
        ])
        
    }
    
    private func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36)
        ])
    }
    
    private func passwordResetButtonConstraints() {
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
        ])
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        // MARK: - 이메일주소 입력 ===> 뷰모델에 전달 ⭐️⭐️⭐️ (Input)
        if textField == emailTextField {
            viewModel.setEmailText(textField.text ?? "")
        }
        
        // MARK: - 비밀번호 입력 ===> 뷰모델에 전달 ⭐️⭐️⭐️ (Input)
        if textField == passwordTextField {
            viewModel.setPasswordText(textField.text ?? "")
        }
        
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            loginButton.layer.borderColor = CGColor.init(gray: 1.0, alpha: 0.8)
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        
        loginButton.layer.borderColor = UIColor.clear.cgColor
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
        
        if passwordTextField.isSecureTextEntry {
            passwordSecureButton.setTitle("표시", for: .normal)
        } else {
            passwordSecureButton.setTitle("숨기기", for: .normal)
        }
    }
    
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = UIColor.gray
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = UIColor.gray
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = UIColor.darkGray
            // 빈 칸이면 원래대로 되돌리기
            if textField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = UIColor.darkGray
            // 빈 칸이면 원래대로 되돌리기
            if textField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
}
