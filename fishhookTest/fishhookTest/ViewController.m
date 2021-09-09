//
//  ViewController.m
//  fishhookTest
//
//  Created by 葛高召 on 2021/8/22.
//

#import "ViewController.h"
#import "HookNSLog.h"
@interface ViewController ()

@end

@implementation ViewController
 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HookNSLog startHook];
}

- (IBAction)printBtnClicked:(id)sender {
    NSLog(@"屏幕点击事件");
}

@end
