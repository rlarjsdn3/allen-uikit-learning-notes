//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by 김건우 on 2023/08/11.
//

import UIKit

final class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var todoTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    // ToDoData를 전달받을 변수
    var toDoData: ToDoData? {
        didSet {
            configureUIWithData()
        }
    }
    
    // 뷰 컨트롤러의 클로저를 저장해 동작을 전달
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        backgroundCell.clipsToBounds = true
        backgroundCell.layer.cornerRadius = 8
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 10
    }
    
    func configureUIWithData() {
        todoTextLabel.text = toDoData?.memoText
        // ...
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        // 내 자신의 ToDoCell을 전달하면서 뷰 컨트롤러의 클로저 실행
        updateButtonPressed(self)
    }
}
