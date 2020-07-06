//
//  NSObject+GZExtension.h
//  test-runtime-modelToDicWithTogether
//
//  Created by 高召葛 on 2019/5/13.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GZExtension)

/*将字典转化为模型 单层嵌套*/
+ (instancetype) modelFromSingleLayerJSON:(NSDictionary*) dic;

/*将字典转化为模型 多层嵌套*/
+ (instancetype) modelFromMutilLayerJSON:(NSDictionary*) dic;

/*如果没有找到对应的value 重写NSObject+DictionaryToModel分类中的映射方法*/
+ (NSDictionary *)modelCustomPropertyMapper;

/*将对象转化为JSON 单层嵌套*/
- (NSDictionary *)JSONFormSingleLayerModel;

/*将对象转化为JSON 多层嵌套*/
- (NSDictionary *)JSONFormMutilLayerModel;

/*获取key对应的数据类型*/
+ (NSDictionary*) getCLassWithPropertyName:(NSString*) key;

@end

NS_ASSUME_NONNULL_END
