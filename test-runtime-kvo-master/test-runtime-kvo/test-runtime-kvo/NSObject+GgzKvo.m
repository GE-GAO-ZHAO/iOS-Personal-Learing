//
//  NSObject+GgzKvo.m
//  test-kvo-runtime
//
//  Created by 高召葛 on 2019/5/1.
//  Copyright © 2019年 高召葛. All rights reserved.
//

#import "NSObject+GgzKvo.h"
#import <objc/runtime.h>
#import <objc/message.h>
NSString * GGZKVOAssociatedObservers = @"GGZKVOAssociatedObservers";
NSString *kPrefixOfYBKVO = @"kPrefixOfYBKVO_";

@interface GGZNSKVONitifingInfo : NSObject
@property(strong,nonatomic)NSObject *observer;
@property(copy,nonatomic) NSString * keyPath;
@property(copy,nonatomic) ggzNSKVONitifingBlock block;
@property (nonatomic, assign) ggzKeyValueObservingOptions options;

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key options:(ggzKeyValueObservingOptions)options block:(ggzNSKVONitifingBlock)block;
@end

@implementation GGZNSKVONitifingInfo
- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key options:(ggzKeyValueObservingOptions)options block:(ggzNSKVONitifingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _keyPath = key;
        _block = block;
    }
    return self;
}
@end

@implementation NSObject (GgzKvo)
    
- (void)ggz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(ggzKeyValueObservingOptions)options block:(ggzNSKVONitifingBlock) block{
    if (!observer || keyPath.length ==0 ) return;
    @synchronized (self) {
        NSArray * keys = [keyPath componentsSeparatedByString:@"."];
        if (keys.count == 0) return;
        id nextTarget = self;
        for (int i = 0; i < keys.count-1; i++) {
            // 使用kvc 通过字符串间接获取一个对象的属性
            nextTarget = [nextTarget valueForKey:keys[i]];
        }
        // 获取对应的setter
        NSString * getterMethodName = keys.lastObject;
        NSString * setterMethodName = setterNameFromGetterName(getterMethodName);
        SEL setterSel = NSSelectorFromString(setterMethodName);
        Method setterMethod = class_getInstanceMethod(object_getClass(nextTarget), setterSel);

        // 生成派生类
        createSubClassWith(nextTarget, setterMethod, setterSel);

        // 设置监控对象的关联对象
        GGZNSKVONitifingInfo * info = [[GGZNSKVONitifingInfo alloc] initWithObserver:observer Key:keyPath options:ggzKeyValueObservingOptionNew block:block];
        NSMutableDictionary * observersDic = objc_getAssociatedObject([nextTarget class],&GGZKVOAssociatedObservers);
        if(!observersDic){
            observersDic = [NSMutableDictionary dictionary];
            NSMutableArray * arrObservers = [NSMutableArray array];
            [arrObservers addObject:info];
            [observersDic setObject:arrObservers forKey:getterMethodName];
            objc_setAssociatedObject(nextTarget, &GGZKVOAssociatedObservers, observersDic, OBJC_ASSOCIATION_RETAIN);
        }else{
            if ([observersDic valueForKey:keyPath]) {
                NSMutableArray *tempArr = [observersDic valueForKey:getterMethodName];
                [tempArr addObject:info];
            } else {
                NSMutableArray *tempArr = [NSMutableArray array];
                [tempArr addObject:info];
                [observersDic setObject:tempArr forKey:getterMethodName];
            }
        }
    }
}

/*
 * 创建派生类
 */
static void createSubClassWith(id nextTarget,Method setterMethod,SEL setterSel){
    
    // 1. 创建派生类并且更改 isa 指针
    Class nowClass = object_getClass(nextTarget);
    NSString *originClass_name = NSStringFromClass(nowClass);
    NSString *nowClass_name = NSStringFromClass(nowClass);
    
    // 2. 查看isa 指向是否已经是派生类
    if ([[nowClass_name stringByReplacingOccurrencesOfString:originClass_name withString:@""] isEqualToString:kPrefixOfYBKVO]){
        return;
    }
    
    // 3. 查看派生类是否已经存在 存在就是直接进行isa赋值 不存在就进行创建 然后进行isa赋值
    NSString *subClass_name = [kPrefixOfYBKVO stringByAppendingString:originClass_name];
    Class subClass = NSClassFromString(subClass_name);
    if (subClass) {
        object_setClass(nextTarget, subClass);
        return;
    }
    
    // 4. 创建派生类
    subClass = objc_allocateClassPair(nowClass, subClass_name.UTF8String, 0);
    const char *types = method_getTypeEncoding(class_getInstanceMethod(nowClass, @selector(class)));
    IMP class_imp = imp_implementationWithBlock(^Class(id target){
        return class_getSuperclass(object_getClass(target));
    });
    class_addMethod(subClass, @selector(class), class_imp, types);
    objc_registerClassPair(subClass);
    object_setClass(nextTarget, subClass);
    
    
    // 5. 给添加setter方法
    if(!classHasSel(object_getClass(nextTarget), setterSel) ){
        const char * tyep =  method_getTypeEncoding(setterMethod);
        IMP setterIMP =  (IMP)set_KvoMethod;
        class_addMethod(object_getClass(nextTarget) ,setterSel, setterIMP, tyep);
    }


}

static bool classHasSel(Class class, SEL sel) {
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(class, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        SEL mSel = method_getName(method);
        if (mSel == sel) {
            free(methods);
            return true;
        }
    }
    free(methods);
    return false;
}


static void set_KvoMethod(id target, SEL sel, id newValue){
  @synchronized (target) {
    NSString * setterString = NSStringFromSelector(sel);
    NSString * getterString = getterNameFromSetterName(setterString);
    NSString * oldValue = [target valueForKey:getterString];
    
    //通知taget的父类更改值
    struct objc_super sup = {
        .receiver = target,
        .super_class = class_getSuperclass(object_getClass(target))
    };
    ((void(*)(struct objc_super *, SEL, id)) objc_msgSendSuper)(&sup, sel, newValue);
    
    // 通知h关心 getterString属性的类
    NSMutableDictionary * observerDic = objc_getAssociatedObject(target, &GGZKVOAssociatedObservers);
    if (observerDic && [observerDic valueForKey:getterString]) {
        NSMutableArray * observerArr = [observerDic valueForKey:getterString];
        for (int i=0; i<observerArr.count; ++i) {
            GGZNSKVONitifingInfo * info = observerArr[i];
            
            //block 实现方式
//            if (info.block) {
//                info.block(target, getterString, oldValue, newValue);
//            }
            
            // 回调方法
            if(info.observer && [info.observer respondsToSelector:@selector(ggzObserveValueForKeyPath:target:oldValue:newValue:)]){
                [info.observer ggzObserveValueForKeyPath:getterString target:target oldValue:oldValue newValue:newValue];
            }
        }
    }
  }

}

static NSString * setterNameFromGetterName(NSString *getterName) {
    if (getterName.length < 1) return nil;
    NSString *setterName;
    setterName = [getterName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[getterName substringToIndex:1] uppercaseString]];
    setterName = [NSString stringWithFormat:@"set%@:", setterName];
    return setterName;
}
static NSString * getterNameFromSetterName(NSString *setterName) {
    if (setterName.length < 1 || ![setterName hasPrefix:@"set"] || ![setterName hasSuffix:@":"]) return nil;
    NSString *getterName;
    getterName = [setterName substringWithRange:NSMakeRange(3, setterName.length-4)];
    getterName = [getterName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[getterName substringToIndex:1] lowercaseString]];
    return getterName;
}


static void callBack(){


}



@end
