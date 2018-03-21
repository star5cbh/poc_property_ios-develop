//
//  SDAlertView.h
//  Webet
//
//  Created by chenbaohui on 2016/12/15.
//  Copyright © 2016年 peersafe_webet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDAlertViewDelegate


- (void)didSDAlertClosed;

@optional
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface SDAlertView : UIView<SDAlertViewDelegate>

@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)

@property (nonatomic, assign) id<SDAlertViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, assign) BOOL isShowKeyboardAppear;   //显示时是否立即显示键盘
@property (nonatomic, assign) BOOL isShowUpsideTabbar;   //点击完成时是否在tabbar上部展示

@property (copy) void (^onButtonTouchUpInside)(SDAlertView *alertView, int buttonIndex) ;

- (id)init;

- (id)initWithParentView: (UIView *)_parentView;

- (void)show:(BOOL)backgroundClickable isInBottom:(BOOL)isInBottom;
- (void)close;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(SDAlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

@end
