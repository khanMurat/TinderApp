//
//  ProfileCell.swift
//  TinderApp
//
//  Created by Murat on 4.09.2023.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "jane3")
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
