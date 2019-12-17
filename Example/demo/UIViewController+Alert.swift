//
//  UIViewController+Alert.swift
//  demo
//
//  Created by Laurent Grandhomme on 9/28/16.
//  Copyright © 2016 Element. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMessage(title: String?, message: String?, block: @escaping ()->()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            block()
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    func setTransparentNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}
