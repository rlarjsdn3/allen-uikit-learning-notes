//
//  ViewController.swift
//  MemberList
//
//  Created by 김건우 on 7/26/23.
//

import UIKit

final class ViewController: UIViewController {

    let memberListManager = MemberListManager()
    
    private let tableView = UITableView()
    
    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(plusButtonPressed)
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setUpNaviBar()
        setUpTableView()
        setUpTableViewConstraints()
        
        requestData()
    }
    
    func requestData() {
        memberListManager.requestMemeberList()
    }
    
    func setUpNaviBar() {
        title = "회원 목록"
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.systemMint
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        // 네비게이션의 오른쪽 상단에 버튼 추가
        navigationItem.rightBarButtonItem = plusButton
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    func setUpTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func plusButtonPressed() {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMemberList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let memberCell = tableView.dequeueReusableCell(
            withIdentifier: "MemberCell", for: indexPath) as? MemberTableViewCell {
            memberCell.member = memberListManager[indexPath.row]
            memberCell.selectionStyle = .none
            return memberCell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.member = memberListManager[indexPath.row]
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: MemberDelegate {
    func addNewMember(_ member: Member) {
        memberListManager.addNewMember(member)
        tableView.reloadData()
    }
    
    func updateMember(index: Int, _ member: Member) {
        memberListManager.updateMemberInfo(index: index, member)
        tableView.reloadData()
    }
    
    
}
