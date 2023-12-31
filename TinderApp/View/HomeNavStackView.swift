//
//  HomeNavStackView.swift
//  TinderApp
//
//  Created by Murat on 9.08.2023.
//

import UIKit
import FirebaseAuth

protocol HomeNavStackViewDelegate : AnyObject {
    
    func showSettings()
    func showMessages()
}

class HomeNavStackView : UIStackView {
    
    
    //MARK: - Properties
    weak var delegate : HomeNavStackViewDelegate?
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    //MARK: - Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tinderIcon.contentMode = .scaleAspectFit
        settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal
                                                                                                  ), for: .normal)
        
        [settingsButton,UIView(),tinderIcon,UIView(),messageButton].forEach { view in
            addArrangedSubview(view)
        }
        
        settingsButton.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleShowMessages), for: .touchUpInside)
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleShowSettings(){
        delegate?.showSettings()
    }
    
    @objc func handleShowMessages(){
        delegate?.showMessages()
    }
    
}
