//
//  SegmentedBarView.swift
//  TinderApp
//
//  Created by Murat on 4.09.2023.
//

import UIKit

class SegmentedBarView : UIStackView {
    
    
    init(numberOfSegments:Int){
        
        super.init(frame: .zero)
        
        (0..<(numberOfSegments)).forEach { _ in
            
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            addArrangedSubview(barView)
        }
        
        spacing = 4
        
        distribution = .fillEqually
        
        arrangedSubviews.first?.backgroundColor = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHighligted(index:Int){
        arrangedSubviews.forEach({$0.backgroundColor = .barDeselectedColor})
        arrangedSubviews[index].backgroundColor = .white
    }
}
