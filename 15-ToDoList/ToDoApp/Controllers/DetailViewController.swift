//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by 김건우 on 2023/08/11.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    
    // 버튼에 쉽게 접근하기 위해 배열로 만들어 놓기
    lazy var buttons: [UIButton] = {
        return [redButton, greenButton, blueButton, purpleButton]
    }()
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // 코어 데이터를 관리하는 매니저 (싱글톤)
    let todoManager = CoreDataManager.shared
    
    var toDoData: ToDoData? {
        didSet {
            temporaryNum = toDoData?.color
        }
    }
    
    // ToDo 색깔 구분을 위해 임시적으로 숫자를 저장하는 변수
    var temporaryNum: Int64? = 1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 모든 버튼에 설정 변경
        buttons.forEach { button in
            button.clipsToBounds = true
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    func setup() {
        mainTextView.delegate = self
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 8
        clearButtonColors()
    }
    
    func setupNavi() {
        let deleteButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(trashButtonPressed)
        )
        deleteButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    func configureUI() {
        // 기존 데이터가 있을 때
        if let toDoData = self.toDoData {
            self.title = "메모 수정하기"
            setupNavi()
            
            guard let text = toDoData.memoText else { return }
            mainTextView.text = text
            
            mainTextView.textColor = UIColor.black
            saveButton.setTitle("수정", for: .normal)
            mainTextView.becomeFirstResponder()
            let color = MyColor(rawValue: toDoData.color)
            setupColorTheme(color: color)
        // 기존 데이터가 없을 때
        } else {
            self.title = "메모 생성하기"
            
            mainTextView.text = "텍스트를 여기에 입력하세요."
            mainTextView.textColor = .lightGray
            setupColorTheme(color: .red)
        }
        setupColorButton(color: MyColor(rawValue: temporaryNum ?? 1))
    }
    
    func clearButtonColors() {
        redButton.backgroundColor = MyColor.red.backgoundColor
        redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        greenButton.backgroundColor = MyColor.green.backgoundColor
        greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        blueButton.backgroundColor = MyColor.blue.backgoundColor
        blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        purpleButton.backgroundColor = MyColor.purple.backgoundColor
        purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    func setupColorButton(color: MyColor?) {
        switch color {
        case .red:
            redButton.backgroundColor = MyColor.red.buttonColor
            redButton.setTitleColor(.white, for: .normal)
        case .green:
            greenButton.backgroundColor = MyColor.green.buttonColor
            greenButton.setTitleColor(.white, for: .normal)
        case .blue:
            blueButton.backgroundColor = MyColor.blue.buttonColor
            blueButton.setTitleColor(.white, for: .normal)
        case .purple:
            purpleButton.backgroundColor = MyColor.purple.buttonColor
            purpleButton.setTitleColor(.white, for: .normal)
        default:
            redButton.backgroundColor = MyColor.red.buttonColor
            redButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func setupColorTheme(color: MyColor? = .red) {
        backgroundView.backgroundColor = color?.backgoundColor
        saveButton.backgroundColor = color?.buttonColor
    }
    
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        // 임시 숫자 저장
        self.temporaryNum = Int64(sender.tag)
        
        let color = MyColor(rawValue: Int64(sender.tag))
        setupColorTheme(color: color)
        
        clearButtonColors()
        setupColorButton(color: color)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // 기존 데이터가 있을 때
        if let toDoData = self.toDoData {
            // 텍스트 뷰에 저장되어 있는 메세지
            toDoData.memoText = mainTextView.text
            toDoData.color = temporaryNum ?? 1
            todoManager.updateToDo(newToDoData: toDoData) {
                print("업데이트 완료")
                // 이전 화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        // 기존 데이터가 없을 때
        } else {
            let memoText = mainTextView.text
            todoManager.saveToDoData(toDoText: memoText, colorInt: temporaryNum ?? 1) {
                print("저장 완료")
                // 이전 화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func trashButtonPressed() {
        let alert = UIAlertController(title: "삭제", message: "해당 메모를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.todoManager.deleteToDo(data: (self?.toDoData)!) {
                print("삭제 완료")
                // 이전 화면으로 돌아가기
                self?.navigationController?.popViewController(animated: true)
            }
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = UIColor.lightGray
        }
    }
}
