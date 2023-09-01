//
//  CustomTextField.swift
//  TinderApp
//
//  Created by Murat on 25.08.2023.
//

import UIKit


class CustomTextField : UITextField {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    init(inputText:String) {
        super.init(frame: .zero)

        backgroundColor = .white.withAlphaComponent(0.2)
        attributedPlaceholder = NSMutableAttributedString(string: inputText, attributes: [.foregroundColor : UIColor.white.withAlphaComponent(0.6)])
        layer.cornerRadius = 5
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
        rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


