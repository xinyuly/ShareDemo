//
//  KIShareAPI.h
//  LUCKY DEAL
//
//  Created by MRH on 16/7/29.
//  Copyright © 2016年 LUCKY DEAL. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSInteger, PlatformType) {
    PlatformType_facebook = 0,
    PlatformType_twitter
};

@interface KIShareAPI : NSObject

+ (void)shareLocationToPlatformType:(PlatformType)platformType
                  presentController:(UIViewController *)presentController
                            content:(NSString *)content
                              image:(UIImage *)image
                            completion:(void(^)(BOOL success))completion;
@end
