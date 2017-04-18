//
//  ViewController.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/11.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_styles;
    NSMutableArray *_classNames;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
    }
    [self.view addSubview:_tableView];
    
    [self dataInitialization];
    [_tableView reloadData];
}

- (void)dataInitialization {
    _styles = [NSMutableArray array];
    _classNames = [NSMutableArray array];
    
    [self addStyle:@"Flow layout / 线性布局1" class:@"Style1ViewController"];
    [self addStyle:@"Waterfall flow / 瀑布流" class:@"Style2ViewController"];
    [self addStyle:@"Line layout / 线性布局2" class:@"Style3ViewController"];
    [self addStyle:@"Table layout / 表格布局" class:@"Style4ViewController"];
    [self addStyle:@"Carousel layout / 轮转布局" class:@"Style5ViewController"];

    //    [self addStyle:@"Test" class:@"TestViewController"];
}

- (void)addStyle:(NSString *)style class:(NSString *)className {
    [_styles addObject:style];
    [_classNames addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _styles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _styles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = [[class alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.navigationItem.title = _styles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
