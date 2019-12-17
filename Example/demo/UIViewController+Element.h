//
//  UIViewController+Element.h
//  facedemo
//
//  Created by Laurent Grandhomme on 11/19/18.
//  Copyright © 2018 Element. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ElementSDK/ElementSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Element)

+ (ELTAccount *)createAccountWithFirstName:(NSString *)fn lastName:(NSString *)ln;

- (void)pushFaceUserInitViewControllerForAccount:(ELTAccount *)account;

- (void)pushUserAuthenticationViewControllerForAccount:(ELTAccount *)account;

@end

NS_ASSUME_NONNULL_END
