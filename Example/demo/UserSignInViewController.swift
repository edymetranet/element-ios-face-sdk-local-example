//
//  UserSignInViewController.swift
//  demo
//
//  Created by Laurent Grandhomme on 10/23/17.
//  Copyright © 2017 Element. All rights reserved.
//

import UIKit

import ElementSDK

/*
 * Example showing how to use ElementSDKTransaction's userSignInWithEmail:pin:successBlock:errorBlock endpoint.
 * If successful, the ELTAccount that's returned is ready to use (the face and / or palm models will
 * be downloaded if available).
 */
class UserSignInViewController: UIViewController, UITextFieldDelegate {

    static func makeGenericTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 20, height: 50)
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }

    lazy var emailTextField : UITextField = {
        let tf = UserSignInViewController.makeGenericTextField("email")
        var frame = tf.frame
        frame.origin.y = 80
        tf.frame = frame
        tf.keyboardType = .emailAddress
        return tf
    }()
    lazy var pinTextField : UITextField = {
        let tf = UserSignInViewController.makeGenericTextField("pin")
        var frame = tf.frame
        frame.origin.y = 140
        tf.frame = frame
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "User Sign In"
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.emailTextField)
        self.emailTextField.autocapitalizationType = .none
        self.emailTextField.autocorrectionType = .no
        self.view.addSubview(self.pinTextField)
        self.pinTextField.keyboardType = .numberPad
        self.pinTextField.isSecureTextEntry = true
        self.pinTextField.delegate = self
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: self.pinTextField.frame.origin.y + 70, width: self.pinTextField.frame.size.width, height: 50)
        button.setTitle("Sign in", for: UIControl.State())
        button.setTitleColor(UIColor.blue, for: UIControl.State())
        button.addTarget(self, action: #selector(UserSignInViewController.signIn), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        self.view.addSubview(button)
        
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(UserSignInViewController.cancel))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func cancel() {
        print("cancel sign in")
        self.dismiss(animated: true) { 
            
        }
    }
    
    @objc func signIn() {
        print("signin with", self.emailTextField.text!, self.pinTextField.text!)
        self.emailTextField.resignFirstResponder()
        self.pinTextField.resignFirstResponder()
        
        LoadingController.showLoading("Loading...")
        if let email = self.emailTextField.text, let pin = self.pinTextField.text {
            ElementSDKTransaction.userSignIn(withEmail: email.trimmingCharacters(in: CharacterSet.whitespaces), pin: pin.trimmingCharacters(in: CharacterSet.whitespaces), successBlock: { account in
                print("got an account: ", account)
                LoadingController.hideLoading()
                self.dismiss(animated: true, completion: nil)
            }, errorBlock: {
                errorCode, error, message in
                LoadingController.hideLoading()
                if let errorString = (error as NSError).userInfo["message"] as? String {
                    self.showMessage(title: nil, message: errorString, block: {
                    
                    })
                } else {
                    self.showMessage(title: nil, message: error.localizedDescription, block: {
                    
                    })
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            return txtAfterUpdate.characters.count <= 4
        } else {
            print("cant get the text")
        }
        return true
    }
}
