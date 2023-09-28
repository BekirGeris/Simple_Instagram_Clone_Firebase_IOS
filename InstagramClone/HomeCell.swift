//
//  HomeCell.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 29.09.2023.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var userEmailText: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var likeCountText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeClick(_ sender: Any) {
    }
}
