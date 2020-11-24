//
//  UIViewController+Element.m
//  facedemo
//
//  Created by Laurent Grandhomme on 11/19/18.
//  Copyright © 2018 Element. All rights reserved.
//

#import "UIViewController+Element.h"

@implementation UIViewController (Element)

#if !(TARGET_IPHONE_SIMULATOR)
+ (ELTAccount *)createAccountWithFirstName:(NSString *)fn lastName:(NSString *)ln {
    ELTAccount *account = [ELTAccount createNewAccountWithFirstName:fn lastName:ln email:nil clearTextPin:nil extraInfo:nil userId:[NSUUID UUID].UUIDString];
    return account;
}

- (void)pushFaceUserInitViewControllerForAccount:(ELTAccount *)account {
    LocalFaceEnrollmentViewController *faceUserInitVc = [[LocalFaceEnrollmentViewController alloc] initWithAccount:account completionHandler:^(UIViewController * vc) {
        NSLog(@"completed user enrollment for: %@", account);
        [vc.navigationController popViewControllerAnimated:YES];
    } onEarlyExit:^(UIViewController * vc, ELTEarlyExitReason reason) {
        NSLog(@"user enrollment cancelled for account: %@", account);
        [vc.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:faceUserInitVc animated:YES];
}

- (void)pushUserAuthenticationViewControllerForAccount:(ELTAccount *)account {
    LocalFaceAuthenticationViewController *faceAuthenticationVc = [[LocalFaceAuthenticationViewController alloc] initWithAccount:account onAuthentication:^(UIViewController *vc, CGFloat confidenceScore) {
        NSLog(@"successfully authenticated %@", account);
        [vc.navigationController popViewControllerAnimated:YES];
    } onEarlyExit:^(UIViewController *vc, ELTEarlyExitReason reason) {
        NSLog(@"user cancelled %@", account);
        [vc.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:faceAuthenticationVc animated:YES];
}
#endif

@end
