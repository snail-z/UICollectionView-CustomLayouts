//
//  YT_ScrollLoopView.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/10/18.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "YT_ScrollLoopLabel.h"

@implementation YT_ScrollLoopModel

@end

@interface YT_ScrollLoopCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) UIEdgeInsets textInsets;

@end

@implementation YT_ScrollLoopCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.numberOfLines = 0;
        _textLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).priorityLow();
        }];
    }
    return self;
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textInsets.top);
        make.bottom.mas_equalTo(-textInsets.bottom);
        make.left.mas_equalTo(textInsets.left);
        make.right.mas_equalTo(-textInsets.right);
    }];
}

- (void)setModel:(YT_ScrollLoopModel *)model
       kernValue:(CGFloat)kern lineSpacing:(CGFloat)LineSpacing{
    if (model.attributedText && model.attributedText.length) {
        _textLabel.attributedText = model.attributedText;
    } else {
        if (!model.text) return;
        NSString *text = model.text;
        NSMutableAttributedString *attiText = [[NSMutableAttributedString alloc] initWithString:text];
        [attiText addAttribute:NSKernAttributeName value:@(kern) range:NSMakeRange(0, [text length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LineSpacing];
        [attiText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        _textLabel.attributedText = attiText;
    }
}

@end

@interface YT_ScrollLoopLabel () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSTimer *rollingTimer;
@property (nonatomic, assign) NSInteger totalItemsCount;

@end

static NSString *const YTScrollLoopCellIdentifier = @"YTScrollLoopCellIdentifier";

@implementation YT_ScrollLoopLabel

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.isAutoscroll = YES;
        self.isInfiniteLoop = YES;
        self.scrollEnabled = YES;
        [self commonInitialization];
    }
    return self;
}

- (void)commonInitialization {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[YT_ScrollLoopCell class] forCellWithReuseIdentifier:YTScrollLoopCellIdentifier];
}

#pragma mark - Getter / Setter

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    [(UICollectionViewFlowLayout *)_collectionView.collectionViewLayout setScrollDirection:scrollDirection];
}

- (void)setIsAutoscroll:(BOOL)isAutoScroll {
    _isAutoscroll = isAutoScroll;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
}

- (void)setIsInfiniteLoop:(BOOL)isInfiniteLoop {
    _isInfiniteLoop = isInfiniteLoop;
}

- (void)setModels:(NSArray<YT_ScrollLoopModel *> *)models {
    _models = models;
}

- (void)reloadData {
    if (_models && _models.count) {
        _totalItemsCount = _isInfiniteLoop ? _models.count * 200 : _models.count;
        
        [self childViewsLayout];
        [_collectionView reloadData];
        _collectionView.scrollEnabled = _scrollEnabled;
        _models.count > 1 ? [self startRolling] : [self invalidateTimer];
    }
}

- (void)childViewsLayout {
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YT_ScrollLoopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YTScrollLoopCellIdentifier forIndexPath:indexPath];
    cell.textLabel.textColor = self.textColor;
    cell.textLabel.font = self.font;
    cell.textLabel.backgroundColor = self.backColor;
    cell.textLabel.textAlignment = self.textAlignment;
    cell.textLabel.numberOfLines = self.numberOfLines;
    cell.textInsets = self.textEdgeInsets;
    YT_ScrollLoopModel *model = _models[indexPath.row % _models.count];
    [cell setModel:model kernValue:self.kernValue lineSpacing:self.lineSpacing];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.item % _models.count;
    if (self.didClickItem) {
        self.didClickItem(self, idx);
    } else {
        if ([self.delegate respondsToSelector:@selector(scrollLoopLabel:didClickItemAtIndex:)]) {
            [self.delegate scrollLoopLabel:self didClickItemAtIndex:idx];
        }
    }
}

#pragma mark - Auto Scroll

- (void)invalidateTimer {
    [_rollingTimer invalidate];
    _rollingTimer = nil;
}

- (void)startRolling {
    if (_rollingTimer) {
        [self invalidateTimer];
    }
    NSTimeInterval interval = self.timeInterval ? self.timeInterval : 2.f;
    _rollingTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(scrollLoopView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_rollingTimer forMode:NSRunLoopCommonModes];
}

- (void)scrollLoopView {
    void (^scrollItems)(NSInteger, BOOL) = ^(NSInteger index, BOOL animated) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    };
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex = currentIndex + 1;
    if (targetIndex >= _totalItemsCount) {
        if (_isInfiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
            scrollItems(targetIndex, NO);
        }
    } else {
        scrollItems(targetIndex, YES);
    }
}

- (NSInteger)currentIndex {
    NSInteger index = 0;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_collectionView.contentOffset.x + _collectionView.bounds.size.width / 2) / _collectionView.bounds.size.width;
    } else {
        index = (_collectionView.contentOffset.y + _collectionView.bounds.size.height / 2) / _collectionView.bounds.size.height;
    }
    return MAX(0, index);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_isAutoscroll) [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_isAutoscroll) [self startRolling];
}

#pragma mark - Remove

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

@end
