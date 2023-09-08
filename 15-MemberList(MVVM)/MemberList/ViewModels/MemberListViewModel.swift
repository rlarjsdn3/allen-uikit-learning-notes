//
//  MemberListViewModel.swift
//  MemberList
//
//  Created by 김건우 on 2023/09/08.
//

import UIKit

final class MemberListViewModel {
    
    // 원본 데이터에 접근을 해야 하므로
    let memberListManager: MemberListProtocol
    // 네비게이션 타이틀 프로퍼티
    let title: String
    
    // 멤버 리스트 배열 데이터
    private var membersList: [Member] {
        return memberListManager.getMemberList()
    }
    
    // 의존성 주입(개선), 네비게이션 타이틀도 초기화
    init(memberListManager: MemberListProtocol, title: String) {
        self.memberListManager = memberListManager
        self.title = title
    }
    
    // 데이터를 가공해 뷰로 쏴주는 프로퍼티(Output)
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.membersList.count
    }
    
    // 멤버 뷰 모델 생성
    func makeMemberViewModel(index: Int) -> MemberViewModel {
        let member = self.membersList[index]
        return MemberViewModel(memberListManager: memberListManager, with: member, index: index)
    }
    
    // 뷰에서 뷰 모델로 데이터를 쏴주는 메서드(Input)
    func addNewMember(_ member: Member) {
        self.memberListManager.addNewMember(member)
    }
    
    func updateMemberInfo(index: Int, with member: Member) {
        self.memberListManager.updateMemberInfo(index: index, with: member)
    }
    
    // 테이블의 각 셀을 클릭하면 다음 뷰 컨트롤러로 이동하는 메서드
    func selectTableRow(_ index: Int? = nil, fromVC VC: UIViewController, animated: Bool) {
        // 기존 멤버가 있는 경우(업데이트)
        if let index = index {
            let memberVM = makeMemberViewModel(index: index) // 해당 멤버 정보를 담은 새로운 뷰 모델을 만들고
            goDetailVC(with: memberVM, fromVC: VC, animated: animated)
        // 기존 멤버가 없는 경우(추가)
        } else {
            let newMemberVM = MemberViewModel(memberListManager: self.memberListManager)
            goDetailVC(with: newMemberVM, fromVC: VC, animated: animated)
        }
    }
    
    private func goDetailVC(with memberVM: MemberViewModel, fromVC VC: UIViewController, animated: Bool) {
        
        let navVC = VC.navigationController
        
        let detailVC = DetailViewController(viewModel: memberVM)
        navVC?.pushViewController(detailVC, animated: animated)
    }
}
