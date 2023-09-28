//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 28.09.2023.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        cell.commentText.text = "dskflnvskldfnv "
        cell.userEmailText.text = "sdvndslnv"
        cell.likeCountText.text = "1"
        return cell
    }
}
