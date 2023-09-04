//
//  MemberTableViewCell.swift
//  MemberList
//
//  Created by 김건우 on 7/26/23.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    // MARK: - 멤버 프로퍼티 선언
    
    var member: Member? {
        // 멤버 값이 변경된 후
        didSet {
            guard var member = member else { return }
            mainImageView.image = member.memberImage
            memberNameLabel.text = member.name
            addressLabel.text = member.address
            
            // NOTE: - guard let member로 작성하면 'Cannot use mutating getter on immutable value: 'member' is a 'let' constant' 에러가 발생합니다.
            //       - 구조체는 값 타입이고, 내부 프로퍼티가 변경될 때마다 새로운 구조체 인스턴스가 할당됩니다. 이때, memberImage 프로퍼티는 lazy var(mutating)인데,
            //       - member를 let으로 선언했다면, 새로운 구조체 인스턴스가 member에 할당될 수 없기 때문에 let이 아닌 var로 선언해야 합니다.
        }
    }
    
    // MARK: - UI 구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .fill
        st.spacing = 5
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 세팅
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageView.clipsToBounds = true
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.size.width / 2
    }
    
    func makeUI() {
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(stackView)
        
        // 스택 뷰 위에 뷰 올리기
        stackView.addArrangedSubview(memberNameLabel)
        stackView.addArrangedSubview(addressLabel)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 40),
            mainImageView.widthAnchor.constraint(equalToConstant: 40),
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            mainImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            memberNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.mainImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
        ])
    }
}
