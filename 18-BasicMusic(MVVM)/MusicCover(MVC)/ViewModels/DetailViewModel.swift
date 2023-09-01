//
//  DetailViewModel.swift
//  MusicCover(MVC)
//
//  Created by 김건우 on 2023/09/01.
//

import UIKit

final class DetailViewModel {
    
    var networkManager: MusicNetwork?
    
    // 음악 데이터 모델 (뷰 모델이 모델을 가짐)
    var music: Music? {
        didSet {
            print("music") // for debug
            loadImage()
        }
    }
    
    var albumImage: UIImage? {
        didSet {
            print("albumImage") // for debug
            onCompeleted(albumImage)
        }
    }
    
    // 커버 이미지가 바뀌면 뷰에서 할 동작을 클로저 형태로 정의
    var onCompeleted: (UIImage?) -> Void = { _ in }
    
    // 뷰를 위한 데이터
    var songNameString: String? {
        return music?.songName
    }
    
    // 주소로 이미지 불러오기
    func loadImage() {
        networkManager?.loadImage(imageUrl: music?.imageUrl) { [weak self] image in
            print("loadImage") // for debug
            self?.albumImage = image
        }
    }
}

