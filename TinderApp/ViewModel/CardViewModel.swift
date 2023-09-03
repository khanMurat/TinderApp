//
//  CardViewModel.swift
//  TinderApp
//
//  Created by Murat on 25.08.2023.
//

import UIKit

class CardViewModel {
    
    let user : User
    
    let userInfoText : NSAttributedString
    
    var index = 0
    
    let imageURLs : [String]
    
    var imageUrl : URL?
    
    init(user: User) {
        self.user = user
        
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        
        attributedText.append(NSAttributedString(string: "  \(user.age)",
                                                 attributes:[.font: UIFont.systemFont(ofSize: 18, weight: .medium),.foregroundColor: UIColor.white]))
        
        self.userInfoText = attributedText
        
        self.imageURLs = user.profileImageUrls
        
        self.imageUrl = URL(string: imageURLs[0])
    }
    
     func getNextPhoto(){

         if index < user.profileImageUrls.count - 1{
             index += 1
         }
         imageUrl = URL(string: imageURLs[index])
    }

    func getPreviousPhoto(){

        if index > 0 {

            index -= 1
        }
        imageUrl = URL(string: imageURLs[index])
    }
}
