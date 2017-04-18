//
//  Style1ViewController.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/11.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "Style2ViewController.h"
#import "WaterfallFlowLayout.h"

@interface Style2ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WaterfallFlowLayoutDelegate> {
    NSMutableArray *_array;
    NSMutableArray *_heights;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation Style2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WaterfallFlowLayout *layout = [[WaterfallFlowLayout alloc] init];
    layout.delegate = self;
    layout.minimumLineSpacing = 7;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
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
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self dataInitialization];
}

- (void)dataInitialization {
    _array = [NSMutableArray array];
    _heights = [NSMutableArray array];
    for (int i = 0; i < 30; i ++) {
        [_array addObject:@(i)];
        CGFloat height = 100 +  (arc4random() % 301);
        [_heights addObject:@(height)];
    }
    [_collectionView reloadData];
}

#pragma mark - WaterfallFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WaterfallFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, [_heights[indexPath.row] floatValue]);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfColumnInWaterfallFlowLayout:(WaterfallFlowLayout *)collectionViewLayout {
    return 3;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"s - %lu r - %lu", indexPath.section, indexPath.row);
}

@end
