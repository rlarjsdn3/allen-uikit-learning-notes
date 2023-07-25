//
//  DetailViewController.swift
//  TableView
//
//  Created by 김건우 on 7/25/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeUI()
    }
    
    func makeUI() {
        title = movie?.title
        
        mainImage.image = movie?.image
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.description
    }

}
