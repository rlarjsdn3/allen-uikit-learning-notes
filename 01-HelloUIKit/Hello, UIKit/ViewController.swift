//
//  ViewController.swift
//  Hello, UIKit
//
//  Created by 김건우 on 2023/03/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lblHello: UILabel!
    @IBOutlet var btnHello: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblHello.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        lblHello.text = "안녕하세요!"
        lblHello.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lblHello.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        lblHello.textAlignment = .right
        
        btnHello.setTitleColor(.black, for: .normal)
        btnHello.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
}

