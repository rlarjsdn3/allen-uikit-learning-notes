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
    
    // 멤버 데이터를 저장한 뷰 모델 선언
    let viewModel: MemberViewModel
    
    // 뷰 모델 주입 ⭐️스토리보드로 만든 뷰가 아니기에 coder가 필요없음!
    init(viewModel: MemberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // 다만, (새로운 프로퍼티, 이니셜라이저가 있으면) 필수 이니셜라이저가 자동 상속이 되지 않기에 직접 구현
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewData()
        setUpButtonAction()
        setUpTapGesture()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupViewData() {
        self.detailView.viewModel = viewModel
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
        guard detailView.nameTextField.text != "" &&
              detailView.ageTextField.text != "" else {
            presentAlertController(animated: true)
            return
        }
        
        let image = detailView.mainImageView.image
        let name = detailView.nameTextField.text
        let age = detailView.ageTextField.text
        let phone = detailView.phoneNumberTextField.text
        let address = detailView.addressTextField.text
        
        viewModel.saveButtonPressed(image: image, name: name, age: age, phone: phone, address: address)
        
        viewModel.goBackViewController(fromVC: self, animated: true)
    }
    
    func presentAlertController(animated: Bool) {
        let alert = UIAlertController(title: "저장 실패", message: "이름과 나이를 입력해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: animated)
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
