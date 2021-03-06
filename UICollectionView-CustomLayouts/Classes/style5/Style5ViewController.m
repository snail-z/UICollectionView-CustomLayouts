//
//  Style6ViewController.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/14.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "Style5ViewController.h"
#import "CarouselLayout.h"

@interface Style5ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation Style5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CarouselLayout *layout = [[CarouselLayout alloc] init];
    layout.itemSize = CGSizeMake(200, 300);
    layout.visibleCount = 3;
    layout.space = 50;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.bounces = NO;
    _collectionView.directionalLockEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(74);
        make.right.bottom.mas_equalTo(-10);
    }];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"table_cell"];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"table_cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"s - %lu r - %lu", indexPath.section, indexPath.row);
}

@end
