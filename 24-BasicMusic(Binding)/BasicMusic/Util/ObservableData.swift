//
//  ObservableData.swift
//  BasicMusic
//
//  Created by 김건우 on 2023/09/08.
//

import Foundation

// ⭐️데이터를 클래스로 감싸는 게 핵심
class ObservableData<T> {
    
    // 값이 변할때마다 onCompleted 클로저 호출하기
    var data: T {
        didSet {
            onCompleted?(data)
        }
    }
    
    // ⭐️data가 변할 때 =====> 함수 호출
    var onCompleted: ((T) -> Void)?
    
    init(_ value: T) {
        self.data = value
    }
    
    func binding(callback: @escaping (T) -> Void) {
        self.onCompleted = callback
    }
}
