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
    
    private var index = 0
    
    var userImage : UIImage?
    
    init(user: User) {
        self.user = user
        
        
        let attributedText = NSMutableAttributedString(string: user.name,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        
        attributedText.append(NSAttributedString(string: "  \(user.age)",
                                                 attributes:[.font: UIFont.systemFont(ofSize: 18, weight: .medium),.foregroundColor: UIColor.white]))
        
        self.userInfoText = attributedText
        
    }
    
//     func getNextPhoto(){
//
//         if index < user.images.count - 1{
//             index += 1
//         }
//         self.userImage = user.images[index]
//    }
//
//    func getPreviousPhoto(){
//
//        if index > 0 {
//
//            index -= 1
//        }
//        self.userImage = user.images[index]
//    }
}
