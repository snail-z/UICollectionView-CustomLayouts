
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
    _loopView.backgroundColor = [UIColor whiteColor];
//    _loopView.textEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 20);
    _loopView.textColor = [UIColor whiteColor];
    _loopView.backColor = [UIColor darkGrayColor];
    _loopView.lineSpacing = 10;
    _loopView.kernValue = 2;
    [self.view addSubview:_loopView];
    
    NSArray *array = @[@"中国共产党第十九次全国代表大会开幕会于10月18日上午9：00在人民大会堂大礼堂举行",
                       @"中国梦，正式提出于2012年11月29日。实现中华民族伟大复兴，就是中华民族近代以来最伟大梦想",
                       @"在中国共产党成立一百年时全面建成小康社会，在新中国成立一百年时建成富强民主文明和谐的社会主义现代化国家。",
                       @"全面建成小康社会、全面深化改革、全面依法治国、全面从严治党。",
                       @"创新、协调、绿色、开放、共享。🇨🇳"];

    NSMutableArray<YT_ScrollLoopModel *> *models = @[].mutableCopy;
    for (NSString *text in array) {
        YT_ScrollLoopModel *model = [YT_ScrollLoopModel new];
        model.text = text;
        [models addObject:model];
    }
    _loopView.models = models;
    [_loopView reloadData];
}

@end
