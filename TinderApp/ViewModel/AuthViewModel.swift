//
//  AuthViewModel.swift
//  TinderApp
//
//  Created by Murat on 28.08.2023.
//

import UIKit

struct LoginViewModel {
    
    var email : String?
    
    var password : String?
    
    var isEnabled : Bool {
        
        return email?.isEmpty == false && password?.isEmpty == false
        
    }
    
    var backGroundColor : UIColor {
        
        return isEnabled ? .systemPink.withAlphaComponent(0.2) : .white.withAlphaComponent(0.3)
    }
    
    
}

struct RegisterViewModel {
    
    var email : String?
    
    var password : String?
    
    var fullname : String?
    
    var isEnabled : Bool {
        
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false
        
    }
    
    var backGroundColor : UIColor {
        
        return isEnabled ? .systemPink.withAlphaComponent(0.2) : .white.withAlphaComponent(0.3)
    }
    
    
}
