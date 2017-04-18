//
//  WaterfallFlowLayout.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/11.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "WaterfallFlowLayout.h"

@interface WaterfallFlowLayout ()

@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, strong) NSMutableArray *allColumnHeights;
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation WaterfallFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    // 获取列数
    NSInteger column = 2; // 默认两列
    if ([self.delegate respondsToSelector:@selector(collectionView:numberOfColumnInWaterfallFlowLayout:)]) {
        column = [self.delegate collectionView:self.collectionView numberOfColumnInWaterfallFlowLayout:self];
    }
    
    // 初始化allColumnHeights数组
    _allColumnHeights = [NSMutableArray array];
    for (int i = 0; i < column; i++) {
        [_allColumnHeights addObject:@(self.sectionInset.top)];
    }
    
    // 计算所有间距
    CGFloat margin = self.sectionInset.left + self.sectionInset.right + (column - 1) * self.minimumInteritemSpacing;
    
    // 计算item width
    CGFloat itemWidth = (self.collectionView.bounds.size.width - margin) / column;
    
    self.itemAttributes = [NSMutableArray array];
    
    NSUInteger numberOfSections = [self.collectionView numberOfSections];
    
    for (NSInteger s = 0; s < numberOfSections; s++) { // sections
        
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:s];
        NSMutableArray *sectionAttributes = [NSMutableArray arrayWithCapacity:numberOfItems];

        for (NSInteger i = 0; i < numberOfItems; i++) { // items
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:s];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            // 获取设置的size
            BOOL respond = [self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)];
            NSAssert(respond, @"必须实现代理方法 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(WaterfallFlowLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;");
            
            CGSize itemSize;
            if (respond) {
                itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            }
            
            // 等比例缩放height, 防止代理中给的size.width大于(或小于)布局中计算itemWidth
            CGFloat itemHeight = floorf(itemSize.height * itemWidth / itemSize.width);
            
            // 获取数组中最小值
            NSNumber *minValue = [self.allColumnHeights valueForKeyPath:@"@min.self"];
            
            // minValue对应的下标
            NSInteger index = [self.allColumnHeights indexOfObject:minValue];
            
            // 得到最短Height
            CGFloat lowestHeight = minValue.floatValue + self.minimumLineSpacing + itemHeight;
            
            // 替换最小值
            [self.allColumnHeights replaceObjectAtIndex:index withObject:@(lowestHeight)];
           
            // x点
            CGFloat itemX = self.sectionInset.left + (self.minimumInteritemSpacing + itemWidth) * index;
            
            // y点（当前item放在最小y下面）
            CGFloat itemY = minValue.floatValue;
            
            // 设置attributes.frame
            attributes.frame = CGRectIntegral(CGRectMake(itemX, itemY, itemWidth, itemHeight));
            
            [sectionAttributes addObject:attributes];
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
    NSNumber *maxValue = [self.allColumnHeights valueForKeyPath:@"@max.self"];
    _contentSize = CGSizeMake(self.collectionView.bounds.size.width, maxValue.floatValue - self.minimumLineSpacing + self.sectionInset.bottom);
}

- (CGSize)collectionViewContentSize {
    return _contentSize;

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }]]];
    }
    return attributes;
}


//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return self.itemAttributes[indexPath.section][indexPath.row];
//}

@end
