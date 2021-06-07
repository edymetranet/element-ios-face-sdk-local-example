//
//  AppDelegateProtected.swift
//  demo
//
//  Created by Laurent Grandhomme on 9/13/16.
//  Copyright © 2016 Element. All rights reserved.
//

import UIKit

#if !(targetEnvironment(simulator))
import ElementSDK
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()

#if !(targetEnvironment(simulator))
        // TODO: replace YOUR_EAK with the EAK provided by Element
        ElementSDKConfiguration.shared().initialize(withConfigurationData: "ERERER3/l64cv3133Ffb1DVXm0+NcdJ52LBbLgk1arLKUU6+RpTBuhmbWOibgaRbJrvb7tHS/hNZ4aRGBdj/JTF20/QJagO9ztFdCtoqCWi5pGWgjt0nMuqnpDpczqyTDjzNNJIeCbi9Kx6FHaponDOdAjfXGfkTVTFOeHR0M9WCst3cDS+mBnFsaUF8vHrHfozBxfydLnkv91kJqmd5DS6WvPpp5K36u15FgE5pGdFNrPMrhM2DqOHw6Sfv4EhPmwdZZYqSUGZ1voMQYjQ8UfnlxLB8iFj8XEM7ChZ4p4zbIBFYyJQ/yJSG9EngKlml1KLFInq/T4HuTfgTWVpc4aHmD68/2A9LF0odkxvXLvI29paOX+qBpUm1o1CEQ68uWmrbkELbjsuSfmjFwtV0EV/ll7jBHa7da8L/0N0QSNEW8Iif7HPILp7/QLKOZid6nJ2EIV2ltrnbAySQF4P3+KBQ6tQpbZIALd1uT3KeRXh3tr7236lR04/wALUdHNF/yxuQI3lCVgjQXjyXFa4M83VMn7hT35AOgEZpcvnomIsvDDPLxXejAx/z0B6ypwHCkqngQ0rmLblAtcLwrOFAPMps7xGzqKIbt3kX6CD6r3wSutH7Ozc4Vf2Q5KHKAjpjkyWaVxHCEaES2ckhhc9olG7l/Qd+dcta6SYgMCnDo3AmDDRhA/i1jnqeRm0nB1cXc8DWFjaGAN7XTzQrHKg49/lnDhk63J6gZjrQqfPEAIox5hNwgA5NHlbEivk1S7sYYbPh2GFBS6JwntpL/6IfjjCvDrLF9VCC8tUmzoQ3wANZZe+D8AMrwawX+/XLf9OdnHJYRys5WfkcxwRjiXBfPn5XyxR7/HjFJpW3DMJwdkBNM1fkfh2hTy6jlO4Flrqe5+CisqkLqKE33iPyljyYAmZRvgrOK5wmy0Z8h6s1iAaWMlNTuzqbWo+B3vv47meYnDjiceHA4zPuWNeZqUBFzm+dHn5EkdmYjbKXBTgKJqXRJ87jOQqvFK993VwYFLItEX1jCqD58duKbmdgpBbEtyM=")
        // change the theme if needed
        ElementSDKConfiguration.shared().theme = .flowerPetals
#endif

        var vc : UIViewController? = nil
        vc = FaceAccountPickerViewController()
        
        let navigationController = UINavigationController(rootViewController: vc!)
        
        self.window?.rootViewController = navigationController   
        return true
    }
}

