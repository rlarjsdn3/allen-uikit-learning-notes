//
//  ViewController.swift
//  TableView
//
//  Created by 김건우 on 7/24/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 멤버리스트를 관리하는 로직
    let memberListManager = MemberListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        makeUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movies = memberListManager.getMovieData()
        guard let indexPath = sender as? IndexPath else { return }
        
        if segue.identifier == "toDetailView" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.movie = movies[indexPath.row]
            }
        }
    }
    
    func makeUI() {
        title = "등장인물 목록"
        tableView.rowHeight = 120
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        memberListManager.addMovieData()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMovieData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movies = memberListManager.getMovieData()
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            let row = movies[indexPath.row]
            cell.movieImage.image = row.image
            cell.titleLabel.text = row.title
            cell.descriptionLabel.text = row.description
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailView", sender: indexPath)
    }
}
