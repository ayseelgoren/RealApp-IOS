//
//  Photo.swift
//  RealApp
//
//  Created by user186492 on 23.02.2021.
//

import Foundation

struct Photo {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailUrl : String
    
    init( dictionary : [String : Any] ) {
        self.id = dictionary["id"] as? Int ?? 0
        self.albumId = dictionary["albumId"] as? Int ?? 0
        self.title = dictionary["title"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        self.thumbnailUrl = dictionary["thumbnailUrl"] as? String ?? ""
        
    }
    
}
