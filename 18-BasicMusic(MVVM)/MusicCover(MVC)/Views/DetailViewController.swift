//
//  DetailViewController.swift
//  MusicCover(MVC)
//
//  Created by 김건우 on 2023/09/01.
//

import UIKit

class DetailViewController: UIViewController {

    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "음악 제목"
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            imageView, songNameLabel
        ])
        st.axis = .vertical
        st.spacing = 8
        st.alignment = .fill
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("BACK", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(backButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    // 뷰 모델 (뷰와 관련된 모든 로직이 담겨 있음)
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    override func updateViewConstraints() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1.0),
            
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40)
        ])
        
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            backButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            backButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        super.updateViewConstraints()
    }
    
    func configureUI() {
        self.songNameLabel.text = self.viewModel.songNameString
        
        self.viewModel.onCompeleted = { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        
        print("confugureUI") // for debug
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true)
    }
}
