//
//  ViewController.swift
//  ToDoApp
//
//  Created by 김건우 on 2023/08/11.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNaviBar() {
        self.title = "메모"
        
        // 네비게이션 바 우측에 plus 버튼 만들기
        let plusButton = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed)
        )
        plusButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // 테이블의 선 없애기
        tableView.separatorStyle = .none
    }

    @objc func plusButtonPressed() {
        self.performSegue(withIdentifier: "ToDoCell", sender: nil)
    }
    
    // 직・간접 세그웨이 동작 시, 데이터 전달을 위해 자동으로 호출되는 메서드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
}
