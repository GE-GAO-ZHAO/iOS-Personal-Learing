//
//  Test+GZCategary.h
//  runtime-categary-addProperty
//
//  Created by 高召葛 on 2019/5/14.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "Test.h"
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN


@interface Test (GZCategary)
@property (copy,nonatomic) NSString * str;

@end

NS_ASSUME_NONNULL_END
