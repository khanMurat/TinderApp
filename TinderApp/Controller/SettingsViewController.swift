//
//  SettingsViewController.swift
//  TinderApp
//
//  Created by Murat on 2.09.2023.
//

import UIKit
import JGProgressHUD

protocol SettingsViewControllerDelegate : AnyObject {
    
    func saveUserInfoLocally(viewController : SettingsViewController,user:User)
    func settingsControllerWantsToLogOut(_ controller : SettingsViewController)
}

private let identifer = "SettingsCell"

class SettingsViewController : UITableViewController {
    
    
    //MARK: - Properties
    
    weak var delegate : SettingsViewControllerDelegate?
    
    private var user : User
    
    lazy var headerView = SettingsHeader(user: user)
    
    let footerView = SettingsFooter()
    
    let picker = UIImagePickerController()
    
    var selectedButton : UIButton?
    
    //MARK: - Lifecycle
    
    init(user:User){
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Actions
    
    @objc func handleCancel(){
        
        self.dismiss(animated: true)
    }
    
    @objc func handleDone(){
        view.endEditing(true)
        print(user)
        delegate?.saveUserInfoLocally(viewController: self, user: user)
        
    }
    
    //MARK: - API

    func uploadImage(image:UIImage){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Saving Image"
        hud.show(in: view)
        
        Service.uploadImage(image: image) { imageURL in
            
            self.user.profileImageUrls.append(imageURL)
            
            hud.dismiss(animated: true)
        }
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        view.backgroundColor = .white
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: identifer)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = .systemGroupedBackground
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)

        headerView.delegate = self
        
        tableView.tableFooterView = footerView
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 88)
        footerView.delegate = self
    }
    
}

//MARK: - UITableViewDataSource

extension SettingsViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return SettingsSection.allCases[section].numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer) as! SettingsCell
        cell.delegate = self
        guard let section = SettingsSection(rawValue: indexPath.section) else {return cell}
        cell.viewModel = SettingsViewModel(user: user, section: section)
        cell.contentView.isUserInteractionEnabled = false // bu kod olmadan cell elemanları ile etkilesime girilemiyor !
        return cell
        
    }
    
}

//MARK: - UITableViewDelegate,

extension SettingsViewController{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSection(rawValue: section) else {return nil}
        
        return section.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SettingsSection(rawValue: indexPath.section) else {return 0}
        
        return section == .ageRange ? 96 : 44
    }
}

extension SettingsViewController : SettingsCellDelegate {
    
    func setSliderValue(_ cell: SettingsCell, max maxValue: Float, min minValue: Float) {
        
        self.user.maxSeekingAge = Int(maxValue)
        self.user.minSeekingAge = Int(minValue)
        print(user)
    }
    
    func updateUserInfo(_ cell: SettingsCell,
                        wantsToUpdateUserWith value: String,
                        for section: SettingsSection) {
        
        switch section {
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .age:
            user.age = Int(value) ?? 0
        case .bio:
            user.bio = value
        case .ageRange:
            break
        }
    }
    
}

extension SettingsViewController : SettingsHeaderDelegate {
    
    func selectUserPhotos(for button: UIButton) {
        picker.sourceType = .photoLibrary
        picker.delegate = self
        selectedButton = button
        present(picker, animated: true)
        
    }
}

extension SettingsViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        uploadImage(image: image)
        selectedButton?.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        selectedButton?.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.dismiss(animated: true)
    }
}

extension SettingsViewController : SettingsFooterDelegate {
    func handleLogOut() {
        delegate?.settingsControllerWantsToLogOut(self)
    }
    
}

