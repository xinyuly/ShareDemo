//
//  KIShareManager.m
//  ShareDemo
//
//  Created by 新雨 on 2017/9/30.
//  Copyright © 2017年 xinyu. All rights reserved.
//

#import "KIShareManager.h"
#import "KIShareMenuView.h"
#import "KIShareAPI.h"
#import "AppDelegate.h"

@interface KIShareManager ()

@property (nonatomic, strong)  NSMutableArray *platformArray;

@property (nonatomic, strong)  UIView *sheetView;

@end

@implementation KIShareManager

- (void)showShareView:(UIViewController *)currentController content:(NSString *)content image:(UIImage *)image shareLink:(NSString *)url{
    self.isHideTipsView = NO;
    [self setupPlatformName];
    KIShareMenuView *shareView = [self setupShareView];
    __weak typeof(self) wself=self;
    [shareView addShareItems:self.platformArray selectShareItem:^(NSInteger tag, NSString *title) {
        PlatformType type = 0;
        switch (tag) {
            case 1:
                type = PlatformType_facebook;
                break;
            case 2:
                type = PlatformType_twitter;
                break;

            default:
                break;
        }

        [wself dismissWindow];
        [KIShareAPI shareLocationToPlatformType:type presentController:currentController content:content image:image completion:^(BOOL success) {
            if (success) {
//                [self ShareSuccess];
            }
        }];
    }];
    
    
}

//设置分享面板图标
- (void)setupPlatformName {
    self.platformArray = [NSMutableArray array];
    NSDictionary *dict1 = @{@"icon":@"facebook.png",@"name":@"Facebook",@"PlatformType":@(1)};
    NSDictionary *dict2 = @{@"icon":@"twitter.png",@"name":@"Twitter",@"PlatformType":@(2)};
    [self.platformArray addObject:dict1];
    [self.platformArray addObject:dict2];
}

- (KIShareMenuView *)setupShareView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissWindow)];
    
    UIView *bgView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //背景颜色
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [window addSubview:bgView];
    [bgView addGestureRecognizer:tap];
    self.sheetView = bgView;
    
    KIShareMenuView *shareView = [[KIShareMenuView alloc] init];
    shareView.rowNumberItem = 3;
    shareView.cancelButtonText = NSLocalizedString(@"取消", nil);
    shareView.shareItemButtonFont = [UIFont systemFontOfSize:12];
    shareView.shareItemButtonColor = [UIColor grayColor];
    shareView.isHideTipsView = self.isHideTipsView;
    [self.sheetView addSubview:shareView];
    
    shareView.closeShareView=^(){
        [self dismissWindow];
    };
    return shareView;
}

- (void)dismissWindow{
    [self.sheetView removeFromSuperview];
    self.sheetView.hidden = YES;
    self.sheetView = nil;
}
@end
