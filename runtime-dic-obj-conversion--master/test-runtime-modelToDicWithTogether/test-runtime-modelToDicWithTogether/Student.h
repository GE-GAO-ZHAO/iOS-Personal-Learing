//
//  Student.h
//  test-runtime-modelToDicWithTogether
//
//  Created by 高召葛 on 2019/5/13.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChildClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
@property (strong,nonatomic) ChildClass *professionInfo;
@property (copy,nonatomic) NSString *name;
@property (assign,nonatomic) int age;
@property (copy,nonatomic) NSString *sex;
@end

NS_ASSUME_NONNULL_END
