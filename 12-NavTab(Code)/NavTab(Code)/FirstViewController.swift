//
//  ViewController.swift
//  NavTab(Code)
//
//  Created by 김건우 on 7/27/23.
//

import UIKit

class FirstViewController: UIViewController {

    // 로그인 여부를 확인하는 프로퍼티
    var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        // 네비게이션 바 설정
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground() // 불투명으로
        
        navigationController?.navigationBar.tintColor = UIColor.systemMint
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        title = "메인"
        
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

