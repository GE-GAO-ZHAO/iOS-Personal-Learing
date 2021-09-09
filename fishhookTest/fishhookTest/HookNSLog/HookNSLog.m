//
//  HookNSLog.m
//  fishhookTest
//
//  Created by 葛高召 on 2021/8/22.
//

#import "HookNSLog.h"
#import "fishhook.h"
@implementation HookNSLog

static void (*old_nslog)(NSString *format, ...);

+ (void)hook {
    struct rebinding nslog_rebinding;
    nslog_rebinding.name = "NSLog";
    nslog_rebinding.replacement = new_nslog;
    nslog_rebinding.replaced = (void*)&old_nslog;
    struct rebinding rebinds[] = {nslog_rebinding};
    rebind_symbols(rebinds, 1);
}

void new_nslog(NSString *format, ...)
{
    va_list va;
    va_start(va, format);
    format = [format stringByAppendingFormat:@" hook"];
    old_nslog(format,va);
    va_end(va);
}

+ (void)startHook {
    [HookNSLog hook];
}

@end
