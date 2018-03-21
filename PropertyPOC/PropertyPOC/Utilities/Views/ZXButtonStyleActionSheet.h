//
//  ZXButtonStyleActionSheet.h
//  ZXWallet
//
//  Created by 张扬 on 2017/9/3.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXButtonStyleActionSheet;

@protocol ZXButtonStyleActionSheetDelegate <NSObject>

@optional

//如果点击空白处，index值为-1
- (void)actionSheet:(ZXButtonStyleActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)willPresentAcitonSheet:(ZXButtonStyleActionSheet *)actionSheet;
- (void)didPresentAcitonSheet:(ZXButtonStyleActionSheet *)actionSheet;
- (void)actionSheet:(ZXButtonStyleActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)actionSheet:(ZXButtonStyleActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface ZXButtonStyleActionSheet : UIView

- (UIView *)initWithDelegate:(id<ZXButtonStyleActionSheetDelegate>)delegate
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSString *)otherButtonTitles,...;

- (void)showInView:(UIView *)view;


@end
