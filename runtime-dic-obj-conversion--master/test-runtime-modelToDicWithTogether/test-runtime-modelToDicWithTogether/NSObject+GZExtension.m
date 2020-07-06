//
//  NSObject+GZExtension.m
//  test-runtime-modelToDicWithTogether
//
//  Created by 高召葛 on 2019/5/13.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "NSObject+GZExtension.h"

@implementation NSObject (GZExtension)

/*将字典转化为模型 单层嵌套*/
+ (instancetype) modelFromSingleLayerJSON:(NSDictionary*) dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) return NULL;
    id objc = class_createInstance([self class], 0);
    
    unsigned int ivarCount;
    Ivar * ivarList =  class_copyIvarList([self class], &ivarCount); 
    for (int i =0; i<ivarCount; ++i) {
        Ivar ivar = ivarList[i];
        NSString * ivarName  = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString * key = [ivarName substringFromIndex:[ivarName rangeOfString:@"_"].location+1];
        NSString *value = [dic valueForKey:key];
        if ([value isKindOfClass:[NSNull class]]) continue;
        [objc setValue:value forKey:key];
    }
    return  objc;
    
}

/*将字典转化为模型 多层嵌套*/
+ (instancetype) modelFromMutilLayerJSON:(NSDictionary*) dic{
    if (![dic isKindOfClass:[NSDictionary class]]) return NULL;
    id objc = class_createInstance([self class], 0);
    unsigned int ivarCount;
    Ivar * ivarList =  class_copyIvarList([self class], &ivarCount);
    for (int i =0; i<ivarCount; ++i) {
        Ivar ivar = ivarList[i];
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        NSString * ivarName  = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString * key = [ivarName substringFromIndex:[ivarName rangeOfString:@"_"].location+1];
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSNull class]]) continue;
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class modelClass= NSClassFromString(ivarType);
            if (modelClass) {
               value = [modelClass modelFromMutilLayerJSON:value];
            }
        }
        if ([value isKindOfClass:[NSArray class]]) {
            if ([self respondsToSelector:@selector(getCLassWithPropertyName:)]) {
                NSString *type =  [[self getCLassWithPropertyName:@""] valueForKey:key];
                if (type) {
                    Class classModel = NSClassFromString(type);
                    NSMutableArray *arrM = [NSMutableArray array];
                    for (id dict in value) {
                        id model =  [classModel modelFromMutilLayerJSON:dict];
                        if (model) {
                            [arrM addObject:model];
                        } else {
                            [arrM addObject:dict];
                        }
                    }
                    value = arrM;
                }
            }
        }
    
        if (value){
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

/*将对象转化为JSON 单层嵌套*/
- (NSDictionary *)JSONFormSingleLayerModel{
    id objParater = self;
    NSMutableDictionary * objDic = [[NSMutableDictionary alloc] init];
    unsigned int outCount;
    objc_property_t *propertyList = class_copyPropertyList([objParater class], &outCount);
    for (int i =0; i<outCount; ++i) {
        objc_property_t property_t =propertyList[i];
        NSString * key = [NSString stringWithUTF8String:property_getName(property_t)];
        id value =  [objParater valueForKey:key];
        if ([value isKindOfClass:[NSNull class]])  continue;
        [objDic setValue:value forKey:key];
    }
    return objDic;
}

/*将对象转化为JSON 多层嵌套*/
- (NSDictionary *)JSONFormMutilLayerModel{
    id objParater = self;
    NSMutableDictionary * objDic = [[NSMutableDictionary alloc] init];
    unsigned int outCount;
    objc_property_t *propertyList = class_copyPropertyList([objParater class], &outCount);
    for (int i =0; i<outCount; ++i) {
        objc_property_t property_t =propertyList[i];
        NSString * key = [NSString stringWithUTF8String:property_getName(property_t)];
        id value =  [objParater valueForKey:key];
        if ([value isKindOfClass:[NSNull class]])  continue;
        NSString * classType = NSStringFromClass([value class]);
        // 继承于NSObject的类都会有这几个在NSObject中的属性
        if ([classType isEqualToString:@"description"]
            || [classType isEqualToString:@"debugDescription"]
            || [classType isEqualToString:@"hash"]
            || [classType isEqualToString:@"superclass"]) {
            continue;
        }
        if ([value isKindOfClass:[NSString class]]
            || [value isKindOfClass:[NSNumber class]]) {
            // 普通类型的直接变成字典的值
            [objDic setObject:value forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]]
                 || [value isKindOfClass:[NSDictionary class]]) {
            // 数组类型或字典类型
            [objDic setObject:[self idFromObject:value] forKey:key];
        }else{
            // 如果当前对象该值为空，设为nil。在字典中直接加nil会抛异常，需要加NSNull对象
            [objDic setObject:[NSNull null] forKey:key];
        }
        
        
        [objDic setValue:value forKey:key];
    }
    return objDic;
}

- (id)idFromObject:(nonnull id)object
{
    if ([object isKindOfClass:[NSArray class]]) {
        if (object != nil && [object count] > 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (id obj in object) {
                // 基本类型直接添加
                if ([obj isKindOfClass:[NSString class]]
                    || [obj isKindOfClass:[NSNumber class]]) {
                    [array addObject:obj];
                }
                // 字典或数组需递归处理
                else if ([obj isKindOfClass:[NSDictionary class]]
                         || [obj isKindOfClass:[NSArray class]]) {
                    [array addObject:[self idFromObject:obj]];
                }
                // model转化为字典
                else {
                    [array addObject:[obj JSONFormMutilLayerModel]];
                }
            }
            return array;
        }
        else {
            return object ? : [NSNull null];
        }
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        if (object && [[object allKeys] count] > 0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (NSString *key in [object allKeys]) {
                // 基本类型直接添加
                if ([object[key] isKindOfClass:[NSNumber class]]
                    || [object[key] isKindOfClass:[NSString class]]) {
                    [dic setObject:object[key] forKey:key];
                }
                // 字典或数组需递归处理
                else if ([object[key] isKindOfClass:[NSArray class]]
                         || [object[key] isKindOfClass:[NSDictionary class]]) {
                    [dic setObject:[self idFromObject:object[key]] forKey:key];
                }
                // model转化为字典
                else {
                    [dic setObject:[object[key] JSONFormMutilLayerModel] forKey:key];
                }
            }
            return dic;
        }
        else {
            return object ? : [NSNull null];
        }
    }
    
    return [NSNull null];
}


/*如果没有找到对应的value*/
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{};
}

/*获取key对应的数据类型*/
+ (NSDictionary*) getCLassWithPropertyName:(NSString*) key{
    return @{};
}

@end
