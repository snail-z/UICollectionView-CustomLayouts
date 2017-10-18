
//
//  MyTestViewController.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/10/18.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "MyTestViewController.h"
#import "YT_ScrollLoopLabel.h"

@interface MyTestViewController ()

@property (nonatomic, strong) YT_ScrollLoopLabel *loopView;

@end

@implementation MyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self commonInitialization];
}

- (void)commonInitialization {
    _loopView = [YT_ScrollLoopLabel new];
    _loopView.frame = CGRectMake(50, 200, 300, 100);
    _loopView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_loopView];
    
    YT_ScrollLoopModel *model = [YT_ScrollLoopModel new];
    model.text = @"1我ad了就是发卡机福利卡接口类发酵素";
    
    YT_ScrollLoopModel *model2 = [YT_ScrollLoopModel new];
    model2.text = @"2我ad了就是发卡机福利卡接口类发酵素";
    
    YT_ScrollLoopModel *model3 = [YT_ScrollLoopModel new];
    model3.text = @"3我ad了就是发卡机福利卡接口类发酵素";
    
    YT_ScrollLoopModel *model4 = [YT_ScrollLoopModel new];
    model4.text = @"4我ad了就是发卡机福利卡接口类发酵素";
    
    _loopView.models = @[model, model2, model3, model4];
    _loopView.textEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 20);
    _loopView.textColor = [UIColor whiteColor];
    _loopView.backColor = [UIColor redColor];
    [_loopView reloadData];
}

@end
