//
//  LineLayout.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/13.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "LineLayout.h"

@implementation LineLayout

- (void)prepareLayout {
    [super prepareLayout];
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
    self.sectionInset = UIEdgeInsetsMake(20, inset, 20, inset);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
   
    // 获得super已经计算好的布局属性，只有线性布局才可使用(继承自UICollectionViewFlowLayout)
    NSMutableArray *attributes = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    
    // 相对于当前视觉上中心点X的值，视图滚动时x的偏移量+视图本身width的一半；也就是缩放程度最大的item中心位置
    CGFloat visualCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2;
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        
        /*
         获取每个item的中心点X距离visualCenterX的间距增量
         求出的绝对值只会在 0 ~ self.collectionView.bounds.size.width/2 之间
         */
        CGFloat delta = ABS(attr.center.x - visualCenterX);
        
        /*
         根据间距计算item的缩放的比例:
         由于已知delta的取值范围，所以 delta / self.collectionView.bounds.size.width 的值在0~0.5之间；
         控制item的的缩放比例在 0.5~1 之间，则用1减去这个值即可；
         */
        CGFloat scale = 1 - delta / self.collectionView.bounds.size.width;
        /*
         如何控制缩放比例在 0.2 ~ 1 之间？
         由于delta的最小取值是0，所以只需计算delta为最大值时k的值，由此得出下列两个方程式：
         
                ⎧ delta = self.collectionView.bounds.size.width / 2;
             1. ⎨
                ⎩ 0.2 = 1 - delta / k;
         
                ⎧ delta = self.collectionView.bounds.size.width / 2;
             2. ⎨
                ⎩ 1 = 1 - delta / k;
         
         由于1 - 0 = 1，所以程式②也无需计算，计算程式①可得：
         
         k = delta / (1 - 0.2) ;
         k = self.collectionView.bounds.size.width * 0.5 / 0.8
         k = 5 / 8 * self.collectionView.bounds.size.width
         然后代入k值即可
         
         k = self.collectionView.bounds.size.width * 0.5 / (1 - p)
         */
        
        // 设置缩放比例
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attributes;
}

/*
 当CollectionView的显示范围发生改变的时候，是否重新刷新布局，刷新布局会重新调用:
 - layoutAttributesForElementsInRect:
 - preparelayout方法
 
 当滚动时每个item的bounds也会随之变化，需要设置该方法返回YES;
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

/*
 proposedContentOffset为系统期望滑动到的位置，velocity为加速度，可以通过这两个参数以及当前所在的位置计算出你希望它滑动到的位置，具体算法根据需求的不同来实现;
 proposedContentOffset：默认情况下CollectionView停止滚动时最终的偏移量。
 velocity：滚动速率，通过这个参数可以了解滚动的方向。
 
 返回值决定了collectionView停止滚动时最终的偏移量contentOffset;（最终collectionView停到哪个位置的偏移量）
 当在拖动的時候,手指抬起时调用
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    /// 该方法用来定位: 判断哪些item离中心点近，就显示在中心位置
    
    // 计算最终显示的那块区域
    CGRect targetRect = self.collectionView.bounds;
    targetRect.origin = CGPointMake(proposedContentOffset.x, 0);
    
    // 然后获取显示区域下所有的item，判断哪个距离中心点最近
    NSArray *attributes = [super layoutAttributesForElementsInRect:targetRect];
    
    // 获取中心点X
    CGFloat visualCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;

    // 存放离中心点最近的间距，初始设置MAXFLOAT方便比较
    CGFloat minSpace = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        
        // ABS(attr.center.x - visualCenterX) 每个item中心点X相对visualCenterX的距离
        if (ABS(minSpace) > ABS(attr.center.x - visualCenterX)) {
           
            // 使用实际的 attrs.center.x - visualCenterX，只是使用绝对值用来比较
            minSpace = attr.center.x - visualCenterX;
        }
    }
    
    proposedContentOffset.x += minSpace;
    
    return proposedContentOffset;
}

@end
