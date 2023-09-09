//
//  FirstPageView.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import UIKit

class FirstPageView: UIView {

    let basicLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 글자"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = UIColor.orange
        self.addSubview(basicLabel)
    }
    
    func setupAutoLayout() {
        basicLabelConstraints()
    }

    func basicLabelConstraints() {
        NSLayoutConstraint.activate([
            basicLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            basicLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            basicLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 200)
        ])
    }
    
}
