//
//  UncaughtExceptionHandler.h
//  ZXWallet
//
//  Created by 陈宝辉 on 2017/12/22.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject
+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler*)getHandler;  
@end
