//
//  ViewController.swift
//  MusicCollection
//
//  Created by 김건우 on 2023/08/09.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
}
