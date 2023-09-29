//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 28.09.2023.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    var postList = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        getDataFromFirestore()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        cell.documentId = postList[indexPath.row].documentId
        cell.commentText.text = postList[indexPath.row].comment
        cell.userEmailText.text = postList[indexPath.row].postedBy
        cell.likeCountText.text = String(postList[indexPath.row].likes)
        cell.imageView?.sd_setImage(with: URL(string: postList[indexPath.row].imageUrl))
        return cell
    }
    
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.postList.removeAll()
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        if let postedBy = document.get("postedBy") as? String,
                           let comment = document.get("comment") as? String,
                           let imageUrl = document.get("imageUrl") as? String,
                           let likes = document.get("likes") as? Int {
                            self.postList.append(Post(documentId: documentId, postedBy: postedBy, imageUrl: imageUrl, comment: comment, likes: likes))
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
