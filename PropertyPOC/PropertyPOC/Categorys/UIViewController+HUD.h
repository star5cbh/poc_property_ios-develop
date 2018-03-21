/************************************************************
 //  Zebra
 //
 //  Created by STAR on 15/5/7.
 //  Copyright (c) 2015年 peersafe. All rights reserved.
 //  */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showGifHudInView:(UIView *)view offset:(CGFloat)offsetY;/* 加载GIF */

- (void)hideGifHud;/* 移除GIF */

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

//- (void)showHint:(NSString *)hint;

- (void)showDeatilHint:(NSString *)hint;

- (void)showDeatilHint:(NSString *)hint yOffset:(float)yOffset;

// 从默认(showHint:)显示的位置再往上(下)yOffset
//- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)modifyHudTitle:(NSString *)hint;

- (void)hideHud:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
