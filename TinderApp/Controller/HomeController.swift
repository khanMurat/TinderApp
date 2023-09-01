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
    
    private let topStack = HomeNavStackView()
    private let bottomStack = BottomControlsStackView()
    
    private let deckView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserLoggedIn()
        configureUI()
        //configureCards()
        
        Service.fetchUser(withUid: Auth.auth().currentUser!.uid) { user in
            print(user.age)
            print(user.name)
        }
        
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
    
    //MARK: - Helpers

//    func configureCards(){
//
//        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "jane3") , #imageLiteral(resourceName: "lady4c")])
//        let user2 = User(name: "Megan", age: 21, images: [#imageLiteral(resourceName: "kelly2") , #imageLiteral(resourceName: "kelly1")])
//
//        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
//        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
//
//        deckView.addSubview(cardView1)
//        cardView1.fillSuperview()
//        deckView.addSubview(cardView2)
//        cardView2.fillSuperview()
//    }
    
    func configureUI(){
        
        view.backgroundColor = .white
        
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
