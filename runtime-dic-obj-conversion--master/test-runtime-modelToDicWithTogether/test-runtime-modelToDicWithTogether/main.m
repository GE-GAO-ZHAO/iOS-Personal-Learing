//
//  main.m
//  test-runtime-modelToDicWithTogether
//
//  Created by 高召葛 on 2019/5/13.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "NSObject+GZExtension.h"
#import "GZClass.h"
#import "SingleClass.h"
#import "GZZZClass.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
//        /***********单层嵌套字典转换为模型**************/
//        NSDictionary * dic =@{@"professionInfo":@{
//                                      @"profession":@"工程师",
//                                      @"salary":@6666
//                                      },
//                              @"name":@"小猪",@"age":@22,@"sex":@"男"};
//        Student * stu = [Student modelFromSingleLayerJSON:dic];
        
        
        
//        /***********多层、包括基本、数组、字典类型 嵌套字典转换为模型 **************/
//        NSDictionary * dic =@{@"professionInfo":@{
//                                      @"profession":@"工程师",
//                                      @"salary":@6666
//                                      },
//                              @"name":@"小猪",@"age":@22,@"sex":@"男"};
//        Student * stu = [Student modelFromSingleLayerJSON:dic];
//        NSDictionary * dic2 = @{@"stu":stu,
//                                @"stuArr":@[stu,stu,@"whatever"],
//                                @"title":@"小香猪",
//                                @"detail":@"一个可爱的猪宝宝"
//                                };
//        GZClass * gzObj = [GZClass modelFromMutilLayerJSON:dic2];
//
//        NSLog(@"%@",gzObj);
        
        
        
         /***********模型转json 单层嵌套**************/
//        SingleClass * singleObj = [[SingleClass alloc] init];
//        singleObj.name = @"小香猪";
//        singleObj.age = 22;
//        singleObj.sex = @"女";
//        NSDictionary * dic = [singleObj JSONFormSingleLayerModel];
//        NSLog(@"%@",dic);
        
        
        /***********模型转json 多层嵌套 -- 2 都是iOS系统自带数据类型解析**************/
//        GZZZClass * gzobj = [[GZZZClass alloc] init];
//        NSDictionary * dic = @{@"name":@"小猪",@"age":@22,@"sex":@"男"};
//        NSArray * arr = @[@1,@2,@3,@4,@5,@6];
//        gzobj.arr =arr;
//        gzobj.dic = dic;
//        NSDictionary * dicres = [gzobj JSONFormMutilLayerModel];
//        NSLog(@"%@",dicres);
        
        
        /***********模型转json 多层嵌套 -- 1 包含自定义对象**************/
                NSDictionary * dic =@{@"professionInfo":@{
                                              @"profession":@"工程师",
                                              @"salary":@6666
                                              },
                                      @"name":@"小猪",@"age":@22,@"sex":@"男"};
                Student * stu = [Student modelFromMutilLayerJSON:dic];
        
                GZClass * gzObj = [[GZClass alloc] init];
                gzObj.stu = stu;
                gzObj.title = @"学生名单";
                gzObj.detail = @"我是一个小学生";
                NSDictionary * dicObj2 =  [gzObj  JSONFormMutilLayerModel];
    }
    return 0;
}
