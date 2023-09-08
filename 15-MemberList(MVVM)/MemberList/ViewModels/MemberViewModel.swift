//
//  MemberViewModel.swift
//  MemberList
//
//  Created by 김건우 on 2023/09/08.
//

import UIKit

final class MemberViewModel {
    
    // 원본 데이터에 접근이 해야 하므로
    let memberListManager: MemberListProtocol
    
    private var member: Member?
    private var index: Int?
    
    // 의존성 주입(개선), 멤버 업데이트 위치를 파악하기 위해 인덱스도 초기화
    init(memberListManager: MemberListProtocol, with member: Member? = nil, index: Int? = nil) {
        self.memberListManager = memberListManager
        self.member = member
        self.index = index
    }
    
    // 데이터를 가공해 뷰로 쏴주는 프로퍼티(Output)
    var memberId: String? {
        String(member?.memberId ?? 0)
    }
    
    var memberImage: UIImage? {
        member?.memberImage
    }
    
    var nameString: String? {
        member?.name
    }
    
    var ageString: String? {
        String(member?.age ?? 0)
    }
    
    var phoneNumString: String? {
        member?.phone
    }
    
    var addressString: String? {
        member?.address
    }
    
    var buttonTitle: String {
        member == nil ? "Save" : "Update"
    }
    
    func getMember() -> Member? {
        return member
    }
    
    // 뷰에서 뷰 모델로 데이터를 쏴주는 메서드(Input)
    func saveButtonPressed(image: UIImage?, name: String?, age: String?, phone: String?, address: String?) {
        // 기존 멤버가 있는 경우(업데이트)
        if let _ = member {
            self.updateMember(image: image, name: name, age: age, phone: phone, address: address)
        // 기존 멤버가 없는 경우(추가)
        } else {
            self.addNewMember(image: image, name: name, age: age, phone: phone, address: address)
        }
    }
    
    // 멤버를 추가하고, 업데이트하는 로직
    private func updateMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String?) {
        
        guard let member = self.member,
              let index = self.index else { return }
        
        let ageInt = Int(age ?? "") ?? 0
        
        // 뷰 모델이 가진 멤버 업데이트
        self.member = Member(existingMember: member, image: image, name: name, age: ageInt, phone: phone, address: address)
        
        // 실제 멤버 데이터 업데이트
        self.memberListManager.updateMemberInfo(index: index, with: self.member!)
    }
    
    private func addNewMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String?) {
        
        let ageInt = Int(age ?? "") ?? 0
        
        // 새로운 멤버 생성
        let newMember = Member(image: image, name: name, age: ageInt, phone: phone, address: address)
        
        // 실제 멤버 데이터에 추가하기
        self.memberListManager.addNewMember(newMember)
    }
    
    // 이전 화면으로 돌아가기
    func goBackViewController(fromVC VC: UIViewController, animated: Bool) {
        let navVC = VC.navigationController
        navVC?.popViewController(animated: animated)
    }
}
