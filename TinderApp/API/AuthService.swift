//
//  AuthService.swift
//  TinderApp
//
//  Created by Murat on 1.09.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials{
    let email:String
    let password:String
    let fullname:String
    let profileImage:UIImage
}

struct AuthService {
    
    
    static func registerUser(withCredentials:AuthCredentials,completion:@escaping ((Error?)->Void)){
        
        Service.uploadImage(image: withCredentials.profileImage) { imageURL in
            
                
                Auth.auth().createUser(withEmail: withCredentials.email, password: withCredentials.password) { result, error in
                    
                    if let error = error {
                        
                        print("Error : \(error.localizedDescription)")
                        completion(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let data : [String:Any] = ["email":withCredentials.email,
                                                  "fullname":withCredentials.fullname,
                                                  "imageURL":imageURL,
                                                  "uid":uid,
                                                  "age":20]
                    
                        COLLECTION_USERS.document(uid).setData(data) { error in
                        
                        completion(error)
                        
                    }
                    
                }
        }
        
    }
    
    static func loginUser(email:String,password:String,completion:@escaping ((AuthDataResult?,Error?)->Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
        
    }
    
    
}
