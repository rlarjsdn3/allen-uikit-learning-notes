//
//  Member.swift
//  MemberList
//
//  Created by 김건우 on 7/26/23.
//

import UIKit

struct Member {
    
    lazy var memberImage: UIImage? = {
        // 이름이 없다면, 시스템 이미지 반환
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        // 해당 이름으로 된 이미지가 없다면, 시스템 이미지 반환
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    // 멤버의 (절대적) 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 1
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    // 새로운 멤버를 생성할 때
    init(image: UIImage? = nil, name: String?, age: Int?, phone: String?, address: String?) {
        
        // 타입 프로퍼티의 절대적 값으로 세팅 (자동 순번)
        self.memberId = Member.memberNumbers
        
        // 나머지 프로퍼티는 직접 세팅
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        // 멤버를 생성한다면, 멤버의 수 1 더하기
        Member.memberNumbers += 1
    }
    
    // 기존 멤버를 업데이트할 때
    init(existingMember: Member, image: UIImage? = nil, name: String?, age: Int?, phone: String?, address: String?) {
        
        // 인스턴스를 기존 멤버로 바꾸기
        self = existingMember
        
        self.memberImage = image
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
    }
}
