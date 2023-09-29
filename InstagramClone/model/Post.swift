//
//  Post.swift
//  InstagramClone
//
//  Created by Bekir Geriş on 29.09.2023.
//

import Foundation

class Post {
    var documentId: String
    var postedBy: String
    var imageUrl: String
    var comment: String
    var likes: Int
    
    init(documentId: String, postedBy: String, imageUrl: String, comment: String, likes: Int) {
        self.documentId = documentId
        self.postedBy = postedBy
        self.imageUrl = imageUrl
        self.comment = comment
        self.likes = likes
    }
}
