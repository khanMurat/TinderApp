//
//  SettingsFooter.swift
//  TinderApp
//
//  Created by Murat on 3.09.2023.
//

import UIKit

protocol SettingsFooterDelegate : AnyObject{
    
    func handleLogOut()
    
}

class SettingsFooter : UIView {
    
    
    //MARK: - Properties
    
    weak var delegate : SettingsFooterDelegate?
    
    //MARK: - Lifecycle
    
    
    private lazy var logoutButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spacer = UIView()
        spacer.backgroundColor = .systemGroupedBackground
        
        addSubview(spacer)
        spacer.setDimensions(height: 32, width: frame.width)
        
        addSubview(logoutButton)
        logoutButton.anchor(top: spacer.bottomAnchor,left: leftAnchor,right: rightAnchor,height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleLogOut(){
        delegate?.handleLogOut()
    }
    
}
