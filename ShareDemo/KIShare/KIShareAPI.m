//
//  KIShareAPI.m
//  LUCKY DEAL
//
//  Created by MRH on 16/7/29.
//  Copyright © 2016年 LUCKY DEAL. All rights reserved.
//

#import "KIShareAPI.h"
#import <Social/Social.h>
#import "SVProgressHUD.h"

@interface KIShareAPI ()

@end

@implementation KIShareAPI


+ (void)shareLocationToPlatformType:(PlatformType)platformType
                  presentController:(UIViewController *)presentController
                            content:(NSString *)content
                              image:(UIImage *)image
                         completion:(void(^)(BOOL success))completion
{
    NSString *serviceType = platformType == PlatformType_facebook ? SLServiceTypeFacebook : SLServiceTypeTwitter;
    
    SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    
    if (facebook == nil) {
        [SVProgressHUD showWithStatus:@"Couldn't Share This Page"];
        completion(NO);
        return;
    }
    
    if (serviceType == SLServiceTypeFacebook && !facebook && ![SLComposeViewController isAvailableForServiceType:serviceType]) {
        // TO DO:
        [SVProgressHUD showWithStatus:@"Oops, Looks you need to install Facebook."];
        completion(NO);
        return;
    }
    [facebook setInitialText:content];
    
    [facebook addImage:image];
    [presentController presentViewController:facebook animated:YES completion:nil];
    facebook.completionHandler = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultCancelled) {
            completion(NO);
        }
        else {
            completion(YES);
        }
    };
    
}
@end
