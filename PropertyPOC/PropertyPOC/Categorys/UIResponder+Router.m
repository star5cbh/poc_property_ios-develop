/************************************************************
 //  Zebra
 //
 //  Created by STAR on 15/5/7.
 //  Copyright (c) 2015年 peersafe. All rights reserved.
 //  */

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
