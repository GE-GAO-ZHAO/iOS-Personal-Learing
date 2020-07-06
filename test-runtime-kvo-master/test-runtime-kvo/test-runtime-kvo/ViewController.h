//
//  ViewController.h
//  test-runtime-kvo
//
//  Created by 高召葛 on 2019/5/3.
//  Copyright © 2019年 高召葛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"
@interface ViewController : UIViewController
@property(strong,nonatomic) Test * testObj;
@property(copy,nonatomic) NSString * name;

@end

