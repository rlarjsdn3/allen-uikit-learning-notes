//
//  Observable.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import Foundation

final class ObservableData<T> {
    
    var value: T {
        didSet {
            callback?(value)
        }
    }
    
    var callback: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func biding(_ callback: @escaping (T) -> Void) {
        self.callback = callback
    }
}
