//
//  WaterfallFlowLayout.h
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/11.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterfallFlowLayoutDelegate;

@interface WaterfallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <WaterfallFlowLayoutDelegate> delegate;

@end

@protocol WaterfallFlowLayoutDelegate <NSObject>
@required

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WaterfallFlowLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfColumnInWaterfallFlowLayout:(WaterfallFlowLayout*)collectionViewLayout;

@end
