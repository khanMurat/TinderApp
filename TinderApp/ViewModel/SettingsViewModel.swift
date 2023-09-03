//
//  SettingsViewModel.swift
//  TinderApp
//
//  Created by Murat on 2.09.2023.
//

import Foundation

enum SettingsSection : Int,CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description : String {
        switch self {
        case .name:
            return "Name"
        case .profession:
            return "Profession"
        case .age:
            return "Age"
        case .bio:
            return "Bio"
        case .ageRange:
            return "Age Range"
        }
    }
    
//    var numberOfRowsInSection : Int {
//        switch self {
//        case .name:
//            return 1
//        case .profession:
//            return 2
//        case .age:           DENEME AMAÇLI !
//            return 3
//        case .bio:
//            return 1
//        case .ageRange:
//            return 1
//        }
//    }
    
}

struct SettingsViewModel {
    
    private let user : User
    let section : SettingsSection
    
    var value : String?
    
    let placeholderText : String
    
    var shouldHideInputField : Bool {
        return section == .ageRange
    }
    
    var shouldHideSlider : Bool {
        return section != .ageRange
    }
    
    var maxAgeLabel : Float {
        
        return Float(user.maxSeekingAge)
    }
    
    var minAgeLabel : Float {
        
        return Float(user.minSeekingAge)
    }

    
    init(user:User,section:SettingsSection){
        self.user = user
        self.section = section
        
        placeholderText = "Enter \(section.description.lowercased())"
        
        switch section {
            
        case .name:
            value = user.name
        case .profession:
            value = user.profession
        case .age:
            value = String(user.age)
        case .bio:
            value = user.bio
        case .ageRange:
            break
        }
        
    }
    
    func minAgePreferences(_ value : Float) -> String{
        
        return "Min : \(Int(value))"
    }
    
    func maxAgePreferences(_ value : Float) -> String{
        
        return "Max : \(Int(value))"
    }
}
