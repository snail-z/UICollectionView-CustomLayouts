//
//  YT_ScrollLoopView.h
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/10/18.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YT_ScrollLoopModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSAttributedString *attributedText;

@end

@interface YT_ScrollLoopLabel : UIView

/// 设置滚动方向 (默认水平方向)
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/// 自动滚动间隔时间 (默认2s)
@property (nonatomic, assign) NSTimeInterval timeInterval;

/// 是否自动滚动 (默认YES)
@property (nonatomic, assign) BOOL isAutoscroll;

/// 是否无限循环 (默认YES)
@property (nonatomic, assign) BOOL isInfiniteLoop;

/// 是否允许手动滚动 (默认YES)
@property (nonatomic, assign) BOOL scrollEnabled;

/// 设置textLabel边距
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

/// 轮播文字label字体颜色
@property (nonatomic, strong) UIColor *textColor;

/// 轮播文字label背景颜色
@property (nonatomic, strong) UIColor *backColor;

/// 轮播文字label字体
@property (nonatomic, strong) UIFont *font;

/// 轮播文字label多行显示
@property (nonatomic, assign) NSInteger numberOfLines;

/// 轮播label文字的对齐方式
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// 轮播label文字的字距调整
@property (nonatomic, assign) CGFloat kernValue;

/// 轮播label文字的行距调整
@property (nonatomic, assign) CGFloat lineSpacing;

/// 设置数据源
@property (nonatomic, strong) NSArray<YT_ScrollLoopModel *> *models;

/// 刷新数据源
- (void)reloadData;

@end
