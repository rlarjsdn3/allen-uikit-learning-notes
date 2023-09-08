//
//  ViewController.swift
//  MemberList
//
//  Created by 김건우 on 7/26/23.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(plusButtonPressed)
        )
        return button
    }()
    
    // 뷰 모델
    let viewModel: MemberListViewModel
    
    init(viewModel: MemberListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setUpNaviBar()
        setUpTableView()
        setUpTableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setUpNaviBar() {
        title = viewModel.title
        
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
        viewModel.selectTableRow(fromVC: self, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let memberCell = tableView.dequeueReusableCell(
            withIdentifier: "MemberCell", for: indexPath) as? MemberTableViewCell {
            // 셀에 새로운 뷰 모델을 전달
            let memberVM = viewModel.makeMemberViewModel(index: indexPath.row)
            memberCell.viewModel = memberVM
            
            memberCell.selectionStyle = .none
            return memberCell
        }
        return UITableViewCell()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectTableRow(indexPath.row, fromVC: self, animated: true)
    }
}
