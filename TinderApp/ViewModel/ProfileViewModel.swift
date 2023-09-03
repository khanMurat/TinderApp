//
//  ProfileViewModel.swift
//  TinderApp
//
//  Created by Murat on 4.09.2023.
//

import UIKit

struct ProfileViewModel {
    
    private let user : User
    
    let userDetailsAttributedString : NSAttributedString
    
    let profession : String
    
    let bio : String
    
    var imageCount : Int {
        
        return user.profileImageUrls.count
    }
    
    
    var profileImageURLs : [String] {
        return user.profileImageUrls
    }
    
    init(user:User){
        self.user = user
        
        let attributedText = NSMutableAttributedString(string: user.name,attributes: [.font : UIFont.systemFont(ofSize: 24,weight: .semibold)])
        
        attributedText.append(NSAttributedString(string: String(user.age),attributes: [.font:UIFont.systemFont(ofSize: 22)]))
        
        userDetailsAttributedString = attributedText
        
        profession = user.profession
        
        bio = user.bio
    }
    
    func imageURL(withIndex : Int) -> URL? {
        
        return URL(string: profileImageURLs[withIndex])
    }
    
}
