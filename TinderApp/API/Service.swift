//
//  Service.swift
//  TinderApp
//
//  Created by Murat on 1.09.2023.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

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
    
    static func fetchAllUser(completion:@escaping ([User])->Void){
        
        var users = Array<User>()
     
        COLLECTION_USERS.getDocuments { snapshots, error in
            
            if error == nil {
                
                snapshots?.documents.forEach({ document in
                        
                    let dictionary = document.data()
                    let user = User(dictionary: dictionary)
                    
                    users.append(user)
                    
                    
                    if users.count == snapshots?.documents.count {
                        
                        completion(users)
                    }
                })
            }else{
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    static func saveUserData(user:User,completion:@escaping(Error?)->Void){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["uid":user.uid,
                    "fullname":user.name,
                    "imageURL":user.profileImageUrls,
                    "profession":user.profession,
                    "minSeekingAge":user.minSeekingAge,
                    "maxSeekingAge":user.maxSeekingAge,
                    "bio":user.bio,
                    "email":user.email,
                    "age":user.age] as [String : Any]
        
        COLLECTION_USERS.document(uid).setData(data, merge: true) { error in
            
            if error != nil {
                
                completion(error)
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
