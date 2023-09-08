//
//  DetailView.swift
//  MemberList
//
//  Created by 김건우 on 7/26/23.
//

import UIKit

final class DetailView: UIView {

    // MARK: - 저장 프로퍼티
    
    var viewModel: MemberViewModel! {
        didSet {
            configureUI()
        }
    }
    
    // MARK: - UI 구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 정렬을 깔끔하게 하기 위한 컨테이너뷰
    private lazy var imageContainView: UIView = {
        let view = UIView()
        view.addSubview(mainImageView)
        view.backgroundColor = UIColor.yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let memberIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "멤버번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberIdTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var memberIdStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [memberIdLabel, memberIdTextField])
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .fill
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "이        름:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var nameStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .fill
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "나        이:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var ageStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [ageLabel, ageTextField])
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .fill
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "전화번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var phoneNumberStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "주       소:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.systemMint
        button.setTitle("수정", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame.size.height = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            imageContainView, memberIdStackView, nameStackView,
            ageStackView, phoneNumberStackView, addressStackView,
            saveButton
        ])
        st.axis = .vertical
        st.spacing = 10
        st.distribution = .fill
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    // 레이블 넓이 저장을 위한 프로퍼티
    let labelWidth: CGFloat = 70.0
    // 애니메이션을 위한 속성 선언
    var stackViewTopConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
        setUpMemberIdTextField()
        setUpNotification()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func configureUI() {
        guard let member = viewModel.getMember() else {
            return
        }
        
        mainImageView.image = viewModel.memberImage
        memberIdTextField.text = "\(viewModel.memberId ?? "0")"
        nameTextField.text = viewModel.nameString
        ageTextField.text = viewModel.ageString
        phoneNumberTextField.text = viewModel.phoneNumString
        addressTextField.text = viewModel.addressString
        
        saveButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    func setUpStackView() {
        backgroundColor = UIColor.white
        self.addSubview(stackView)
    }
    
    func setUpMemberIdTextField() {
        memberIdTextField.delegate = self
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageContainView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            memberIdLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            ageLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            phoneNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            addressLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ])
        
        stackViewTopConstraint = stackView.topAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10
        )
        
        NSLayoutConstraint.activate([
            stackViewTopConstraint,
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    func setUpNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(moveUpView),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(moveDownView),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func moveUpView() {
        stackViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func moveDownView() {
        stackViewTopConstraint.constant = 20
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension DetailView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == memberIdTextField {
            return false
        }
        return true
    }
}
