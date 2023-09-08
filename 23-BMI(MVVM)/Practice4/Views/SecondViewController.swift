//
//  SubViewController.swift
//  Practice4
//
//  Created by 김건우 on 7/16/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 이전 화면에서 뷰 모델을 전달받아야 함
    let viewModel: BMIViewModel
    
    // 뷰 컨트롤러의 커스텀 이니셜라이저
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        bmiLabel.text = viewModel.bmiNumberString
        bmiLabel.clipsToBounds = true
        bmiLabel.layer.cornerRadius = 10
        bmiLabel.backgroundColor = viewModel.bmiColor

        backButton.setTitle("되돌아가기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 10

        adviceLabel.text = viewModel.bmiAdviceString
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
