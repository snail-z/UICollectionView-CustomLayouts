//
//  Style1CollectionViewFlowLayout.h
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/13.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

// 参考：<https://github.com/c0ming/SBCollectionViewFlowLayout>

#import <UIKit/UIKit.h>

@interface Style1CollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIImage *backgroundImage;

@end

// Supplementary views 和 decoration views 必须是UICollectionReusableView的子类
@interface Style1CollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@protocol Style1CollectionViewDelegateFlowLayout;

@interface Style1CollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <Style1CollectionViewDelegateFlowLayout> delegate;

@end

@protocol Style1CollectionViewDelegateFlowLayout <NSObject>
@optional

- (UIImage *)collectionView:(UICollectionView *)collectionView layout:(Style1CollectionViewFlowLayout*)collectionViewLayout backgroundImageForSectionAtIndex:(NSInteger)section;

@end
