//
//  CardView.swift
//  TinderApp
//
//  Created by Murat on 9.08.2023.
//

import UIKit


enum SwipeDirection : Int {
    
    case left = -1
    case right = 1
}


class CardView : UIView {
    
    //MARK: - Properties
    
    private var viewModel : CardViewModel?

    private var imageView : UIImageView = {
        
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
        
    }()
    
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
        
    }()
    
    private lazy var infoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal
                                                                                    ), for: .normal)
        
        return button
    }()
    
    let gl = CAGradientLayer()
    
    
    //MARK: - Lifecycle
    
    
     init(viewModel:CardViewModel) {
         self.viewModel = viewModel
         super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        clipsToBounds = true
        
         configure()
         
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingLeft: 16,paddingBottom: 16,paddingRight: 16)
        
        gl.colors = [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(0.4).cgColor]
        gl.locations = [0.75,1.1]
        layer.addSublayer(gl)
        
      
        addSubview(infoButton)
        infoButton.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal
                                                                                    ), for: .normal)
        infoButton.centerY(inView: infoLabel)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.anchor(right: rightAnchor,paddingRight: 16)
        
        
        configureGestureRecognizer()

   
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
            gl.frame = self.frame
           
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handlePanGesture(sender:UIPanGestureRecognizer){
        

        switch sender.state {
        case .began:
            superview?.subviews.forEach({
                $0.layer.removeAllAnimations()
            })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
        
    }
    
    @objc func handleChangePhoto(sender:UITapGestureRecognizer){
        
        guard let viewModel = viewModel else {return}
        
        let location = sender.location(in: nil).x
        
        let shouldShowNextPhoto = location > self.frame.width / 2
        
        if shouldShowNextPhoto {
            viewModel.getNextPhoto()
           
        }else{
            viewModel.getPreviousPhoto()
        }
        
        imageView.image = viewModel.userImage
    }
    
    //MARK: - Helpers
    
    
    func configure(){
        
        guard let viewModel = viewModel else {return}
        
        imageView.image = viewModel.user.images.first
        infoLabel.attributedText = viewModel.userInfoText
        
    }
    
    func configureGestureRecognizer(){
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        
        addGestureRecognizer(pan)
        addGestureRecognizer(tap)
    }
    
    
    func panCard(sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: nil)
        let degrees : CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender:UIPanGestureRecognizer){
        
        let direction : SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        
        let shouldDissmissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1,options: .curveEaseInOut) {
            
            if shouldDissmissCard {
                self.removeFromSuperview()
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }else{
                self.transform = .identity
            }
            
            if shouldDissmissCard{
                self.removeFromSuperview()
            }
        }
    }
    
    
    
    
    
}
