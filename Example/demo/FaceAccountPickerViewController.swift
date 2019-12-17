//
//  FaceAccountPickerViewController.swift
//  demo
//
//  Created by Laurent Grandhomme on 11/9/17.
//  Copyright © 2017 Element. All rights reserved.
//

import UIKit
import ElementSDK

/*
 * Main view controller for Face, it showcases the 2 main features:
 * 1/ account creation using FaceUserInitViewController
 *    a/ multi user account creation with "Multi User Enrollment"
 *    b/ doing user enrollment on one account with "Add User"
 * 2/ account authentication using FaceAuthenticationViewController
 *
 * Once created, the accounts will appear in the list, you can then click on one account to authenticate.
 *
 * The "User Sign In" button at the bottom can be used to get an account created on the dashboard,
 * if this feature is enabled for your company.
 * This also enables you to create an account on a device and use it on another device (the biometrics
 * models are synced).
 *
 * Another API this view controller uses is ELTAccount.allAccounts() : this returns the accounts
 * stored on the device.
 */
class FaceAccountPickerViewController: UIViewController {
lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.width(),
                                                            height: UIScreen.height() - 80))
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    var ds : TableViewDataSource?
    
    var accounts : [ELTAccount]
    
    var emptyStateView : UILabel?
    
    var signInButton : UIButton?
    
    var identifyButton : UIButton?
    var identifyLoadingView : UIView?
    
    init() {
        self.accounts = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.title = "Face " + version
        }
        
        self.tableView.registerClass(FaceAccountTableViewCell.self)
        self.tableView.backgroundColor = .clear
        self.view.addSubview(self.tableView)
        
        self.signInButton = UIButton()
        self.signInButton?.frame = CGRect(x: (UIScreen.width() / 2) + 10, y: self.tableView.bottom() + 20, width: (UIScreen.width() / 2) - 20, height: 40)
        self.signInButton?.setTitle("User Sign In", for: .normal)
        self.signInButton?.setTitleColor(.blue, for: .normal)
        self.signInButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.signInButton?.addTarget(self, action: #selector(FaceAccountPickerViewController.userSignInTapped), for: .touchUpInside)
        self.signInButton?.layer.borderColor = UIColor.blue.cgColor
        self.signInButton?.layer.borderWidth = 1
        self.signInButton?.layer.cornerRadius = 20
        self.view.addSubview(self.signInButton!)
        
        let leftButton = UIBarButtonItem(title: "Add User", style: .plain, target: self, action: #selector(FaceAccountPickerViewController.addAccount))
        self.navigationItem.leftBarButtonItem = leftButton
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.emptyStateView = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.width() - 20, height: 80))
        self.emptyStateView?.text = "No account, tap \'Add User\""
        self.emptyStateView?.numberOfLines = 0
        self.emptyStateView?.font = UIFont.systemFont(ofSize: 24)
        self.emptyStateView?.isHidden = true
        self.emptyStateView?.backgroundColor = .white
        self.emptyStateView?.textAlignment = .center
        self.emptyStateView?.isHidden = true
        self.view.addSubview(self.emptyStateView!)
        self.emptyStateView?.centerVertically()
    }
    
    @objc func userSignInTapped() {
        print("user sign in tapped")
        let signInViewController = UserSignInViewController()
        let signInNavigationController = UINavigationController(rootViewController: signInViewController)
        self.navigationController?.present(signInNavigationController, animated: true) {
        
        }
    }
    
    func reloadData() {
        // get a list of accounts stored on the device
        self.accounts = ELTAccount.allAccounts()
        if self.accounts.count == 0 {
            self.emptyStateView?.isHidden = false
        } else {
            self.emptyStateView?.isHidden = true
        }
        var sectionModel = TableViewSectionModel()
        
        for account in self.accounts {
            sectionModel.cellModels.append(TableViewCellModel<FaceAccountTableViewCell>(model: account, canBeSelected: true, onSelect: {
                self.handleTap(account)
            }, onDisplay: nil, onSwipeToDelete: {
                print("ask confirmation to delete", account)
                self.confirmDelete(account: account)
            }))
            
        }
        self.ds = TableViewDataSource(section: sectionModel)
        self.tableView.delegate = ds
        self.tableView.dataSource = ds
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
    }
    
    func confirmDelete(account: ELTAccount) {
        let alert = UIAlertController(title: "Delete Account?", message: "Are you sure you want to remove \(account.firstName) from the device?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
            (alert: UIAlertAction!) in
            print("we can delete the account")
            account.deleteFromDevice()
            self.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) in
            self.reloadData()
        })
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func addAccount() {
        let alertController: UIAlertController = UIAlertController(title: "Enter user's name", message: nil, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        alertController.addAction(cancelAction)

        let createAction: UIAlertAction = UIAlertAction(title: "Create", style: .default) { action -> Void in
            let text = (alertController.textFields?.first)?.text
            if let text = text {
                let account = ELTAccount.createNewAccount(withFirstName: text, lastName: "", email: nil, clearTextPin: nil, extraInfo: nil, userId: NSUUID().uuidString)
                self.handleTap(account)
            }
        }
        alertController.addAction(createAction)

        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "User name"
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func handleTap(_ account: ELTAccount) {
        // FACE
        switch account.faceAccountState {
            case .availableButNotDownloaded:
                print("download the face model")
                LoadingController.showLoading(NSLocalizedString("Downloading the model", comment: ""))
                DispatchQueue.global(qos: .userInitiated).async {
                    // download model is a sync method
                    let res = account.downloadFaceModel()
                    LoadingController.hideLoading()
                    // Bounce back to the main thread to update the UI
                    if res == .modelDownloaded {
                        // to go back to the rigt switch
                        self.handleTap(account)
                    } else {
                        self.showMessage(title: "User account not available.", message: nil, block: {

                        })
                    }
                }
                break
            case .userInitNeeded, .unknown:
                // user init for this account hasn't been completed, go back to finish it
                print("going to complete user init for", account.firstName, account.lastName)
                let userInitViewController = LocalFaceEnrollmentViewController(account: account, completionHandler:{
                    vc in
                    print("account is created!")
                    _ = vc.navigationController?.popViewController(animated: true)
                }, onCancel: {
                    vc in
                    print("user cancelled")
                    _ = vc.navigationController?.popViewController(animated: true)
                })
                self.navigationController?.pushViewController(userInitViewController!, animated: true)
                
                // ObjectiveC
//                self.pushFaceUserInitViewController(for: account)
                break
            case .ready:
                print("going to do auth for", account.firstName, account.lastName)
                // authenticate the user
                let vc = LocalFaceAuthenticationViewController(account: account, onAuthentication: {
                    viewController, confidenceScore in
                    print("success authenticating ", account.userId)
                    _ = viewController.navigationController?.popViewController(animated: true)
                }, onCancel: {
                    viewController in
                    print(account.userId, " cancelled authentication")
                    _ = viewController.navigationController?.popViewController(animated: true)
                })
                self.navigationController?.pushViewController(vc!, animated: true)
                
                // ObjectiveC
//                self.pushUserAuthenticationViewController(for: account)
                
                break
            default:
                assert(false, "not yet supported")
                break
        }
    }
}
