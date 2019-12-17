//
//  AppDelegateProtected.swift
//  demo
//
//  Created by Laurent Grandhomme on 9/13/16.
//  Copyright © 2016 Element. All rights reserved.
//

import UIKit

import ElementSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()

        ElementSDKConfiguration.shared().initialize(withConfigurationData: "YOUR_ENCRYPTED_ACCESS_KEY")
        // upload images to S3 (default is false)
        ElementSDKConfiguration.shared().uploadImages = true
        // geo locate user during authentication (default is false)
        ElementSDKConfiguration.shared().geolocateUser = true
        // change the theme if needed
        ElementSDKConfiguration.shared().theme = .flowerPetals
        
        var vc : UIViewController? = nil
        vc = FaceAccountPickerViewController()
        
        let navigationController = UINavigationController(rootViewController: vc!)
        
        self.window?.rootViewController = navigationController   
        return true
    }
}

