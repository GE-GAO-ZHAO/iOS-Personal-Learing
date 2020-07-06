//
//  NSObject+GgzKvo.h
//  test-kvo-runtime
//
//  Created by 高召葛 on 2019/5/1.
//  Copyright © 2019年 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ggzNSKVONitifingBlock) (NSObject * observer,NSString * keyPath,id oldValue,id newValue);

typedef NS_OPTIONS(NSUInteger, ggzKeyValueObservingOptions) {
    ggzKeyValueObservingOptionNew = 0x01,
    ggzKeyValueObservingOptionOld = 0x02,
    ggzKeyValueObservingOptionInitial API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0)) = 0x04,
    ggzKeyValueObservingOptionPrior API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0)) = 0x08
};


@interface NSObject (GgzKvo)


- (void)ggz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(ggzKeyValueObservingOptions)options block:(ggzNSKVONitifingBlock) block;


- (void)ggzObserveValueForKeyPath:(NSString *)keyPath target:(id) target  oldValue:(id) oldValue newValue:(id)newValue;

@end

NS_ASSUME_NONNULL_END
