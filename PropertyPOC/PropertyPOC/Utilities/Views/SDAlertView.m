//
//  SDAlertView.m
//  Webet
//
//  Created by chenbaohui on 2016/12/15.
//  Copyright © 2016年 peersafe_webet. All rights reserved.
//

#import "SDAlertView.h"
#import <QuartzCore/QuartzCore.h>

const static CGFloat kCustomIOSAlertViewDefaultButtonHeight       = 44;
const static CGFloat kCustomIOSAlertViewDefaultButtonSpacerHeight = 1;
const static CGFloat kCustomIOSAlertViewCornerRadius              = 15;
const static CGFloat kCustomIOS7MotionEffectExtent                = 10.0;

@interface SDAlertView ()
{
    BOOL _isShowInBottom;
}

@end

@implementation SDAlertView


CGFloat buttonHeight = 0;
CGFloat buttonSpacerHeight = 0;

@synthesize parentView, containerView, dialogView, onButtonTouchUpInside;
@synthesize delegate;
@synthesize buttonTitles;
@synthesize useMotionEffects;

- (id)initWithParentView: (UIView *)_parentView{
    self = [self init];
    if (_parentView) {
//        self.frame = _parentView.frame;
        self.parentView = _parentView;
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        delegate = self;
        useMotionEffects = false;
//        buttonTitles = @[@"Close"];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        

    }
    return self;
}

//当观察到键盘发生变化的通知后,就调用的方法
- (void)keyBoardFrameChange:(NSNotification *)userInfo{

    //   1.修改试图的transform属性,让视图跟着键盘变化而变化
    //    ty = - 258 = 409 - view的高度;:表示键盘弹出的时候的值的变化
    //    ty = 0 意:transform是一种状态,当回到初始值状态为0,表示键盘回到原来的位置
    //    self.view.transform ==
    //    1.1获取变化的值
    NSDictionary *keyBoardDict = userInfo.userInfo;
    CGSize keyboardSize = [keyBoardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    //这里减去的是你需要调整的view的高度,如果view是全屏幕的可以用此方法
//    CGFloat ty = endKeyBoardFrame.origin.y - [UIScreen mainScreen].bounds.size.height;
    //   1.2修改transform属性,让视图变化
    //   1.3让修改有动画,获取动画的时间
    CGFloat duration = [keyBoardDict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];

    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGFloat margin = 0;
                         if (self.parentView){
                             margin = Navigation_Height;
                         }
                         dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height - margin), dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
    
    
}


// Create the dialog view, and animate opening the dialog
- (void)show:(BOOL)backgroundClickable isInBottom:(BOOL)isInBottom {
    _isShowInBottom = isInBottom;
    
    dialogView = [self createContainerView];
    
    dialogView.layer.shouldRasterize = YES;
    dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
#if (defined(__IPHONE_7_0))
    if (useMotionEffects) {
        [self applyMotionEffects];
    }
#endif
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:dialogView];
    
    // Can be attached to a view or to the top most window
    // Attached to a view:
    if (parentView != NULL) {
        [parentView addSubview:self];
        // Attached to the top most window
    } else {

            CGSize screenSize = [self countScreenSize];
            CGSize dialogSize = [self countDialogSize];
            CGSize keyboardSize = CGSizeMake(0, 0);
            CGFloat y = (screenSize.height - keyboardSize.height - dialogSize.height) / 2;
   
            if (_isShowInBottom){
                y = screenSize.height - keyboardSize.height - dialogSize.height;
            }
            dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, y, dialogSize.width, dialogSize.height);
            
        
        [[self lastWindow] addSubview:self];
    }
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    if (_isShowInBottom && !self.isShowKeyboardAppear){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        dialogView.layer.opacity = 1.0f;
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             
                             CGFloat margin = 0;
                             if (self.parentView){
                                 margin = Navigation_Height;
                             }
                             
                             CGFloat y = (screenSize.height - dialogSize.height - margin) / 2;
                             if (_isShowInBottom){
                                 y = screenSize.height - dialogSize.height - margin;
                             }
                             dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, y, dialogSize.width, dialogSize.height);
                         }
                         completion:nil
         ];
    } else {
        dialogView.layer.opacity = 0.5f;
        dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
        
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                             dialogView.layer.opacity = 1.0f;
                             dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                         }
                         completion:NULL
         ];
    }
    
    // Make the Background Clickable
    if (backgroundClickable) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [self addGestureRecognizer:tap];
    }
}

