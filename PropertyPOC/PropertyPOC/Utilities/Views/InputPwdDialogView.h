//
//  InputPwdDialogView.h
//  Webet
//
//  Created by zhangyang on 4/1/17.
//  Copyright © 2017年 peersafe_webet. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TransModel.h"

@protocol InputPwdDialogViewDelegate <NSObject>
@required

/**
 点击了关闭按钮
 */
- (void)inPutPwdViewDidCloseDialogView;

/**
 点击了确认按钮

 @param inputPwd 输入密码
 */
- (void)inPutPwdViewConfirmClicked:(NSString *)inputPwd pwdType:(InputPWDType)inputPwdType;

@end

@interface InputPwdDialogView : UIView

@property (nonatomic, weak) id <InputPwdDialogViewDelegate> delegate;

- (id)initWithType:(InputPWDType)inputPwdType;
//@property (strong, nonatomic) TransModel *model;

@end
