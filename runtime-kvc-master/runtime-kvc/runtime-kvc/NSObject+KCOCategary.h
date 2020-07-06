//
//  NSObject+KCOCategary.h
//  runtime-kvc
//
//  Created by 高召葛 on 2019/5/14.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KCOCategary)

- (void) setMyValue:(id) value forKey:(NSString*) key;
- (id) myGetValueForKey:(NSString*) key;

@end

NS_ASSUME_NONNULL_END
