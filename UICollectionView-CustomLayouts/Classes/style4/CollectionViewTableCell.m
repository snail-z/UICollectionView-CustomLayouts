//
//  CollectionViewTableCell.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/18.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "CollectionViewTableCell.h"

@implementation CollectionViewTableCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor darkGrayColor];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_textLabel];
        
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_rightLine];
        
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_bottomLine];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(7);
            make.width.mas_equalTo(.5);
            make.right.mas_equalTo(-1);
            make.bottom.mas_equalTo(-7);
        }];
        
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(.5);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

@end
