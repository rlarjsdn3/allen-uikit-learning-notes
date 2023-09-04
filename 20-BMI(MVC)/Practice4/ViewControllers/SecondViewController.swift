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
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        bmiLabel.text = "\(bmi?.value ?? 0)"
        bmiLabel.clipsToBounds = true
        bmiLabel.layer.cornerRadius = 10
        bmiLabel.backgroundColor = bmi?.matchColor

        backButton.setTitle("되돌아가기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 10

        adviceLabel.text = bmi!.advice
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
