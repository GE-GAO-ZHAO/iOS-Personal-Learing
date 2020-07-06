

//
//  NSObject+KCOCategary.m
//  runtime-kvc
//
//  Created by 高召葛 on 2019/5/14.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "NSObject+KCOCategary.h"

@implementation NSObject (KCOCategary)

- (void) setMyValue:(id) value forKey:(NSString*) key{
    // 1. 判断key是否有值
    // 2. 判断value 是否继承与NSObject
    // 3. 通过对应的setter 方法进行查找
    // 4. 查看当前的类的成员变量是否存在对应的 _key 变量
    // 5. 看当前的类的成员变量是否存在对应的 key 变量
    if (key.length ==0 && [key isKindOfClass:[NSNull class]]) return;
    if (![value isKindOfClass:[NSObject class]]) return;
    NSString * setterfucString = [NSString stringWithFormat:@"%@%@",@"set",[key capitalizedString]]; //setStr
    // 1. 对应的setter 方法是否存在
    if ([self respondsToSelector:NSSelectorFromString(setterfucString)]) {
        [self performSelector:NSSelectorFromString(setterfucString) withObject:value];
        return;
    }
    // 2. 对应的 _key、key是否存在
    unsigned int outCount;
    BOOL flag = false;
    Ivar * ivarList = class_copyIvarList([self class], &outCount);
    for (int i=0; i<outCount; ++i) {
        Ivar ivar = ivarList[i];
        NSString * keyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]){
            flag = true;
            object_setIvar(self, ivar, value);
            break;
        }
        if([keyName isEqualToString:key]){
            flag = true;
            object_setIvar(self, ivar, value);
            break;
        }
    }
    // 3. 如果都没有找到就设置对应的    [self setValue:[NSNull class] forUndefinedKey:key];
    if (!flag) {
        [self setValue:[NSNull class] forUndefinedKey:key];
    }


}
- (id) myGetValueForKey:(NSString*) key{
    // 1. 判断key是否有值
    if (key.length ==0 && [key isKindOfClass:[NSNull class]]) return [NSNull class];
    // 1. 对应的getter 方法是否存在
    if ([self respondsToSelector:NSSelectorFromString(key)]) {
        return [self performSelector:NSSelectorFromString(key)];
    }
    
    // 2. 对应的 _key、key是否存在
    unsigned int outCount;
    BOOL flag = false;
    Ivar * ivarList = class_copyIvarList([self class], &outCount);
    for (int i=0; i<outCount; ++i) {
        Ivar ivar = ivarList[i];
        NSString * keyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]){
            flag = true;
            return object_getIvar(self, ivar);
        }
        if([keyName isEqualToString:key]){
            flag = true;
             return object_getIvar(self, ivar);
        }
    }
    // 3. 如果都没有找到就设置对应的    [self setValue:[NSNull class] forUndefinedKey:key];
    if (!flag) {
        [self valueForUndefinedKey:key];//需要自己实现myValueForUndefinedKey
    }

    
    return [NSNull new];
}
@end
