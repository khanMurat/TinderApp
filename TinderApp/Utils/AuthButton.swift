//
//  AuthButton.swift
//  TinderApp
//
//  Created by Murat on 28.08.2023.
//

import UIKit


class AuthButton : UIButton {
    
    
    init(title:String,type:ButtonType) {
         super.init(frame: .zero)
         
         layer.cornerRadius = 5
         setTitle(title, for: .normal)
         isEnabled = false
         backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
