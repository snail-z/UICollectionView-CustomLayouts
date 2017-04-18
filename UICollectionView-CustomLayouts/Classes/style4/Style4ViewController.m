//
//  Style4ViewController.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/14.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "Style4ViewController.h"
#import "CollectionViewTableLayout.h"
#import "CollectionViewTableCell.h"

@interface Style4ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation Style4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CollectionViewTableLayout *layout = [[CollectionViewTableLayout alloc] init];
    layout.itemSize = CGSizeMake(90, 50);
    
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
    
    [_collectionView registerClass:[CollectionViewTableCell class] forCellWithReuseIdentifier:@"table_cell"];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 21;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"table_cell" forIndexPath:indexPath];
    if (indexPath.section ==0 && indexPath.row == 0 ) {
        cell.textLabel.text = @"—";
    } else if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"第%lu列", indexPath.row];
    } else if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"第%lu行", indexPath.section];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"(%lu, %lu)", indexPath.section, indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"s - %lu r - %lu", indexPath.section, indexPath.row);
}

@end
