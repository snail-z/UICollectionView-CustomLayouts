//
//  CollectionViewTableLayout.h
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/18.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

//  参考： <https://github.com/KaiZhang890/ShowQuotations>
#import <UIKit/UIKit.h>

@interface CollectionViewTableLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize itemSize;
@property (strong, nonatomic) NSMutableArray *itemAttributes;

@end
