//
//  GZClass.h
//  test-runtime-modelToDicWithTogether
//
//  Created by 高召葛 on 2019/5/13.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "NSObject+GZExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface GZClass : NSObject
@property (strong,nonatomic) Student *stu;
@property (strong,nonatomic) NSArray *stuArr;
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * detail;
@end

NS_ASSUME_NONNULL_END
