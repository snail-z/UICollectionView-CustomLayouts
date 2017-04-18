//
//  Style1CollectionViewFlowLayout.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/13.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "Style1CollectionViewFlowLayout.h"

@implementation Style1CollectionViewLayoutAttributes

- (UIImage *)backgroundImage {
    if (_backgroundImage) {
        return _backgroundImage;
    }
    return [UIImage imageWithColor:[UIColor r:175 g:238 b:238]]; // default color
}

@end


@implementation Style1CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backgroundImageView.frame = self.bounds;
}

// Cell 视图、Supplementary 视图它们都是 UICollectionReusableView 的子类，Decoration 视图也不例外。但前面已说到 Decoration 视图无法通过数据源来设置，也没有 dequeue 相关的方法，自定义的属性只能通过 UICollectionReusableView 的 apply 方法在 CollectionView 布局时来使之生效。<http://c0ming.me/different-section-background-color/>
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[Style1CollectionViewLayoutAttributes class]]) {
        Style1CollectionViewLayoutAttributes *attributes = (Style1CollectionViewLayoutAttributes *)layoutAttributes;
        _backgroundImageView.image = attributes.backgroundImage;
    }
}

@end


@interface Style1CollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttributes;

@end

static NSString *const DecorationViewBackgroundIdentify = @"DecorationViewBackgroundIdentify";

@implementation Style1CollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        [self registerClass:[Style1CollectionReusableView class] forDecorationViewOfKind:DecorationViewBackgroundIdentify];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (0 == numberOfSections) {
        return;
    }
    
    _decorationViewAttributes = [NSMutableArray array];
    
    for (NSInteger s = 0; s < numberOfSections; s++) {
        
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:s];
        
        CGRect sectionFrame = CGRectZero;
        if (numberOfItems > 0) {
            /*
             -(UICollectionViewLayoutAttributes _)layoutAttributesForItemAtIndexPath:(NSIndexPath _)indexPath
             返回对应于indexPath的位置的cell的布局属性
             */
            UICollectionViewLayoutAttributes *firstItemAttri = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:s]];
            
            UICollectionViewLayoutAttributes *lastItemAttri = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:s]];
            
            // CGRect CGRectUnion(CGRect r1, CGRect r2); 返回两个矩形的并集
            sectionFrame = CGRectUnion(firstItemAttri.frame, lastItemAttri.frame);
        }
        
        id <UICollectionViewDelegateFlowLayout> delegate = (id <UICollectionViewDelegateFlowLayout> )self.collectionView.delegate;
        UIEdgeInsets sectionInset = self.sectionInset;
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets insets = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:s];
            sectionInset = insets;
        }
        
        // 根据滚动方向计算sectionFrame
        if (UICollectionViewScrollDirectionHorizontal == self.scrollDirection) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
            sectionFrame.origin.x -= sectionInset.left;
            sectionFrame.origin.y = 0;
        } else {
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
            sectionFrame.origin.x = 0;
            sectionFrame.origin.y -= sectionInset.top;
        }
        
        Style1CollectionViewLayoutAttributes *attributes = [Style1CollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:DecorationViewBackgroundIdentify withIndexPath:[NSIndexPath indexPathForItem:0 inSection:s]];
        attributes.frame = sectionFrame;
        attributes.zIndex = -1; // default is 0
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:backgroundImageForSectionAtIndex:)]) {
            attributes.backgroundImage = [self.delegate collectionView:self.collectionView layout:self backgroundImageForSectionAtIndex:s];
        }
        [_decorationViewAttributes addObject:attributes];
    }
}

/*
 -(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
 返回rect中的所有的元素的布局属性
 返回的是包含UICollectionViewLayoutAttributes的NSArray
 UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
 
 layoutAttributesForCellWithIndexPath:
 layoutAttributesForSupplementaryViewOfKind:withIndexPath:
 layoutAttributesForDecorationViewOfKind:withIndexPath:
 */
/// 用来计算出rect这个范围内所有cell的UICollectionViewLayoutAttributes并返回
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    [attributes addObjectsFromArray:[_decorationViewAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]]];
    return attributes;
}

@end
