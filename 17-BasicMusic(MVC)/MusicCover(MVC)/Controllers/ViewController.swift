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
    
    // 네트워크 매니저 (의존성 주입)
    let networkManger: MusicNetwork = NetworkManager()
    
    // 음악 데이터 모델
    var music: Music? {
        didSet {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    // ⭐️ VC가 뷰와 모델을 함께 가지고 있기에 VC가 너무 비대해지는 문제가 존재한다.
    // 이 문제를 해결하기 위해 MVVM 패턴이 탄생하게 되었다. 뷰를 구성하는 모든 로직은 ViewModel에 구현한다.
    // (그렇다고 MVC가 나쁜 디자인 패턴이란 소리는 아니다. 어느 패턴이든 완벽한 디자인 패턴은 없다!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAutoLayout()
    }
    
    func configureUI() {
        self.songNameLabel.text = music?.songName
        self.artistNameLabel.text = music?.artistName
        self.albumNameLabel.text = music?.albumName
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
        networkManger.fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                self?.music = music
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱 에러")
                }
            }
        }
    }
    
    @objc func nextButtonPressed() {
        guard let music = self.music else { return }
        
        let detailVC = DetailViewController()
        detailVC.music = music
        detailVC.networkManager = self.networkManger
        
        detailVC.modalPresentationStyle = .pageSheet
        self.present(detailVC, animated: true)
    }
}

