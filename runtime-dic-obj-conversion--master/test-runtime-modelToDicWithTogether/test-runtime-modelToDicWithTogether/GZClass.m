//
//  GZClass.m
//  test-runtime-modelToDicWithTogether
//
//  Created by 高召葛 on 2019/5/13.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "GZClass.h"

@implementation GZClass
+ (NSDictionary *)modelCustomPropertyMapperWithKey:(NSString*) key{
    return @{};
}

+ (NSDictionary*) getCLassWithPropertyName:(NSString*) key{
//    unsigned int outCount;
//    objc_property_t *list = class_copyPropertyList([self class],&outCount);
//    for (int i =0; i<outCount; ++i) {
//        objc_property_t propertyObj = list[i];
//        NSString * propertyName = [NSString stringWithUTF8String:property_getName(propertyObj)];
//        NSLog(@"propertyName :%@ ----> class:%@",propertyName,NSClassFromString(propertyName));
//    }
    return @{@"stuArr":@"Student",@"stu":@"Student"};
}
@end
