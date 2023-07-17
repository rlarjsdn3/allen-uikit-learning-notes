//
//  SubViewController.swift
//  Practice4
//
//  Created by 김건우 on 7/16/23.
//

import UIKit

class SubViewController: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmi: BMIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeUI()
    }
    
    func makeUI() {
        bmiLabel.text = String(bmi?.bmiValue ?? 0.0)
        bmiLabel.clipsToBounds = true
        bmiLabel.layer.cornerRadius = 10
        bmiLabel.backgroundColor = bmi?.bmiColor
        
        backButton.setTitle("되돌아가기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 10
        
        descLabel.text = bmi?.bmiAdviseText
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
