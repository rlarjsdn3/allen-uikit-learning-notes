//
//  ViewController.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/09.
//

import UIKit

final class ViewController: UIViewController {

    // 서치 컨트롤러 선언
    let searchController = UISearchController(
        searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController")
        as! SearchResultViewController
    )
    
    @IBOutlet weak var musicTableView: UITableView!
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManager.shared
    
    // 음악 데이터를 다루기 위한 배열
    var musicArrays: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData(searchTerm: "coldplay")
        setupSearchBar()
        setupTable()
    }
    
    // 데이터 셋업을 위한 메서드
    func setupData(searchTerm: String) {
        networkManager.fetchMusic(searchTerm: searchTerm) { result in
            switch result {
            case .success(let data):
                self.musicArrays = data
                
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 서치바 셋업을 위한 메서드
    func setupSearchBar() {
        self.title = "음악 검색"
        navigationItem.searchController = searchController
        
        // 단순 서치바 사용을 위한 델리게이트 선언
        searchController.searchResultsUpdater = self
        
        // 첫글자에 대문자 출력하지 않도록 하기
        searchController.searchBar.autocapitalizationType = .none
    }

    // 테이블 뷰 셋팅을 위한 메서드
    func setupTable() {
        musicTableView.delegate = self
        musicTableView.dataSource = self
        
        musicTableView.register(
            UINib(nibName: Cell.musicCellIdentifier, bundle: nil),
            forCellReuseIdentifier: Cell.musicCellIdentifier
        )
    }

}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let vc = searchController.searchResultsController as? SearchResultViewController {
            vc.searchTerm = searchController.searchBar.text ?? ""
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath)
            as? MusicTableViewCell {
            cell.imageUrl = musicArrays[indexPath.row].imageUrl
            cell.songNameLabel.text = musicArrays[indexPath.row].songName
            cell.artistNameLabel.text = musicArrays[indexPath.row].artistName
            cell.albumNameLabel.text = musicArrays[indexPath.row].albumName
            cell.releaseDateLabel.text = musicArrays[indexPath.row].releaseDateString
            
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
