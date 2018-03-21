//
//  UIButton+XHButtonTitlePosition.h
//  Zebra
//
//  Created by STAR on 15/5/7.
//  Copyright (c) 2015年 peersafe. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XHButtonTitlePostionType) {
    XHButtonTitlePostionTypeBottom = 0,
};

@interface UIButton (XHButtonTitlePosition)

- (void)setTitlePositionWithType:(XHButtonTitlePostionType)type;

@end
