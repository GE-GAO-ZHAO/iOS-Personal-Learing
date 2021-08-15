//
//  Test.m
//  notification_test
//
//  Created by 葛高召 on 2021/8/11.
//

#import "Test.h"

@implementation Test

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [self removeNotify:nil];
}

- (void)setup {
    [self registerNotify:nil];
}

// 注册几次就收到几次通知
// 属于系统的bug
- (void)registerNotify:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aa) name:@"xxx" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aa) name:@"xxx" object:nil];
}


- (void)aa {
    NSLog(@"\n收到通知，哈哈\n");
}

//多次移除没有影响
- (void)removeNotify:(id)sender {
    NSLog(@"\n移除通知，哈哈\n");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"xxx" object:nil];
}


@end
