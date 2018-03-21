//
//  ZXCurrencyPairSelectView.h
//  ZXWallet
//
//  Created by Turbo on 2017/11/28.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowStatus){
    StatusHidden   = 0,
    StatusShow = 1
};

/**
 *  币种选择器选择block回调
 *
 *  @param fromCurPair 选择前的币种
 *  @param toCurPair 选择后的币种
 */
typedef void (^CurrencyPairsBlock)(NSString *fromCurPair, NSString *toCurPair);

@class ZXCurrencyPairSelectView;

@protocol ZXCurrencyPairSelectViewDelegate <NSObject>

@optional

/**
 *  币种选择器选择代理回调
 *
 *  @param fromCurPair 选择前的币种
 *  @param toCurPair 选择后的币种
 */
- (void)currencyPairViewSelectDidFinish:(NSString *)fromCurPair toCurPair:(NSString *)toCurPair;

@end

@interface ZXCurrencyPairSelectView : UIView

@property (nonatomic, assign) ShowStatus showStatus; // 选择器隐藏状态
@property (nonatomic, weak) id <ZXCurrencyPairSelectViewDelegate> delegate;
@property (nonatomic, copy) CurrencyPairsBlock pairsblock;
@property (nonatomic, copy) NSString *baseCurrencyAlias;   // 左边选中币种别名
@property (nonatomic, copy) NSString *counterCurrencyAlias;// 右边选中币种别名

- (id)initWithFrame:(CGRect)frame;

- (void)showInView:(UIView *)view pairsArray:(NSArray *)pairsArray;

- (void)dismiss;

@end

