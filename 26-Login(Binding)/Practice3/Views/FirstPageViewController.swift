//
//  FirstPageViewController.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import UIKit

final class FirstPageViewController: UIViewController {

    let viewModel: FirstPageViewModel
    
    private let firstPageView = FirstPageView()
    
    init(viewModel: FirstPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = firstPageView
        self.firstPageView.basicLabel.text = self.viewModel.userEmailString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
