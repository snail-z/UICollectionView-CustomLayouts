//
//  CarouselLayout.h
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/14.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

// 参考：<https://github.com/panghaijiao/HJCarouselDemo>

#import <UIKit/UIKit.h>

@interface CarouselLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger visibleCount; // 当前item最多可见数量
@property (nonatomic, assign) CGFloat space; // 根据间距控制缩放比例

@end
