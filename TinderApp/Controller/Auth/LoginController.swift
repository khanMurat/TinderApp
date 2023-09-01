//
//  RegisterController.swift
//  TinderApp
//
//  Created by Murat on 25.08.2023.
//

import UIKit


class LoginController : UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImageView : UIImageView = {
       
        var img = UIImageView()
        img.image = #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let emailTextField : CustomTextField = {
       
       let tf = CustomTextField(inputText: "Email")
        tf.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        return tf
        
    }()
    
    private let passwordTextField : CustomTextField = {
       
       let tf = CustomTextField(inputText: "Password")
        tf.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        let lockImg = UIImage(systemName: "lock.open")
        let button = UIButton(type: .custom)
        button.setImage(lockImg, for: .normal)
        button.tintColor = .white
        button.setDimensions(height: 40, width: 40)
        button.addTarget(self, action: #selector(handleLockStatus), for: .touchUpInside)
        tf.rightView = button
        
        return tf
        
    }()
    
    private lazy var loginButton : AuthButton = {
       
        let button = AuthButton(title: "Log In",type: .system)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLoginUser), for: .touchUpInside)
        return button
    }()
    
    private lazy var goRegisterButton : UIButton = {
       
        let button = UIButton(type: .system)
        button.addAttributes(firstPart: "Don't have an account?  ", secondPart: "Sign Up") //Custom Attributes
        button.addTarget(self, action: #selector(handleGoRegister), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - Actions
    
    @objc func handleLoginUser(){
        
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        showLoader(true)
        AuthService.loginUser(email: email, password: password) { result,error  in
            if error != nil {
                self.showMessage(withTitle: "Error", message: "\(error!.localizedDescription)")
                self.showLoader(false)
                return
            }
                self.showLoader(false)
                self.dismiss(animated: true)
        }
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        
    formValidation(textField: textField)
        
    }
    
    
    @objc func handleLockStatus(sender:UIButton){
        
        passwordTextField.isSecureTextEntry.toggle()
        sender.setImage(UIImage(systemName: passwordTextField.isSecureTextEntry ? "lock" : "lock.open"), for: .normal)
    }
    
    @objc func handleEndEditing(){
        view.endEditing(true)
    }
    
    @objc func handleGoRegister(){
        
        let controller = RegisterController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: - Helpers
    
    func configureUI(){
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleEndEditing))
        view.addGestureRecognizer(gestureRecognizer)
        
        configureGradientLayer(color1: UIColor.systemPink.cgColor, color2: UIColor.systemIndigo.cgColor)
        
        view.addSubview(iconImageView)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 36)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 100, width: 80)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.setHeight(200)
        
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 16,paddingLeft: 16,paddingRight: 16)
        
        view.addSubview(goRegisterButton)
        goRegisterButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 32,paddingBottom: 16,paddingRight: 32)
        

    }
    
    func formValidation(textField:UITextField){
        
        if textField == emailTextField{
            
            viewModel.email = emailTextField.text
        }
        if textField == passwordTextField{
            viewModel.password = passwordTextField.text
        }
        
        loginButton.isEnabled = viewModel.isEnabled
        
        loginButton.backgroundColor = viewModel.backGroundColor
    }

}