- (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}


- (void)didSDAlertClosed{
    
}

// Dialog close animation then cleaning and removing the view from the parent
- (void)close{
    CATransform3D currentTransform = dialogView.layer.transform;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat startRotation = [[dialogView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
        CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
        
        dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    }
    
    dialogView.layer.opacity = 1.0f;
    
    if (_isShowInBottom){
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             CGSize screenSize = [self countScreenSize];
                             CGSize dialogSize = [self countDialogSize];
                             dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, Main_Screen_Height, dialogSize.width, dialogSize.height);
                         }
                         completion:^(BOOL finished) {
                             for (UIView *v in [self subviews]) {
                                 [v removeFromSuperview];
                             }
                             [self removeFromSuperview];
                         }
         ];
    }else {
        [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                             dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                             dialogView.layer.opacity = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             for (UIView *v in [self subviews]) {
                                 [v removeFromSuperview];
                             }
                             [self removeFromSuperview];
                         }
         ];
    }
    
    if (delegate != nil){

        [delegate didSDAlertClosed];
    }
}

- (void)setSubView: (UIView *)subView{
    containerView = subView;
}

// Creates the container view here: create the dialog, then add the custom content and buttons
- (UIView *)createContainerView{
    if (containerView == NULL) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    // For the black background
    [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    CGFloat margin = 0;
    if (self.parentView){
        margin = Navigation_Height;
    }
    
    CGFloat y = (screenSize.height - dialogSize.height - margin) / 2;
    if (_isShowInBottom){
        y = screenSize.height - dialogSize.height - margin;
    }
    
    // This is the dialog's container; we attach the custom content and the buttons to this one
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2, y, dialogSize.width, dialogSize.height)];
    
    // First, we style the dialog to match the iOS7 UIAlertView >>>
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] CGColor],
                       nil];
    
    if (dialogSize.width != Main_Screen_Width){
        CGFloat cornerRadius = kCustomIOSAlertViewCornerRadius;
        gradient.cornerRadius = cornerRadius;
        [dialogContainer.layer insertSublayer:gradient atIndex:0];
        
        dialogContainer.layer.cornerRadius = cornerRadius;
        dialogContainer.layer.borderColor = [[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f] CGColor];
        dialogContainer.layer.borderWidth = 1;
        dialogContainer.layer.shadowRadius = cornerRadius + 5;
        dialogContainer.layer.shadowOpacity = 0.1f;
        dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
        dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
        dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    }
    
    // There is a line above the button
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, dialogContainer.bounds.size.height - buttonHeight - buttonSpacerHeight, dialogContainer.bounds.size.width-30, buttonSpacerHeight)];
    lineView.backgroundColor = kAppMainColor;
    [dialogContainer addSubview:lineView];
    // ^^^
    
    // Add the custom container if there is any
    [dialogContainer addSubview:containerView];
    
    // Add the buttons too
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
}

