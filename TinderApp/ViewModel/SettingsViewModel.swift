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
}
