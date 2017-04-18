//
//  CarouselLayout.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/14.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "CarouselLayout.h"

@interface CarouselLayout () {
    CGFloat _viewWidth;
    CGFloat _itemWidth;
}

@end

@implementation CarouselLayout

- (void)prepareLayout {
    [super prepareLayout];
    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    } else {
        self.visibleCount += 2;
    }
    
    if (self.space < 1) {
        self.space = 30;
    }
    
    _viewWidth = CGRectGetWidth(self.collectionView.frame);
    _itemWidth = self.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewWidth - _itemWidth) / 2, 0, (_viewWidth - _itemWidth) / 2);
}

- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(cellCount * _itemWidth, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerY = self.collectionView.contentOffset.x + _viewWidth / 2;
    NSInteger index = centerY / _itemWidth;
    NSInteger count = (self.visibleCount - 1) / 2;
    
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    CGFloat centerX = self.collectionView.contentOffset.x + _viewWidth / 2;
    CGFloat attributesY = _itemWidth * indexPath.row + _itemWidth / 2;
    CGFloat delta = ABS(attributesY - centerX);
    CGFloat q = (_itemWidth - self.space * 2) / _itemWidth;
    CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5 / (1 - q));
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    attributes.center = CGPointMake(attributesY, CGRectGetHeight(self.collectionView.frame) / 2);
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = roundf((proposedContentOffset.x + _viewWidth / 2 - _itemWidth / 2) / _itemWidth);
    proposedContentOffset.x = _itemWidth * index + _itemWidth / 2 - _viewWidth / 2;
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

@end
