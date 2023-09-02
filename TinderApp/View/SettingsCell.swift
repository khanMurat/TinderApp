//
//  SettingsCell.swift
//  TinderApp
//
//  Created by Murat on 2.09.2023.
//

import UIKit

protocol SettingsCellDelegate:AnyObject {
    func updateUserInfo(_ cell : SettingsCell,wantsToUpdateUserWith value:String,forSection:SettingsSection)
    func setSliderValue(_ cell : SettingsCell)
}

class SettingsCell : UITableViewCell {
    
    //MARK: - Properties
    
    var viewModel : SettingsViewModel! {
        didSet{
            configure()
        }
    }
    
    weak var delegate : SettingsCellDelegate?
    
    lazy var inputField : UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.font = .systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        return tf
    }()
    var sliderStack = UIStackView()
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        addSubview(inputField)
        inputField.fillSuperview()
        inputField.isUserInteractionEnabled = true
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel,minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel,maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack,maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 16
        
        minAgeSlider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor,right: rightAnchor,paddingLeft: 24,paddingRight: 24)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleAgeRangeChanged(){
        delegate?.setSliderValue(self)
    }
    
    @objc func handleUpdateUserInfo(sender:UITextField){
        
        guard let value = sender.text else {return}
        delegate?.updateUserInfo(self, wantsToUpdateUserWith: value, forSection: viewModel.section)

    }
    
    
    //MARK: - Helpers
    
    func configure(){
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
    }
    
    func createAgeRangeSlider()->UISlider{
    
    let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        return slider
}
    
}
