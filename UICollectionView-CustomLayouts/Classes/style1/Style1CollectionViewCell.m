//
//  Style2CollectionViewCell.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/12.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "Style1CollectionViewCell.h"

@implementation Style1CollectionViewCell

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height).multipliedBy(0.5);
            make.width.right.bottom.equalTo(self);
        }];
    }
    return self;
}

@end

@implementation Style1CollectionFooterView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
