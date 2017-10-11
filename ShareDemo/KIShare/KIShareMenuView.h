//
//  KIShareMenuView.h
//  LUCKY DEAL
//
//  Created by MacLw on 17/5/2.
//  Copyright © 2017年 LUCKY DEAL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectItemBlock)(NSInteger tag, NSString *title);

@interface KIShareItemButton : UIButton

@end

@interface KIShareMenuView : UIView
//一行有几个
@property (nonatomic, assign) NSInteger rowNumberItem;

//菜单文字设置
@property (nonatomic, strong) UIFont  *shareItemButtonFont;

@property (nonatomic, strong) UIColor *shareItemButtonColor;

//底部取消相关设置
@property (nonatomic, strong) UIColor  *cancelBackgroundColor;

@property (nonatomic, copy)   NSString *cancelButtonText;

@property (nonatomic, strong) UIFont   *cancelButtonFont;

@property (nonatomic, strong) UIColor  *cancelButtonColor;

@property (nonatomic, assign) BOOL isHideTipsView;   //是否隐藏提示文本视图

@property (nonatomic, copy) void(^showTabbarBlock)();

@property (nonatomic, copy) void (^closeShareView)();

/**
 *  弹出分享
 *
 *  @param shareItems      QQ/WeChat/Weibo
 *  @param selectShareItem 点击回调
 */
- (void)addShareItems:(NSArray *)shareItems selectShareItem:(selectItemBlock)selectShareItem;

- (void)cancleButtonAction;

@end
