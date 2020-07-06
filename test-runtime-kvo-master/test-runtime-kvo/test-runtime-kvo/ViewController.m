//
//  ViewController.m
//  test-runtime-kvo
//
//  Created by 高召葛 on 2019/5/3.
//  Copyright © 2019年 高召葛. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+GgzKvo.h"
@interface ViewController ()
@end

@implementation ViewController
//@synthesize testObj = _testObj;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testObj = [[Test alloc] init];
    
     // 监听当前类的属性的属性 通过block 回调
    [self ggz_addObserver:self forKeyPath:@"testObj.name" options:ggzKeyValueObservingOptionNew block:^(NSObject * _Nonnull observer, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
        NSLog(@"ggz_addObserver block 监听收到%@ \t变化啦 oldValue:%@ \t newValue:%@",keyPath,oldValue,newValue);
    }];
    self.testObj.name = @"fffff值";
    
    // 监听当前类的属性 通过 function 回调
//    [self ggz_addObserver:self forKeyPath:@"name" options:ggzKeyValueObservingOptionNew block:^(NSObject * _Nonnull observer, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
//        NSLog(@"ggz_addObserver block 监听收到%@ \t变化啦 oldValue:%@ \t newValue:%@",keyPath,oldValue,newValue);
//    }];
//    self.name = @"fffff值";
}


- (void)ggzObserveValueForKeyPath:(NSString *)keyPath target:(id) target  oldValue:(id) oldValue newValue:(id)newValue{
    
    NSLog(@"ggz_addObserver function 监听收到%@ \t变化啦 oldValue:%@ \t newValue:%@",keyPath,oldValue,newValue);

}

@end
