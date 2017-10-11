//
//  KIShareManager.h
//  ShareDemo
//
//  Created by 新雨 on 2017/9/30.
//  Copyright © 2017年 xinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIShareManager : NSObject

@property (nonatomic,assign) BOOL isHideTipsView;   //是否隐藏提示文本视图

- (void)showShareView:(UIViewController *)currentController content:(NSString *)content image:(UIImage *)image shareLink:(NSString *)url;

@end
