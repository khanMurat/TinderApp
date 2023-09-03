//
//  SettingsCell.swift
//  TinderApp
//
//  Created by Murat on 2.09.2023.
//

import UIKit

protocol SettingsCellDelegate:AnyObject {
    func updateUserInfo(_ cell : SettingsCell,wantsToUpdateUserWith value:String,for section:SettingsSection)
    func setSliderValue(_ cell : SettingsCell,max maxValue : Float,min minValue : Float)
}

class SettingsCell : UITableViewCell {
    
    //MARK: - Properties
    
    var viewModel : SettingsViewModel! {
        didSet{
            configure()
        }
    }
    
    private var minValue : Float = 18
    private var maxValue : Float = 60
    
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
    var minAgeLabel = UILabel()
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
    
        
        addSubview(sliderStack)
        sliderStack.centerY(inView: self)
        sliderStack.anchor(left: leftAnchor,right: rightAnchor,paddingLeft: 24,paddingRight: 24)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleAgeRangeChanged(sender:UISlider){
       
        if sender == minAgeSlider {
            minValue = sender.value
            minAgeLabel.text = viewModel.minAgePreferences(sender.value)
            
        }else{
            maxValue = sender.value
            maxAgeLabel.text = viewModel.maxAgePreferences(sender.value)
        }
        
        delegate?.setSliderValue(self, max: maxValue, min: minValue)
    }
    
    @objc func handleUpdateUserInfo(sender:UITextField){
        
        guard let value = sender.text else {return}
        delegate?.updateUserInfo(self, wantsToUpdateUserWith: value, for: viewModel.section)

    }
    
    
    //MARK: - Helpers
    
    func configure(){
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
        
        minAgeLabel.text = viewModel.minAgePreferences(viewModel.minAgeLabel)
        maxAgeLabel.text = viewModel.maxAgePreferences(viewModel.maxAgeLabel)
        
        minAgeSlider.setValue(viewModel.minAgeLabel, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeLabel, animated: true)
    }
    
    func createAgeRangeSlider()->UISlider{
    
    let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        slider.addTarget(self, action: #selector(handleAgeRangeChanged), for: .valueChanged)
        return slider
}
    
}
