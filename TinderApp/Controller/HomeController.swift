//
//  HomeController.swift
//  TinderApp
//
//  Created by Murat on 9.08.2023.
//

import UIKit
import FirebaseAuth

class HomeController : UIViewController {
    
    
    //MARK: - Properties
    private var user : User?
    private let topStack = HomeNavStackView()
    private let bottomStack = BottomControlsStackView()
    
    private let deckView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    private var users = [User]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserLoggedIn()
        configureUI()
        fetchUsers()
        fetchUser()
    }
    
    //MARK: - API
    
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Service.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
    
    func fetchUsers(){
        Service.fetchAllUser { users in
            DispatchQueue.main.async {
                self.users = users
                self.configureCards()
            }
        }
    }
    
    //MARK: - Helpers

    func configureCards(){
        
        var cardView : CardView?
        
        if !users.isEmpty{
            users.forEach { user in
                
                cardView = CardView(viewModel: CardViewModel(user: user))
                
                guard cardView != nil else {return }
                
                cardView?.delegate = self
                
                deckView.addSubview(cardView!)
                
                cardView!.fillSuperview()
            }
        }
    }
    
    func configureUI(){
        
        view.backgroundColor = .white
        
        topStack.delegate = self
        
        let stack = UIStackView(arrangedSubviews: [topStack,deckView,bottomStack])
        stack.axis = .vertical
        stack.spacing = 17.5

        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
  
    }
}

//MARK: - HomeNavStackViewDelegate

extension HomeController : HomeNavStackViewDelegate {
  
    func showSettings() {
        
        guard let user = self.user else {return}
        let controller = SettingsViewController(user: user)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func showMessages() {
        print("Show message pressed")
    }
}

//MARK: - SettingsViewControllerDelegate

extension HomeController : SettingsViewControllerDelegate{
    func settingsControllerWantsToLogOut(_ controller: SettingsViewController) {
        controller.dismiss(animated: true)
        AuthService.logOut()
        checkIfUserLoggedIn()
    }
    
    func saveUserInfoLocally(viewController: SettingsViewController, user: User) {
        
        self.user = user
        Service.saveUserData(user: user) { error in
            if error != nil {
                self.showMessages()
            }
        }
        self.dismiss(animated: true)
    }
}

//MARK: - CardViewDelegate

extension HomeController : CardViewDelegate {
    func cardView(_ view: CardView, wantsToShowProfile user: User) {
        
        let controller = ProfileViewController(user: user)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
        
    }
}
