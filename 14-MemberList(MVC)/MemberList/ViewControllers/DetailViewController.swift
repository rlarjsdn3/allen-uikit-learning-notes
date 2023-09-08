//
//  DetailViewController.swift
//  MemberList
//
//  Created by 김건우 on 7/26/23.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    // 이전 뷰 컨트롤러로부터 데이터 전달받기
    var member: Member?
    // 이전 뷰 컨트롤러의 테이블을 조작하기 위해 델리게이트 패턴 선언
    weak var delegate: MemberDelegate?
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpData()
        setUpButtonAction()
        setUpTapGesture()
    }
    
    private func setUpData() {
        detailView.member = member
    }
    
    func setUpButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    func setUpTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapDid))
        detailView.mainImageView.addGestureRecognizer(gesture)
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func imageViewTapDid() {
        // 기본 설정 세팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        // 기본 설정을 가지고, 피커뷰 컨트롤러 생성
        var picker = PHPickerViewController(configuration: configuration)
        // 피커뷰의 대리자 설정
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true)
    }
    
    @objc func saveButtonPressed() {
        // 멤버가 없다면 (새로운 멤버를 추가)
        if member == nil {
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            let phoneNumber = detailView.phoneNumberTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            // 새로운 멤버 생성
            var newMember = Member(
                name: name,
                age: age,
                phone: phoneNumber,
                address: address
            )
            newMember.memberImage = detailView.mainImageView.image
            
            // 1) 델리게이트 방식이 아닌 구현
//            let index = navigationController!.viewControllers.count - 2
//            if let vc = navigationController?.viewControllers[index]
//                as? ViewController {
//                vc.memberListManager.addNewMember(newMember)
//            }
            
            // 2) 델리게이트 방식으로 구현
            delegate?.addNewMember(newMember)
            
        // 멤버가 있다면 (기존 멤버를 수정)
        } else {
            member!.memberImage = detailView.mainImageView.image
            
            let memberId = Int(detailView.memberIdTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "") ?? 0
            member!.phone = detailView.phoneNumberTextField.text ?? ""
            member!.address = detailView.addressTextField.text ?? ""
            
            // 뷰에도 바뀐 멤버를 전달
            detailView.member = member
            
            // 1) 델리케이트 방식이 아닌 구현
//            let index = navigationController!.viewControllers.count - 2
//            if let vc = navigationController?.viewControllers[index] as? ViewController {
//                vc.memberListManager.updateMemberInfo(index: memberId - 1, member!)
//            }
            
            // 2) 델리게이트 방식으로 구현
            delegate?.updateMember(index: memberId - 1, member!)
        }
        
        // 이전 화면으로 넘어가기
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("deinit - DetailViewController")
    }
}

extension DetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    if let loadImage = image as? UIImage {
                        self.detailView.mainImageView.image = loadImage
                    }
                }
            }
        }
    }
}
