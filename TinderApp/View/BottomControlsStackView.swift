//
//  BottomControlsStackView.swift
//  TinderApp
//
//  Created by Murat on 9.08.2023.
//

import UIKit

class BottomControlsStackView : UIStackView {
    
    
    //MARK: - Properties
    
    let refreshButton = UIButton(type: .system)
    let dislike = UIButton(type: .system)
    let superlike = UIButton(type: .system)
    let like = UIButton(type: .system)
    let boost = UIButton(type: .system)
    
    
    
    //MARK: - Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        refreshButton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        dislike.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal
                                                                                                  ), for: .normal)
        superlike.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal
                                                                                                  ), for: .normal)
        like.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal
                                                                                                  ), for: .normal)
        boost.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal
                                                                                                  ), for: .normal)
        
        [refreshButton,dislike,superlike,like,boost].forEach { view in
            addArrangedSubview(view)
        }
        
        distribution = .fillEqually
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
