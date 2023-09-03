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
    let email : String
    let uid : String
    var profileImageUrls : [String]
    var profession : String
    var minSeekingAge : Int
    var maxSeekingAge : Int
    var bio : String
    
    init(dictionary:[String:Any]) {
        name = dictionary["fullname"] as? String ?? ""
        age = dictionary["age"] as? Int ?? 18
        email = dictionary["email"] as? String ?? ""
        uid = dictionary["uid"] as? String ?? ""
        profileImageUrls = dictionary["imageURL"] as? [String] ?? []
        profession = dictionary["profession"] as? String ?? ""
        minSeekingAge = dictionary["minSeekingAge"] as? Int ?? 18
        maxSeekingAge = dictionary["minSeekingAge"] as? Int ?? 60
        bio = dictionary["bio"] as? String ?? ""
    }
    
}
