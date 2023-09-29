//
//  HomeCell.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 29.09.2023.
//

import UIKit
import FirebaseFirestore

class HomeCell: UITableViewCell {

    @IBOutlet weak var userEmailText: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var likeCountText: UILabel!
    
    var documentId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeClick(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeCountText?.text ?? "0") {
            let likeStore = ["likes": likeCount + 1] as [String: Any]
            print("document: \(documentId)")
            firestoreDatabase.collection("Posts").document(documentId).setData(likeStore, merge: true)
        }
        
    }
}
