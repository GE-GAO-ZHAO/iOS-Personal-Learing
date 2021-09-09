//
//  Hook_Objc_msgSend.h
//  fishhookTest
//
//  Created by 葛高召 on 2021/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hook_Objc_msgSend : NSObject
+ (void)startHook;
@end

NS_ASSUME_NONNULL_END
