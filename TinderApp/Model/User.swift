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
    //var images : [UIImage]
    let email : String
    let uid : String
    let profileImageUrl : [String]
    var profession : String
    var minSeekingAge : Int
    var maxSeekingAge : Int
    var bio : String
    
    init(dictionary:[String:Any]) {
        name = dictionary["fullname"] as? String ?? ""
        age = dictionary["age"] as? Int ?? 18
        //images = dictionary["imageURL"] as? [UIImage] ?? []
        email = dictionary["email"] as? String ?? ""
        uid = dictionary["uid"] as? String ?? ""
        profileImageUrl = dictionary["imageURL"] as? [String] ?? []
        profession = dictionary["profession"] as? String ?? ""
        minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 0
        maxSeekingAge = dictionary["minSeekingAge"] as? Int ?? 0
        bio = dictionary["bio"] as? String ?? ""
    }
    
}
