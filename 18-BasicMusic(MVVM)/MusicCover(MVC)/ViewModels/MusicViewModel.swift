//
//  MusicViewModel.swift
//  MusicCover(MVC)
//
//  Created by 김건우 on 2023/09/01.
//

import Foundation

final class MusicViewModel {
    
    let networkManager: MusicNetwork = NetworkManager()
    
    // 음악 데이터 모델 (뷰 모델이 모델을 가짐)
    var music: Music? {
        didSet {
            onCompleted(self.music)
        }
    }
    
    // 음악 데이터가 바뀌면 뷰에서 할 동작을 클로저 형태로 정의
    var onCompleted: (Music?) -> Void  = { _ in }
    
    // 뷰를 위한 데이터
    var songNameString: String? {
        return music?.songName
    }
    
    var albumNameString: String? {
        return music?.albumName
    }
    
    var artistNameString: String? {
        return music?.artistName
    }
    
    func startButtonPressed() {
        networkManager.fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                DispatchQueue.main.async {
                    self?.music = music
                }
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱 에러")
                }
            }
        }
    }
    
    func getDetailViewModel() -> DetailViewModel {
        let detailVM = DetailViewModel()
        
        detailVM.networkManager = self.networkManager
        detailVM.music = music
        
        return detailVM
    }
}
