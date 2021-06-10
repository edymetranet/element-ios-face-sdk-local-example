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
        let eak = "ERERES/GGvVhNGQcmE6lEPQ3/awxvfqYtwanqlrGlVzc1M4sSNvgCMmjIHwNeBuYUe5du3ZsMlh8tHfT2bdr9lOtJHIH5jBMyOocp6Xk9gnvhunkeDzjW8A1ug+wOShE/2oNDkn/KUknkqerQiPzKdrf72/dRV16biUCqKDJuDTGRAsLvPwU1/JgZsuMTxn+3O7NsoGc5XgPGsyRbcEsw2qU5RewkeCAl5anwYCsq3gHOxX73ppcPVKzm3LAffeHm1LZF2ywdp/Ns8LwYpKmwMkUw/wItRgkZ4fdZRuw9zPD9K5gQCVmOSYPU0/aSC4MUygbkPZQSxP4aL++zDjhZCPE9msSVQCWoG4vXUYcrW/jAowt9JviWh9eckSxTKI9C5e6Fi8qtzKTfJ3qOyIP39gv8BiLHYy2h/4FYakv9C76VFZt2qCDUqqO5RNVwS1Yd6h5S2Cqi6giyChKXqVOYMKH9/A5INEGZ8i1Y0DvZfWKrNCz1bc2BTzOlqiRIXor91kF3r/EDV0FGkAeiexttHOrDYKq3tBLLXidvAwz13VQYQsh30RTDYKF8lWQGuZD8pXQib+//0S4xsN1/rQJOhlcC+9n3wGRlVRZdY6HwQoXfdBbq5ZisR55LJhumsjCtO43SaCiUcnnRY6YfZ+LCXokFEc1YmkVTofpDeV0/39iq1x0iYFkt/9z57vqaIkVug+StVOpUCz4mi7ZrDkvnVVrRA4yp4D41i+3kfE29DHsfU/2BtMYacDofnmk588d/zHhZTNJl08NneK+ySH6bvQFaS5Sgsj4QfBUHbnCLv8HJbxpp32lKUaQs2P2jm+y6TLJOx71H9TqahZ2TG494exFkc0Atk1l2mW9vqB2FmYDLPOuKLiSH28m61TMsWNGJQIbK1Sw8ZGqfTXF3WBltud1FjBYlaCOESaRwfFaUnZAjHi9adTnuj7RGtSW71ibFyDyy0BLCrziS8otcMfEWJLyhzT2UM627GrlndYoii8KXtJouvjWEiMxaUtyjmVeoPH3hSUy/EkSlNTf4g=="
        assert(eak == "ERERES/GGvVhNGQcmE6lEPQ3/awxvfqYtwanqlrGlVzc1M4sSNvgCMmjIHwNeBuYUe5du3ZsMlh8tHfT2bdr9lOtJHIH5jBMyOocp6Xk9gnvhunkeDzjW8A1ug+wOShE/2oNDkn/KUknkqerQiPzKdrf72/dRV16biUCqKDJuDTGRAsLvPwU1/JgZsuMTxn+3O7NsoGc5XgPGsyRbcEsw2qU5RewkeCAl5anwYCsq3gHOxX73ppcPVKzm3LAffeHm1LZF2ywdp/Ns8LwYpKmwMkUw/wItRgkZ4fdZRuw9zPD9K5gQCVmOSYPU0/aSC4MUygbkPZQSxP4aL++zDjhZCPE9msSVQCWoG4vXUYcrW/jAowt9JviWh9eckSxTKI9C5e6Fi8qtzKTfJ3qOyIP39gv8BiLHYy2h/4FYakv9C76VFZt2qCDUqqO5RNVwS1Yd6h5S2Cqi6giyChKXqVOYMKH9/A5INEGZ8i1Y0DvZfWKrNCz1bc2BTzOlqiRIXor91kF3r/EDV0FGkAeiexttHOrDYKq3tBLLXidvAwz13VQYQsh30RTDYKF8lWQGuZD8pXQib+//0S4xsN1/rQJOhlcC+9n3wGRlVRZdY6HwQoXfdBbq5ZisR55LJhumsjCtO43SaCiUcnnRY6YfZ+LCXokFEc1YmkVTofpDeV0/39iq1x0iYFkt/9z57vqaIkVug+StVOpUCz4mi7ZrDkvnVVrRA4yp4D41i+3kfE29DHsfU/2BtMYacDofnmk588d/zHhZTNJl08NneK+ySH6bvQFaS5Sgsj4QfBUHbnCLv8HJbxpp32lKUaQs2P2jm+y6TLJOx71H9TqahZ2TG494exFkc0Atk1l2mW9vqB2FmYDLPOuKLiSH28m61TMsWNGJQIbK1Sw8ZGqfTXF3WBltud1FjBYlaCOESaRwfFaUnZAjHi9adTnuj7RGtSW71ibFyDyy0BLCrziS8otcMfEWJLyhzT2UM627GrlndYoii8KXtJouvjWEiMxaUtyjmVeoPH3hSUy/EkSlNTf4g==")
        ElementSDKConfiguration.shared().initialize(withConfigurationData: eak)
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

