//
//  Comment.swift
//  RealApp
//
//  Created by user186492 on 25.02.2021.
//

import Foundation

struct Comment {
    var postId : Int
    var id : Int
    var name : String
    var email : String
    var body : String
    
    init( dictionary : [String : Any] ) {
        self.id = dictionary["id"] as? Int ?? 0
        self.postId = dictionary["postId"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.body = dictionary["body"] as? String ?? ""
        
    }
    
}
