//
//  NSString+XHDiskSizeTransfrom.m
//  Zebra
//
//  Created by STAR on 15/5/7.
//  Copyright (c) 2015年 peersafe. All rights reserved.
//
#import "NSString+XHDiskSizeTransfrom.h"

@implementation NSString (XHDiskSizeTransfrom)

+ (NSString *)transformedValue:(long long)value {
    double convertedValue = value;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes", @"KB", @"MB", @"GB", @"TB", nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

@end
