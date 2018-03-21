//
//  ZXButtonStyleActionSheet.m
//  ZXWallet
//
//  Created by 张扬 on 2017/9/3.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import "ZXButtonStyleActionSheet.h"

#define kCellHeight            88 * HeightScale
#define kCellIntervalHeight    34 * HeightScale
#define kMarginWidth           55 * HeightScale
#define kMarginHeight          54 * HeightScale

#define titleColor             RGBACOLOR(0, 168, 252, 1)

@interface ZXButtonStyleActionSheet()

@property(nonatomic, weak) id<ZXButtonStyleActionSheetDelegate> delegate;

//所有的标题数组
@property(nonatomic, strong) NSArray *titleArray;

//第一个栏
@property(nonatomic, strong) NSString *destructiveTitle;

//记录上次显示时候的代理
@property(nonatomic, strong) id oldDelegate;

@end

@implementation ZXButtonStyleActionSheet

- (UIView *)initWithDelegate:(id<ZXButtonStyleActionSheetDelegate>)delegate
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles,... {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = delegate;
        _oldDelegate = delegate;
        
        NSMutableArray *otherArrary = [NSMutableArray array];
        
        va_list args;
        va_start(args, otherButtonTitles);
        while (otherButtonTitles != nil) {
            [otherArrary addObject:otherButtonTitles];
            otherButtonTitles = va_arg(args, NSString *);
        }
        va_end(args);
        
        if (destructiveButtonTitle.length != 0) {
            [otherArrary addObject:destructiveButtonTitle];
        }
        
        _titleArray = otherArrary;
        _destructiveTitle = destructiveButtonTitle;
    }
    return self;
}

- (void)dimView {
    self.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    view.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    view.tag = 200;
    view.alpha = 0;
    
    [self addSubview:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [view addGestureRecognizer:tap];
}

- (void)configView {
    float bottomViewHeight = _titleArray.count * kCellHeight + (_titleArray.count - 1) * kCellIntervalHeight + 2 * kMarginHeight;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width - 34 * WidthScale, bottomViewHeight)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bottomView.bounds;
    maskLayer.path = maskPath.CGPath;
    bottomView.layer.mask = maskLayer;
    bottomView.tag = 100;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    int totalCount = (int)_titleArray.count;
    int normalBtnCount = _destructiveTitle.length == 0 ? totalCount : (totalCount - 1);
    for (int i = 0; i < normalBtnCount; i++) {
        NSString *btnTitle = _titleArray[i];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kAppMainBtnNormalColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kAppMainBtnFocusColor] forState:UIControlStateHighlighted];
        btn.layer.cornerRadius = 8 * HeightScale;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomView addSubview:btn];
        
        if (i == 0) {
            btn.sd_layout
            .topSpaceToView(bottomView, kMarginHeight)
            .centerXEqualToView(bottomView)
            .widthIs(Main_Screen_Width - 2 * kMarginWidth)
            .heightIs(kCellHeight);
        } else {
            btn.sd_layout
            .topSpaceToView(bottomView, kMarginHeight + i*kCellIntervalHeight + i*kCellHeight)
            .centerXEqualToView(bottomView)
            .widthIs(Main_Screen_Width - 2 * kMarginWidth)
            .heightIs(kCellHeight);
        }
    }
    
    if (_destructiveTitle.length != 0) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = _titleArray.count - 1;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setTitle:_destructiveTitle forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kAppMainLineAndTextColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kAppDestructiveBtnFocusColor] forState:UIControlStateHighlighted];
        btn.layer.cornerRadius = 8 * HeightScale;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomView addSubview:btn];
        
        btn.sd_layout
        .topSpaceToView(bottomView, kMarginHeight + (totalCount-1)*kCellIntervalHeight + (totalCount-1)*kCellHeight)
        .bottomSpaceToView(bottomView, kMarginHeight)
        .centerXEqualToView(bottomView)
        .widthIs(Main_Screen_Width - 2 * kMarginWidth)
        .heightIs(kCellHeight);
    }
}

- (void)showInView:(UIView *)view {
    if (self.delegate == nil) {
        self.delegate = _oldDelegate;
    }
    [self dimView];
    [self configView];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (keyWindow == nil) {
        [view addSubview:self];
    } else {
        [keyWindow addSubview:self];
    }
    
    UIView *dimView = (UIView *)[self viewWithTag:200];
    UIView *contentView = (UIView *)[self viewWithTag:100];
    
    if ([self.delegate respondsToSelector:@selector(willPresentAcitonSheet:)]) {
        [self.delegate willPresentAcitonSheet:self];
    }
    
    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        dimView.alpha = 1;
        contentView.frame = CGRectMake(17 * WidthScale, Main_Screen_Height-contentView.frame.size.height, Main_Screen_Width - 34 * WidthScale, contentView.frame.size.height);
    }completion:^(BOOL finished){
        if ([self.delegate respondsToSelector:@selector(didPresentAcitonSheet:)]) {
            [self.delegate didPresentAcitonSheet:self];
        }
    }];
}

#pragma mark - tapclick
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:-1];
    }
    [self hidden:-1];
}

- (void)hidden:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        [self.delegate actionSheet:self willDismissWithButtonIndex:index];
    }
    
    UIView *dimView = (UIView *)[self viewWithTag:200];
    UIView *contentView = (UIView *)[self viewWithTag:100];
    
    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        contentView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, contentView.frame.size.height);
        dimView.alpha = 0;
    }completion:^(BOOL finished){
        if ([self.delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)] && index != -1) {
            [self.delegate actionSheet:self didDismissWithButtonIndex:index];
        }
        [contentView removeFromSuperview];
        [dimView removeFromSuperview];
        self.delegate = nil;
        [self removeFromSuperview];
    }];
}

- (void)didClickTitleBtn:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:btn.tag];
    }
    
    [self hidden:btn.tag];
}

@end
