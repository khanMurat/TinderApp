//
//  User.swift
//  TinderApp
//
//  Created by Murat on 25.08.2023.
//

import UIKit

struct User {
    
    var name : String
    var age : Int
    var images : [UIImage]
    
    init(dictionary:[String:Any]) {
        name = dictionary["fullname"] as? String ?? ""
        age = dictionary["age"] as? Int ?? 18
        images = dictionary["imageURL"] as? [UIImage] ?? []
    }
    
}
