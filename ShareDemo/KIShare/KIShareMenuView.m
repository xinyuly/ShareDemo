//
//  KIShareMenuView.m
//  LUCKY DEAL
//
//  Created by MacLw on 17/5/2.
//  Copyright © 2017年 LUCKY DEAL. All rights reserved.
//

#import "KIShareMenuView.h"

#define kBtnW 80
#define kBtnH 80
#define kMarginX 15
#define kMarginY 15
#define kFirst 10
#define kBtnMargin 20
#define kTitlePrecent 0.4
#define kImageViewWH 60
#define RGB(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
// 语言适配
#define kLocalizedString(string) NSLocalizedString(string,nil)
// 屏幕的高度
#define  kScreenHeight  [UIScreen mainScreen].bounds.size.height
// 屏幕的宽度
#define  kScreenWidth   [UIScreen mainScreen].bounds.size.width

@interface KIShareItemButton()

@end

@implementation KIShareItemButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:RGB(40, 40, 40) forState:UIControlStateNormal];
        self.imageView.layer.cornerRadius = kImageViewWH * 0.5;
    }
    return self;
}
#pragma mark - 调整文字的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * kTitlePrecent;
    CGFloat titleX = 2;
    CGFloat titleY = self.frame.size.height * (1 - kTitlePrecent) + 7;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
#pragma mark - 调整图片的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = kImageViewWH;
    CGFloat imageH = kImageViewWH;
    CGFloat imageX = (self.frame.size.width - kImageViewWH) * 0.5;
    CGFloat imageY = 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end

@interface KIShareMenuView()
@property (nonatomic, strong) NSArray *sharItems;
@property (nonatomic, strong) UIView  *backgroundView;
@property (nonatomic, strong) UIButton *canleBtn;
@property (nonatomic, copy) void(^btnBlock)(NSInteger tag, NSString *title);

@end

@implementation KIShareMenuView

- (void)addShareItems:(NSArray *)shareItems selectShareItem:(selectItemBlock)selectShareItem{
    if (shareItems == nil || shareItems.count < 1) return;
    self.backgroundColor = [UIColor whiteColor];
    
    //相关属性值
    NSInteger curRowNumberItem = self.rowNumberItem?:4;
    NSString *cannelText = self.cancelButtonText?:kLocalizedString(@"取消");
    
    //分享面板标题
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, kFirst, kScreenWidth, 20)];
    titleLable.text = kLocalizedString(@"分享到");
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLable];
    
    UILabel *tempLabel = [UILabel new];
    //设置提示文本
    if(!self.isHideTipsView){
        UILabel *tipTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLable.frame)+ kFirst, 55, 20)];
        tipTextLabel.font = [UIFont systemFontOfSize:11];
        tipTextLabel.text = kLocalizedString(@"提示:");
        tipTextLabel.textColor = [UIColor grayColor];
        [self addSubview:tipTextLabel];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.frame = CGRectMake(CGRectGetMaxX(tipTextLabel.frame), CGRectGetMaxY(titleLable.frame) + kFirst, kScreenWidth-20-CGRectGetWidth(tipTextLabel.frame), 20);
        
        tipLabel.numberOfLines = 0;
        tipLabel.text = kLocalizedString(@"分享Facebook/Twitter各获取一次奖励");
        [self addSubview:tipLabel];
        
        UILabel *remarkLabel = [[UILabel alloc] init];
        remarkLabel.font = [UIFont systemFontOfSize:10];
        remarkLabel.textColor = [UIColor redColor];
        remarkLabel.frame = CGRectMake(CGRectGetMaxX(tipTextLabel.frame), CGRectGetMaxY(tipLabel.frame), kScreenWidth-20-CGRectGetWidth(tipTextLabel.frame), 20);
        NSString *displayName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        remarkLabel.text = [NSString stringWithFormat:kLocalizedString(@"分享成功后,需点击“返回%@”才可获得奖励"),displayName ];
        remarkLabel.numberOfLines = 0;
        [self addSubview:remarkLabel];
        tempLabel = remarkLabel;
    }
    
    //设置分享按钮
    [shareItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj[@"name"];
        NSString *icon = obj[@"icon"];
        NSInteger platformType = [obj[@"PlatformType"] integerValue];
        KIShareItemButton *btn = [KIShareItemButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = self.shareItemButtonFont?:[UIFont systemFontOfSize:12];
        [btn setTitleColor:self.shareItemButtonColor?:RGB(40, 40, 40) forState:UIControlStateNormal];
        btn.tag = platformType;
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat marginX = (self.frame.size.width - curRowNumberItem * kBtnW) / (curRowNumberItem + 1);
        NSInteger col = idx % curRowNumberItem;
        NSInteger row = idx / curRowNumberItem;
        CGFloat btnX = marginX + (marginX + kBtnW) * col;
        CGFloat btnY = (self.isHideTipsView?CGRectGetMaxY(titleLable.frame):CGRectGetMaxY(tempLabel.frame))+ kBtnMargin  + (kMarginY + kBtnH) * row;
        btn.frame = CGRectMake(btnX, btnY, kBtnW, kBtnH);
        [self addSubview:btn];
    }];
    
    
    NSUInteger row = (shareItems.count - 1) / curRowNumberItem;
    
    
    //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (row +1)* (kBtnH + kMarginY)+5+CGRectGetMaxY(titleLable.frame)+(self.isHideTipsView?kBtnMargin:CGRectGetMaxY(tempLabel.frame)), kScreenWidth, 0.5)];
    line.backgroundColor = RGB(180, 180, 180);
    [self addSubview:line];
    
    //取消
    self.canleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canleBtn.frame = CGRectMake(0, CGRectGetMaxY(line.frame), self.frame.size.width, 44);
    [self.canleBtn setTitle:cannelText forState:UIControlStateNormal];
    self.canleBtn.titleLabel.font = self.cancelButtonFont?:[UIFont systemFontOfSize:16];
    [self.canleBtn setBackgroundColor:self.cancelBackgroundColor?:[UIColor whiteColor]];
    [self.canleBtn setTitleColor:self.cancelButtonColor?:[UIColor grayColor] forState:UIControlStateNormal];
    [self.canleBtn addTarget:self action:@selector(cancleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.canleBtn];
    
    self.btnBlock = ^(NSInteger tag, NSString *title){
        if(selectShareItem){
            selectShareItem(tag, title);
        }
    };
    
    //计算面板大小
    CGFloat height = CGRectGetMaxY(self.canleBtn.frame);
    
    
    CGFloat originY = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, originY, 0, height);
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sF = self.frame;
        sF.origin.y = kScreenHeight - sF.size.height;
        self.frame = sF;
    }];
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = kScreenWidth;
    if (frame.size.height <= 0) {
        frame.size.height = 0;
    }
    frame.origin.x = 0;
    [super setFrame:frame];
}


- (void)cancleButtonAction{
    
    if(self.closeShareView){
        self.closeShareView();
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sf = self.frame;
        sf.origin.y = kScreenHeight;
        self.frame = sf;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)btnClick:(UIButton *)sender{
    if(_btnBlock) _btnBlock(sender.tag, sender.titleLabel.text);
}

@end
