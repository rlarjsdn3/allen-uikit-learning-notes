//
//  ViewController.swift
//  MusicCover(MVC)
//
//  Created by 김건우 on 2023/09/01.
//

import UIKit

class ViewController: UIViewController {
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "앨범 제목"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "노래 제목"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "아티스트 이름"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            albumNameLabel, songNameLabel, artistNameLabel
        ])
        st.axis = .vertical
        st.spacing = 8
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGray
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(
            self,
            action: #selector(startButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.purple
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(
            self,
            action: #selector(nextButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            startButton, nextButton
        ])
        st.axis = .horizontal
        st.spacing = 20
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    // 뷰 모델 (뷰와 관련된 모든 로직이 담겨 있음)
    var viewModel: MusicViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MusicViewModel()
        self.viewModel.onCompleted = { [weak self] music in
            self?.songNameLabel.text = music?.songName
            self?.artistNameLabel.text = music?.artistName
            self?.albumNameLabel.text = music?.albumName
        }
        
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        self.view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            labelStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            labelStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40)
        ])
        
        self.view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            buttonStackView.heightAnchor.constraint(equalToConstant: 45),
            buttonStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }

    @objc func startButtonPressed() {
        self.viewModel.startButtonPressed()
    }
    
    @objc func nextButtonPressed() {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.getDetailViewModel()
        
        detailVC.modalPresentationStyle = .pageSheet
        self.present(detailVC, animated: true)
    }
}

