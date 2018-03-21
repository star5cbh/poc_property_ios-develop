/************************************************************
 //  Zebra
 //
 //  Created by STAR on 15/5/7.
 //  Copyright (c) 2015年 peersafe. All rights reserved.
 //  */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "STDefine.h"
#import "ACMacros.h"

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

static const void *HttpRequestGIFHUDMaskViewKey = &HttpRequestGIFHUDMaskViewKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    HUD.square = YES;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    HUD.removeFromSuperViewOnHide = YES;
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, Main_Screen_Height/2.0 - 90) ;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showDeatilHint:(NSString *)hint{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, Main_Screen_Height/2.0 - 90) ;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}

- (void)showDeatilHint:(NSString *)hint yOffset:(float)yOffset{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, yOffset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:3];
}


- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    //hud.label.text = hint;
    hud.detailsLabel.text = hint;
    hud.detailsLabel.font = SYSTEMFONT(16);
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, yOffset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}

- (void)modifyHudTitle:(NSString *)hint {
    [self HUD].label.text = hint;
}

- (void)hideHud:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(hideHud) withObject:[NSNumber numberWithBool:animated] afterDelay:delay];
}


#pragma mark - GIFHUD

/* 显示gif加载框 */
- (void)showGifHudInView:(UIView *)view offset:(CGFloat)offsetY {
    
    [self hideGifHud];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    // 透明蒙版,防止加载时重复点击
    UIView *maskView = [[UIView alloc] init];
    [view addSubview:maskView];
    [self addAssociation:maskView];

    // sd_layout
    maskView.sd_layout
    .leftEqualToView(view)
    .topEqualToView(view)
    .rightEqualToView(view)
    .bottomEqualToView(view);
    
    // GIF
    UIView *gifHud = [[UIView alloc] init];
    CGFloat x = view.frame.size.width/2 - 100 * WidthScale;
    CGFloat y = view.frame.size.height/2 - 150 * WidthScale;
    if (offsetY && offsetY > 0) {
        y = y - offsetY;
    }
    gifHud.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    gifHud.layer.cornerRadius = 10 * WidthScale;
    
    YYAnimatedImageView *gifImageView = [[YYAnimatedImageView alloc] init];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 58; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazai_000%d",i]];
        [images addObject:image];
    }
    [gifImageView setAnimationImages:images];
    gifImageView.animationDuration = 3.2;
    [gifImageView startAnimating];
    
    [maskView addSubview:gifHud];
    [gifHud addSubview:gifImageView];

    gifHud.sd_layout
    .leftSpaceToView(maskView, x)
    .topSpaceToView(maskView, y)
    .widthIs(200 * WidthScale)
    .heightIs(200 * WidthScale);
    
    gifImageView.sd_layout
    .leftSpaceToView(gifHud, 60 * WidthScale)
    .topSpaceToView(gifHud, 0)
    .widthIs(80 * WidthScale)
    .heightIs(200 * WidthScale);
    
}

/* 移除gif加载框 */
- (void)hideGifHud {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    id objc = [self getAssociation];
    if ([objc isKindOfClass:[UIView class]] && objc) {
        UIView *gifHud = (UIView *)objc;
        [gifHud removeAllSubviews];
        [gifHud removeFromSuperview];
        objc_setAssociatedObject(self, &HttpRequestGIFHUDMaskViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)addAssociation:(id)objc {
    objc_setAssociatedObject(self, &HttpRequestGIFHUDMaskViewKey, objc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getAssociation {
    return objc_getAssociatedObject(self, &HttpRequestGIFHUDMaskViewKey);
}

@end
