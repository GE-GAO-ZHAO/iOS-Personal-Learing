//
//  Test+GZCategary.m
//  runtime-categary-addProperty
//
//  Created by 高召葛 on 2019/5/14.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "Test+GZCategary.h"
static const NSString * strKey = @"naaame";

@implementation Test (GZCategary)

- (NSString *)str{
    return objc_getAssociatedObject(self, &strKey);
}

- (void)setStr:(NSString *)str{
    objc_setAssociatedObject(self, &strKey, str, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
