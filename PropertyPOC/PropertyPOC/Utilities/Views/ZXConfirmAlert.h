//
//  ZXConfirmAlert.h
//  ZXWallet
//
//  Created by STAR on 2017/9/18.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TransModel.h"
@protocol ZXConfirmAlertDelegate <NSObject>

/**
 点击了逛逛其他按钮
 */
//- (void)ZXConfirmAlertBtnClickedIndex:(NSInteger)index model:(TransModel *)model type:(ZxConfirmType)type;

@end

@interface ZXConfirmAlert : UIView
//
//@property (nonatomic, weak) id <ZXConfirmAlertDelegate> delegate;
//@property (nonatomic, strong) TransModel *model;
//
//- (id)initWithTransModel:(TransModel *)model type:(ZxConfirmType)type;

//- (void)show;
//- (void)hide;

@end
