//
//  Style4ViewController.m
//  UICollectionView-CustomLayouts
//
//  Created by zhanghao on 2017/4/13.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UIImageView *demoImageView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(myClicked:)];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reset)]];
    
//    [self sample1];
    
//    [self sample2];
    
//    [self sample3];
    
    [self sample4];
}

- (void)sample4 {
    /*
     CGAffineTransform 定义
     用于绘制2D图形的一个仿射变换矩阵。一个仿射变换矩阵用于做旋转、缩放、平移，一个仿射变换矩阵是一个3*3的矩阵，如下:
     */
    
    self.demoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 120, 150, 150)];
    self.demoImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.demoImageView];
}

- (void)myClicked:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{

        // 格式
//        CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
        // 样例
//        self.demoImageView.transform = CGAffineTransformMakeTranslation(100, 100);
        
        
        // 格式
//        CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
        // 样例
        self.demoImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        
        // 格式
//        CGAffineTransformMakeRotation(CGFloat angle)
        // 样例
//        self.demoImageView.transform = CGAffineTransformMakeRotation(M_PI*0.5);
        
        
        // 格式
//        CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
        // 样例
//        CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
//        self.demoImageView.transform = CGAffineTransformTranslate(transform, 50, 50);
        
        // 格式
//        CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
//        // 样例
//        CGAffineTransform transform = CGAffineTransformMakeScale(2, 0.5);
//        self.demoImageView.transform = CGAffineTransformScale(transform, 2, 1);
        
    }];
}



- (void)reset {
    [UIView animateWithDuration:0.5 animations:^{
        self.demoImageView.transform = CGAffineTransformIdentity;
    }];
}


- (void)sample3 {
    /*
     int abs(int i);    // 处理int类型的取绝对值
     double fabs(double i); //处理double类型的取绝对值
     float fabsf(float i);  //处理float类型的取绝对值
     */
    
    CGFloat k = -3.5;
    
    CGFloat f = 1.5;
    NSLog(@"%f", f + ABS(k));
}

- (void)sample2 {
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"two", @"six", @"seven", @"five", nil];
    NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", nil];
    NSArray *array = @[@"2", @"3", @"4", @"5"];
    
    [array1 addObjectsFromArray:array];
    NSLog(@"array1 - %@", array1);
    
    NSArray *array3 = [array2 arrayByAddingObjectsFromArray:array];
    NSLog(@"array3 - %@", array3);
}

- (void)sample1 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    view1.backgroundColor = [UIColor orangeColor];
    view1.tag = 1001;
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(150, 200, 200, 200)];
    view2.backgroundColor = [UIColor brownColor];
    view2.tag = 1002;
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectUnion(view1.frame, view2.frame)];
    view3.backgroundColor = [UIColor yellowColor];
    view3.tag = 1003;
    [self.view insertSubview:view3 atIndex:0];
    
    UIView *view4 = [UIView new];
    view4.size = CGSizeMake(100, 100);
    view4.origin = CGPointMake(10, view3.bottom + 20);
    view4.backgroundColor = [UIColor purpleColor];
    view4.tag = 1004;
    [self.view addSubview:view4];
    
    if (CGRectIntersectsRect(view3.frame, view2.frame)) {
        NSLog(@"YES~~~");
    } else {
        NSLog(@"NO~~~");
    }
    
    NSArray *viewsArray = @[view1, view2, view3, view4];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return CGRectIntersectsRect(view3.frame, [evaluatedObject frame]);
    }];
    NSArray *newArray = [viewsArray filteredArrayUsingPredicate:predicate];
    NSLog(@"newArray - %@", newArray);
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectOffset(view2.frame, 50, 150)];
    view5.backgroundColor = [UIColor redColor];
    view5.tag = 1005;
    [self.view addSubview:view5];
    
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectIntersection(view3.frame, view5.frame)];
    view6.backgroundColor = [UIColor greenColor];
    view6.tag = 1006;
    [self.view addSubview:view6];
}

@end
