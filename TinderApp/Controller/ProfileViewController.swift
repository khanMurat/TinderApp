//
//  ProfileViewController.swift
//  TinderApp
//
//  Created by Murat on 4.09.2023.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

class ProfileViewController : UIViewController{
    
    //MARK: - Properties
    
    private let user : User
    
    private lazy var viewModel = ProfileViewModel(user: user)
    
    private lazy var barStackView = SegmentedBarView(numberOfSegments: viewModel.imageCount)
    
    private lazy var collectionView : UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + 100)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = true
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
        
    }()
    
    private let blurView : UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let dismissButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDissmissal), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel : UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let professionLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()
    
    private let bioLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()
    
    private lazy var dislikeButton : UIButton = {
        let button = createButton(with: #imageLiteral(resourceName: "dismiss_circle"))
        button.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        return button
    }()
    
    private lazy var superlikeButton : UIButton = {
        let button = createButton(with: #imageLiteral(resourceName: "super_like_circle"))
        button.addTarget(self, action: #selector(handleSuperLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton : UIButton = {
        let button = createButton(with: #imageLiteral(resourceName: "like_circle"))
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()

     //MARK: - Lifecycle
    
    init(user:User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleDissmissal(){
        self.dismiss(animated: true)
    }
    
    @objc func handleDislike(){
        
    }
    
    @objc func handleSuperLike(){
        
    }
    
    @objc func handleLike(){
        
    }
    
    //MARK: - Helpers
    
    func configureBarStackView(){
        view.addSubview(barStackView)
        barStackView.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 64,paddingLeft: 8,paddingRight: 8,height: 4)
    }
    
    func loadUserData(){
        infoLabel.attributedText = viewModel.userDetailsAttributedString
        professionLabel.text = viewModel.profession
        bioLabel.text = viewModel.bio
    }
    
    func configureUI(){
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        view.addSubview(dismissButton)
        dismissButton.setDimensions(height: 40, width: 40)
        dismissButton.anchor(top: collectionView.bottomAnchor,right: view.rightAnchor,paddingTop: -20,paddingRight: 16)
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel,professionLabel,bioLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        
        view.addSubview(infoStack)
        infoStack.anchor(top: collectionView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 12,paddingLeft: 12,paddingRight: 12)
        
        view.addSubview(blurView)
        blurView.anchor(top: view.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.topAnchor,right: view.rightAnchor)
        
        configureBottomControls()
        
        loadUserData()
        
        configureBarStackView()
    }
    
    func configureBottomControls(){
        
        let stack = UIStackView(arrangedSubviews: [dislikeButton,superlikeButton,likeButton])
        
        view.addSubview(stack)
        stack.distribution = .fillEqually
        stack.spacing = -32
        stack.setDimensions(height: 80, width: 300)
        stack.centerX(inView: view)
        stack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 32)
    }
    
    func createButton(with image : UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
}

//MARK: - UICollectionViewDelegate

extension ProfileViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        barStackView.setHighligted(index: indexPath.row)
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        cell.imageView.sd_setImage(with:viewModel.imageURL(withIndex: indexPath.row))
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
