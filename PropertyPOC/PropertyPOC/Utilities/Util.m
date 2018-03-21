
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#import "Util.h"
#import <CommonCrypto/CommonDigest.h>
#import <AudioToolbox/AudioToolbox.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "STDefine.h"
@implementation Util

+ (UIImage *)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 2、设置数据
    NSString *info = data;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageViewWidth];
}

/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+(NSTimeInterval)getSecTimeIntervalSinceNow:(NSDate *)date{
    return ([date timeIntervalSinceDate:[NSDate date]]);
}


+ (NSString *)createUUID{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSString stringWithFormat:@"%@", uuidStr];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

+ (NSString *)createUUIDWithTransType:(TransactionType)type{
    
    NSString *uuid = [self createUUID];
    NSString *typeStr = [NSString stringWithFormat:@"%@%lu",@"0000",(unsigned long)type];
    typeStr = [typeStr substringWithRange:NSMakeRange( typeStr.length -4, 4)];
    return [typeStr stringByAppendingString:uuid];
}


+ (NSString *)packPassword:(NSString *)password{
    NSInteger length = password.length;
    NSString *newPass = [NSString stringWithFormat:@"%ld|%@",(long)length,password];
    return newPass;
}


+ (NSDictionary *)getSignResult:(NSString *)signString{
    NSData *jsonData = [signString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}

+(NSString *)getShowStringWithNumber:(NSDecimalNumber *)number
                           precision:(NSInteger)precision
                         limitLength:(NSInteger)limitLength
                        showLastZero:(BOOL)showLastZero
                          showKValue:(BOOL)showKValue
                        roundingMode:(NSRoundingMode)roundMode{
    
    if (!number) {
        return @"--";
    }else if (showKValue && number.doubleValue > 1000) {
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundMode scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        NSDecimalNumber *decimalNumber = [[number decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"1000"]] decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
        NSRange point = [decimalNumber.stringValue rangeOfString:@"."];
        if (point.location == NSNotFound) {
            return  [NSString stringWithFormat:@"%@K",decimalNumber];
        }
        NSString *number;
        
        if (point.location > 3) {//小数位数多余宽度限制 截取掉小数
            number = [decimalNumber.stringValue substringToIndex:point.location];
        } else {
            if (decimalNumber.stringValue.length > 5) {
                number = [decimalNumber.stringValue substringToIndex:5];
                
            } else {
                number = decimalNumber.stringValue;
            }
        }
        return [NSString stringWithFormat:@"%@K",[NSDecimalNumber decimalNumberWithString:number]];
    } else {
        NSString *numString;

            NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundMode scale:precision raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
            NSDecimalNumber *decimalNumber = [number decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
            numString = decimalNumber.stringValue;
        NSRange point = [numString rangeOfString:@"."];
        if (showLastZero) {
            if (point.location == NSNotFound) {
                numString = [NSString stringWithFormat:@"%f",number.doubleValue];
                point = [numString rangeOfString:@"."];
            }
            if (limitLength == 0) {
                return numString;
            } else {
                if (point.location > limitLength - 2) {//整数部分长 小数位数多余宽度限制 截取掉小数
                    return [numString substringToIndex:point.location];
                } else {
                    if (numString.length > limitLength) {
                        return [numString substringToIndex:limitLength];
                        
                    } else if (numString.length < limitLength) {
                        NSInteger count = limitLength - numString.length;
                        for (int i = 0; i < count ; i++) {
                            numString = [numString stringByAppendingString:@"0"];
                        }
                        return numString;
                    } else {
                        return numString;
                    }
                }
            }
        } else {
            if (limitLength == 0 || point.location == NSNotFound) {
                return numString;
            } else {
                if (point.location > limitLength - 2) {//整数部分长 小数位数多余宽度限制 截取掉小数
                    return [numString substringToIndex:point.location];
                } else {
                    if (numString.length > limitLength) {
                        return [numString substringToIndex:limitLength];
                        
                    } else {
                        return numString;
                    }
                }
            }
        } 
    }
}


+(NSString *)getCurrentLangue{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    
    return preferredLang;
}

+ (BOOL)isDeviceLanguageRightToLeft {
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSLocaleLanguageDirection direction = [NSLocale characterDirectionForLanguage:[currentLocale objectForKey:NSLocaleLanguageCode]];
    return (direction == NSLocaleLanguageDirectionRightToLeft);
}

+ (BOOL)isIpv6:(NSString **)hostName {
    NSArray *searchArray =
    @[ IOS_VPN @"/" IP_ADDR_IPv6,
       IOS_VPN @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    DLog(@"addresses: %@", addresses);
    
    __block BOOL isIpv6 = NO;
    __block NSString *tempHostName = @"";
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop){
         
         DLog(@"---%@---%@---",key, addresses[key] );
         
         if ([key rangeOfString:@"ipv6"].length > 0  && ![[NSString stringWithFormat:@"%@",addresses[key]] hasPrefix:@"(null)"] ) {
             
             if ( ![addresses[key] hasPrefix:@"fe80"]) {
                 isIpv6 = YES;
                 tempHostName = addresses[key];
             }
         }
         
         if ([tempHostName length] == 0) {
             if(([key rangeOfString:@"en0"].length > 0 || [key rangeOfString:@"en1"].length > 0) &&
                [key rangeOfString:@"ipv4"].length > 0)
             {
                 tempHostName = addresses[key];
             }
         }
     } ];
    
    *hostName = tempHostName;
    return isIpv6;
}


+ (NSDictionary *)getIPAddresses{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                        
                        DLog(@"ipv4 %@",name);
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                        DLog(@"ipv6 %@",name);
                        
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSDecimalNumber *)getCurrencyShowNumWithPrecision:(NSInteger)precision
                                           originNum:(NSDecimalNumber *)originNum
                                        roundingMode:(NSRoundingMode)roundMode{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundMode scale:precision raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *decimalNumber = [originNum decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return decimalNumber;
}


/**
 输入的地址是否是系统货币的格式
 
 @param sysCoinAddress 输入的地址
 @return YES 合法 NO 非法
 */
+ (BOOL)isSysCoinAddrValid:(NSString *)sysCoinAddress {
    NSString *sysAddressFirstCharacter = [sysCoinAddress substringWithRange:NSMakeRange(0, 1)];
    if (![sysAddressFirstCharacter isEqualToString:@"z"]
        || sysCoinAddress.length < 25
        || sysCoinAddress.length > 35
        || [sysCoinAddress containsString:@"0"]
        || [sysCoinAddress containsString:@"O"]
        || [sysCoinAddress containsString:@"I"]
        || [sysCoinAddress containsString:@"l"]) {
        return NO;
    }
    return YES;
}

/**
 根据数值和精确度计算出处理后的结果
 
 @param precision 精确度
 @param value 数值
 @return 处理后的结果
 */
+ (NSDecimalNumber *)getValueByPrecision:(NSInteger)precision
                                   value:(NSDecimalNumber *)value {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:precision raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *decimalNumber = [value decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return decimalNumber;
}

/**
 文本框自适应宽度
 
 @param str 文本内容
 @param textFont 文本字体大小
 @return 文本宽度
 */
+ (CGFloat)widthForString:(NSString *)str Font:(UIFont *)textFont {
    
    //1.获取字体属性(字体样式,字体大小,行高等等),用 字典存储 key 值为 NSFontAttributeName
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName ,nil];
    //2.根据字符串 str 绘制一个矩形
    CGRect bound = [str boundingRectWithSize:(CGSizeMake(5000, 30)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return bound.size.width;
}

/**
 字符串转16进制
 
 @param str 文本内容
 @return 16进制输出
 */
+ (NSString *)convertStringToHexStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end


