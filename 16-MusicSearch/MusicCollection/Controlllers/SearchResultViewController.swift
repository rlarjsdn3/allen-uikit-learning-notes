//
//  SearchResultViewController.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/10.
//

import UIKit

final class SearchResultViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 컬렉션 뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManager.shared
    
    // 음악 데이터를 다루기 위한 배열
    var musicArrays: [Music] = []
    
    // 검색을 위한 단어를 담는 변수 (이전 화면에서 전달받음)
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupCollectionView()
    }
    
    func setupCollectionView() {
//        collectionView.delegate = self
        collectionView.dataSource = self
        // 컬렉션 뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .vertical
        
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWidth * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        // 아이템 사이즈 설정
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWidth
        // 아이템 양 옆 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWidth
        
        // 컬렉션 뷰의 속성 할당
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setupDatas() {
        // 옵셔널 바인딩
        guard let term = searchTerm else { return }
        
        // (네트워크 시작 전) 다시 빈 배열로 만들기
        self.musicArrays = []
        
        // 네트워킹 시작
        networkManager.fetchMusic(searchTerm: term) { result in
            switch result {
            case .success(let data):
                self.musicArrays = data
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionCellIdentifier, for: indexPath)
            as? MusicCollectionViewCell {
            cell.imageUrl = musicArrays[indexPath.row].imageUrl
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArrays.count
    }
}
