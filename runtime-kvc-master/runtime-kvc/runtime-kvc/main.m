//
//  main.m
//  runtime-kvc
//
//  Created by 高召葛 on 2019/5/14.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"
#import "NSObject+KCOCategary.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Test *obj = [[Test alloc] init];
        [obj setMyValue:@"我是kvc的值" forKey:@"str"];
        NSLog(@"str:%@",[obj valueForKey:@"str"]);
    }
    return 0;
}
