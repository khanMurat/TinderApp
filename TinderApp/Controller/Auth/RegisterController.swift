//
//  RegisterController.swift
//  TinderApp
//
//  Created by Murat on 28.08.2023.
//

import UIKit


class RegisterController : UIViewController {
    
    
    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    
    var viewModel = RegisterViewModel()
    
    private lazy var imagePickerButton : UIButton = {
       
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSetProfileImage), for: .touchUpInside)
        return button
        
    }()
    
    private let emailTextField : CustomTextField = {
       
       let tf = CustomTextField(inputText: "Email")
        tf.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        return tf
        
    }()
    
    private let fullnameTextField : CustomTextField = {
       
       let tf = CustomTextField(inputText: "Full Name")
        tf.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        return tf
        
    }()
    
    private let passwordTextField : CustomTextField = {
       
       let tf = CustomTextField(inputText: "Password")
        let lockImg = UIImage(systemName: "lock")
        let button = UIButton(type: .custom)
        tf.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        button.setImage(lockImg, for: .normal)
        button.tintColor = .white
        button.setDimensions(height: 40, width: 40)
        button.addTarget(self, action: #selector(handleLockStatus), for: .touchUpInside)
        tf.rightView = button
        
        return tf
        
    }()
    
    private lazy var registerButton : AuthButton = {
       
        let button = AuthButton(title: "Register",type: .system)
        return button
    }()
    
    private lazy var goLoginButton : UIButton = {
       
        let button = UIButton(type: .system)
        button.addAttributes(firstPart: "Do you have an account?  ", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleGoLogin), for: .touchUpInside)
        return button
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func textFieldDidChange(_ textField:UITextField){
        formValidation(textField: textField)
    }
    
    @objc func handleSetProfileImage(){
        
        self.present(imagePicker, animated: true)
        
    }
    
    @objc func handleGoLogin(){
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleLockStatus(sender:UIButton){
        
        passwordTextField.isSecureTextEntry.toggle()
        sender.setImage(passwordTextField.isSecureTextEntry ? UIImage(systemName: "lock") : UIImage(systemName: "lock.fill"), for: .normal)
        
    }
    
    
    //MARK: - Helpers
    
    func configureUI(){
        
        navigationController?.navigationBar.isHidden = true
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        configureGradientLayer(color1: UIColor.systemPink.cgColor, color2: UIColor.systemIndigo.cgColor)
        
        view.addSubview(imagePickerButton)
        imagePickerButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 36)
        imagePickerButton.centerX(inView: view)
        imagePickerButton.setDimensions(height: 275, width: 275)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,fullnameTextField,passwordTextField,registerButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.setHeight(250)
        
        view.addSubview(stack)
        stack.anchor(top: imagePickerButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 16,paddingLeft: 16,paddingRight: 16)
        
        
        view.addSubview(goLoginButton)
        goLoginButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 32,paddingBottom: 16,paddingRight: 32)
    }
    
    func formValidation(textField:UITextField){
        
        if textField == emailTextField{
            viewModel.email = emailTextField.text
        }
        if textField == passwordTextField{
            viewModel.password = passwordTextField.text
        }
        if textField == fullnameTextField{
            viewModel.fullname = fullnameTextField.text
        }
        
        registerButton.isEnabled = viewModel.isEnabled
        
        registerButton.backgroundColor = viewModel.backGroundColor
    }
    
}



extension RegisterController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
         let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePickerButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        imagePickerButton.layer.borderColor = UIColor.white.cgColor
        imagePickerButton.layer.cornerRadius = 10
        imagePickerButton.layer.borderWidth = 1
        imagePickerButton.imageView?.contentMode = .scaleAspectFill
        imagePickerButton.clipsToBounds = true
        self.dismiss(animated: true)
    }
    
    
}

