//
//  MusicTableViewCell.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/09.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    // 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    // 셀이 재사용되기 전에 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행
        mainImageView.image = nil
    }
    
    // 스토리보드 혹은 Nib으로 만들 때, 호출되는 메서드
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // 주어진 URL을 이미지로 변환하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래 걸리는 작업이 일어나는 동안 url이 바뀔 가능성 제거
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
            
        }
    }
    
}
