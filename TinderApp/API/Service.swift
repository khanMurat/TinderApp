//
//  Service.swift
//  TinderApp
//
//  Created by Murat on 1.09.2023.
//

import Foundation
import FirebaseStorage

struct Service {
    
    static func fetchUser(withUid uid : String,completion:@escaping (User)->Void){
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            if error == nil {
                
                if let snapshot = snapshot {
                    
                    let user = User(dictionary: snapshot.data() ?? [:])
                    
                    completion(user)
                }
            }
        }
        
    }
    
    static func uploadImage(image:UIImage,completion: @escaping(String)->Void){
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        let fileName = NSUUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        
        ref.putData(imageData) { metadata, error in
            
            if let error = error {
                print("Error uploading image : \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
