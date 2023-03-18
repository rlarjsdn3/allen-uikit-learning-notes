//
//  ViewController.swift
//  RandomBingo
//
//  Created by 김건우 on 2023/03/18.
//

import UIKit

class ViewController: UIViewController {
    var userChoice = 1
    var computerChoice = Int.random(in: 1...10)
    
    @IBOutlet var lblUpDown: UILabel!
    @IBOutlet var lblNumber: UILabel!
    
    @IBOutlet var btnSelect: UIButton!
    @IBOutlet var btnReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reset()
    }

    @IBAction func btnNumber(_ sender: UIButton) {
        guard let string = sender.currentTitle else {
            return
        }
        lblNumber.text = string
        
        guard let number = Int(string) else {
            return
        }
        userChoice = number
        
        btnSelect.isEnabled = true
    }
    
    @IBAction func btnSelectNumber(_ sender: UIButton) {
        // 사용자가 선택한 수가 컴퓨터의 수보다 크면
        if userChoice > computerChoice {
            lblUpDown.text = "DOWN"
        // 사용자가 선택한 수가 컴퓨터의 수보다 작으면
        } else if userChoice < computerChoice {
            lblUpDown.text = "UP"
        // 사용자가 선택한 수가 컴퓨터의 수와 동일하면
        } else {
            lblUpDown.text = "Bingo😃"
            btnReset.isEnabled = true
            btnSelect.isEnabled = false
        }
    }
    
    @IBAction func btnReesetNumber(_ sender: UIButton) {
        reset()
    }
    
    func reset() {
        lblUpDown.text = "선택하세요"
        lblNumber.text = ""
        computerChoice = Int.random(in: 1...10)
        btnReset.isEnabled = false
    }
}

