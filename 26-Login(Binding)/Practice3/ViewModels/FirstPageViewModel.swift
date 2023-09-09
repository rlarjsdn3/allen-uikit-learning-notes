//
//  FirstPageViewModel.swift
//  Practice3
//
//  Created by 김건우 on 2023/09/09.
//

import Foundation

final class FirstPageViewModel {
    
    // 데이터
    private var userEmail: String
    
    // Output
    var userEmailString: String {
        return userEmail
    }
    
    init(userEmail: String) {
        self.userEmail = userEmail
    }
    
}
