//
//  ViewController.m
//  TestCALayer
//
//  Created by 葛高召 on 2021/8/17.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 基本常识：
 UIView 的 bounds 和 frame 和CALayer的 bounds 和 frame 一一对应
 UIView 的 center 和 CALayer 的 positon 对应 都是相对父视图中心点的位置坐标
 CALayer 锚点 anchorPoint  相对于x、y位置比例而言的默认在图像中心点（0.5、0.5）的位置, 以自己的左上角为原点,取值范围在（0-1）
 
 考点1: center改变
 UIView、CALayer positon、frame变化 ， anchoPoint、bounds 不会变化
 
 考点2: 改变CALayer的 position
 UIView 、CALayer的anchoPoint、bounds 不会变化，其他都会变化
 
 考点3: 改变CALayer的anchorPoint
 除了uiview、calayer的 center、position、bounds不改变，其他都变
 
 考点4: 改变UIView的bounds
 除了uiview、calayer的  anchorPoint、center、position不改变，其他都变
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, [UIScreen mainScreen].bounds.size.height / 2 - 50, 100, 100)];
    [self.view addSubview:view1];
    NSLog(@"view1.frame:%@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1.bounds:%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"view1.center:%@",NSStringFromCGPoint(view1.center));
    [NSInvocation alloc];
    NSLog(@"view1.layer.position:%@",NSStringFromCGPoint(view1.layer.position));
    NSLog(@"view1.layer.anchorPoint:%@",NSStringFromCGPoint(view1.layer.anchorPoint));
    
    NSLog(@"view1.layer.frame:%@",NSStringFromCGRect(view1.layer.frame));
    NSLog(@"view1.layer.bounds:%@",NSStringFromCGRect(view1.layer.bounds));
    
    view1.center = CGPointMake(200, 200);
    NSLog(@"view1.center变化为:%@",NSStringFromCGPoint(view1.center));
    NSLog(@"view1.frame:%@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1.bounds:%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"view1.layer.position:%@",NSStringFromCGPoint(view1.layer.position));
    NSLog(@"view1.layer.anchorPoint:%@",NSStringFromCGPoint(view1.layer.anchorPoint));
    NSLog(@"view1.layer.frame:%@",NSStringFromCGRect(view1.layer.frame));
    NSLog(@"view1.layer.bounds:%@",NSStringFromCGRect(view1.layer.bounds));
    
    
    view1.layer.position = CGPointMake(300, 300);
    NSLog(@"view1.layer.position:变化为:%@",NSStringFromCGPoint(view1.center));
    NSLog(@"view1.center变化为:%@",NSStringFromCGPoint(view1.center));
    NSLog(@"view1.frame:%@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1.bounds:%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"view1.layer.anchorPoint:%@",NSStringFromCGPoint(view1.layer.anchorPoint));
    NSLog(@"view1.layer.frame:%@",NSStringFromCGRect(view1.layer.frame));
    NSLog(@"view1.layer.bounds:%@",NSStringFromCGRect(view1.layer.bounds));
    
    
    view1.layer.anchorPoint = CGPointMake(0.3, 0.3);
    NSLog(@"view1.layer.anchorPoint改变后:%@",NSStringFromCGPoint(view1.layer.anchorPoint));
    NSLog(@"view1.frame:%@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1.bounds:%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"view1.center:%@",NSStringFromCGPoint(view1.center));
    NSLog(@"view1.layer.position:%@",NSStringFromCGPoint(view1.layer.position));
    NSLog(@"view1.layer.frame:%@",NSStringFromCGRect(view1.layer.frame));
    NSLog(@"view1.layer.bounds:%@",NSStringFromCGRect(view1.layer.bounds));
    
    view1.bounds = CGRectMake(10, 10, 60, 60);
    NSLog(@"view1.layer.bounds改变后:%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"view1.layer.anchorPoint:%@",NSStringFromCGPoint(view1.layer.anchorPoint));
    NSLog(@"view1.frame:%@",NSStringFromCGRect(view1.frame));
    NSLog(@"view1.bounds:%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"view1.center:%@",NSStringFromCGPoint(view1.center));
    NSLog(@"view1.layer.position:%@",NSStringFromCGPoint(view1.layer.position));
    NSLog(@"view1.layer.frame:%@",NSStringFromCGRect(view1.layer.frame));
    NSLog(@"view1.layer.bounds:%@",NSStringFromCGRect(view1.layer.bounds));
}


@end
