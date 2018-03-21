//
//  Util.h
//  LocalCache
//  Module : LocalCache
//  Created by caiqian_3 on 13-2-6.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Util : NSObject
+(NSString *)getCurrentLangue;

+(NSTimeInterval)getSecTimeIntervalSinceNow:(NSDate *)date;

+ (NSString *)createUUIDWithTransType:(TransactionType)type;

+ (NSString *)packPassword:(NSString *)password;

+ (NSDictionary *)getSignResult:(NSString *)signString;


/**
获取数量显示string
 
 @param number 数量
 @param precision 精度
 @param limitLength 限制长度
 @param showLastZero 末尾是否补0
 @param showKValue 是否缩写成1.23k
 */

+(NSString *)getShowStringWithNumber:(NSDecimalNumber *)number
                           precision:(NSInteger)precision
                         limitLength:(NSInteger)limitLength
                        showLastZero:(BOOL)showLastZero
                          showKValue:(BOOL)showKValue
                        roundingMode:(NSRoundingMode)roundMode;



+ (BOOL)isIpv6:(NSString **)hostName;

+ (NSDictionary *)getIPAddresses;


/**
 根据服务器返回的加密货币数量获得加密货币具体显示数值
 
 @param precision 货币类型
 @param originNum 从服务器获取的原始数值转换为的数值类型

 @return 经过处理之后的数值
 */

+ (NSDecimalNumber *)getCurrencyShowNumWithPrecision:(NSInteger)precision
                                           originNum:(NSDecimalNumber *)originNum
                                        roundingMode:(NSRoundingMode)roundMode;


/**
 输入的地址是否是系统货币的格式

 @param sysCoinAddress 输入的地址
 @return YES 合法 NO 非法
 */
+ (BOOL)isSysCoinAddrValid:(NSString *)sysCoinAddress;

+ (UIImage *)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth;

/**
 根据数值和精确度计算出处理后的结果

 @param precision 精确度
 @param value 数值
 @return 处理后的结果
 */
+ (NSDecimalNumber *)getValueByPrecision:(NSInteger)precision value:(NSDecimalNumber *)value;

/**
 文本框自适应宽度
 
 @param str 文本内容
 @param textFont 文本字体大小
 @return 文本宽度
 */
+ (CGFloat)widthForString:(NSString *)str Font:(UIFont *)textFont;

/**
 字符串转16进制
 
 @param str 文本内容
 @return 16进制输出
 */
+ (NSString *)convertStringToHexStr:(NSString *)str;

@end

