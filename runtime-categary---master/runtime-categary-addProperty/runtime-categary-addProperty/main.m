//
//  main.m
//  runtime-categary-addProperty
//
//  Created by 高召葛 on 2019/5/14.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"
#import "Test+GZCategary.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Test * testObj = [[Test alloc] init];
        testObj.str = @"我是一个通过分类添加的属性";
        NSLog(@"str: %@",testObj.str);
    }
    return 0;
}
