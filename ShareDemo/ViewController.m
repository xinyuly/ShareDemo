//
//  ViewController.m
//  ShareDemo
//
//  Created by 新雨 on 2017/9/30.
//  Copyright © 2017年 xinyu. All rights reserved.
//

#import "ViewController.h"
#import "KIShareManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)share:(id)sender {
    
    [[[KIShareManager alloc] init] showShareView:self content:@"我是分享内容哦😯" image:[UIImage imageNamed:@"icon"] shareLink:@"https://github.com/xinyuly"];

}



@end
