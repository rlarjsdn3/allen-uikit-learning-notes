//
//  BindableTextField.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import UIKit

final class BindableTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget()
    }
    
    // 스토리보드 생성 시 호출
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTarget() {
        self.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let text = textField.text {
            callback(text)
        }
    }
    
    private var callback: (String) -> Void = { _ in }
    
    func binding(callback: @escaping (String) -> Void) {
        self.callback = callback
    }
    
    
}