// Helper function: add buttons to container
- (void)addButtonsToView: (UIView *)container{
    if (buttonTitles==NULL) { return; }
    
    
    for (UIButton *btn in self.containerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn addTarget:self action:@selector(customIOS7dialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

        }
    }
    CGFloat buttonWidth = container.bounds.size.width / [buttonTitles count];
    
    for (int i = 0; i<[buttonTitles count]; i++) {
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        
        [closeButton addTarget:self action:@selector(customIOS7dialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];
        
        [closeButton setTitle:[buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        
        if (i == 0) {
            [closeButton setTitleColor:kAppMainColor forState:UIControlStateNormal];
        } else {
            [closeButton setTitleColor:kAppMainColor forState:UIControlStateNormal];
        }
        
        [closeButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        closeButton.titleLabel.numberOfLines = 0;
        closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [closeButton.layer setCornerRadius:kCustomIOSAlertViewCornerRadius];
        
        [container addSubview:closeButton];
    }
    
    for (int i=0; i<[buttonTitles count]-1; i++) {
        float weith = container.width*1.0/buttonTitles.count;
        UIView *cutline = [[UIView alloc]initWithFrame:CGRectMake(weith *(i+1), container.bounds.size.height - buttonHeight + 6, 1, buttonHeight - 12)];
        cutline.backgroundColor = RGBCOLOR(209, 209, 209);
        [container addSubview:cutline];
    }

    
}

// Helper function: count and return the dialog's size
- (CGSize)countDialogSize{
    CGFloat dialogWidth = containerView.frame.size.width;
    CGFloat dialogHeight = containerView.frame.size.height + buttonHeight + buttonSpacerHeight;
    
    return CGSizeMake(dialogWidth, dialogHeight);
}

// Helper function: count and return the screen's size
- (CGSize)countScreenSize{
    if (buttonTitles!=NULL && [buttonTitles count] > 0) {
        buttonHeight       = kCustomIOSAlertViewDefaultButtonHeight;
        buttonSpacerHeight = kCustomIOSAlertViewDefaultButtonSpacerHeight;
    } else {
        buttonHeight = 0;
        buttonSpacerHeight = 0;
    }
    
    CGFloat screenWidth = Main_Screen_Width;
    CGFloat screenHeight = Main_Screen_Height + Navigation_Height;
    
    return CGSizeMake(screenWidth, screenHeight);
}

#if (defined(__IPHONE_7_0))
// Add motion effects
- (void)applyMotionEffects {
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        return;
    }
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-kCustomIOS7MotionEffectExtent);
    horizontalEffect.maximumRelativeValue = @( kCustomIOS7MotionEffectExtent);
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-kCustomIOS7MotionEffectExtent);
    verticalEffect.maximumRelativeValue = @( kCustomIOS7MotionEffectExtent);
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [dialogView addMotionEffect:motionEffectGroup];
}
#endif

- (void)dealloc{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

// Rotation changed, on iOS7
- (void)changeOrientationForIOS7 {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
    CGAffineTransform rotation;
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 270.0 / 180.0);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 90.0 / 180.0);
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(-startRotation + M_PI * 180.0 / 180.0);
            break;
            
        default:
            rotation = CGAffineTransformMakeRotation(-startRotation + 0.0);
            break;
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         dialogView.transform = rotation;
                         
                     }
                     completion:nil
     ];
    
}

// Rotation changed, on iOS8
- (void)changeOrientationForIOS8: (NSNotification *)notification {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGSize dialogSize = [self countDialogSize];
                         CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
                         self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                         dialogView.frame = CGRectMake((screenWidth - dialogSize.width) / 2, (screenHeight - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

// Handle device orientation changes
- (void)deviceOrientationDidChange: (NSNotification *)notification{
    // If dialog is attached to the parent view, it probably wants to handle the orientation change itself
    if (parentView != NULL) {
        return;
    }
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        [self changeOrientationForIOS7];
    } else {
        [self changeOrientationForIOS8:notification];
    }
}

// Handle keyboard show/hide changes
- (void)keyboardWillShow: (NSNotification *)notification{
//    CGSize screenSize = [self countScreenSize];
//    CGSize dialogSize = [self countDialogSize];
//    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//
//    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//    if (UIInterfaceOrientationIsLandscape(interfaceOrientation) && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
//        CGFloat tmp = keyboardSize.height;
//        keyboardSize.height = keyboardSize.width;
//        keyboardSize.width = tmp;
//    }
//
//    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
//                     animations:^{
//                         CGFloat margin = 0;
//                         if (self.parentView){
//                             margin = Navigation_Height;
//                         }
//                         dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height - margin), dialogSize.width, dialogSize.height);
//                     }
//                     completion:nil
//     ];
}

- (void)keyboardWillHide: (NSNotification *)notification{
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    CGFloat margin = 0;
    if (self.parentView){
        margin = Navigation_Height;
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGFloat y = (screenSize.height - dialogSize.height - margin) / 2;
                         if (_isShowInBottom){
                             if (_isShowUpsideTabbar) {
                                 y = screenSize.height - dialogSize.height - margin - TabBar_Height;
                             } else {
                                 y = screenSize.height - dialogSize.height - margin;
                             }
                         }
                         dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, y, dialogSize.width, dialogSize.height);
                     }
                     completion:nil
     ];
}

// Button has been touched
- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender{
    if (delegate != NULL) {
//        [delegate customIOS7dialogButtonTouchUpInside:self clickedButtonAtIndex:[sender tag]];
    }
    
    if (onButtonTouchUpInside != NULL) {
        onButtonTouchUpInside(self, (int)[sender tag]);
    }
}

// Default button behaviour
- (void)customIOS7dialogButtonTouchUpInside: (SDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    DLog(@"Button Clicked! %d, %d", (int)buttonIndex, (int)[alertView tag]);
    //    [self close];
}

@end
