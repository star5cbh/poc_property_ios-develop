//
//  ZXConfirmAlert.m
//  ZXWallet
//
//  Created by STAR on 2017/9/18.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import "ZXConfirmAlert.h"
//#import "ZXManager.h"

@interface ZXConfirmAlert (){
    UILabel *_titleLabel;
    UILabel *_currencyTitle;
    UILabel *_currencyLabel;
    
    UILabel *_transTypeTitle;
    UILabel *_transTypeLabel;
    
    UILabel *_priceTitle;
    UILabel *_priceLabel;
    
    UILabel *_amountTitle;
    UILabel *_amountLabel;
    
    UILabel *_notiLabel;
    UIView * _horiLine;
    UIView * _verticalLine;
    
    UIButton *_cancelBtn;
    UIButton *_confirmBtn;
    
//    TransModel *_model;
    ZxConfirmType _type;
    
}

@end

@implementation ZXConfirmAlert

//- (id)initWithTransModel:(TransModel *)model type:(ZxConfirmType)type{
//    self = [super initWithFrame:CGRectMake(0, 0, 550 * WidthScale, 248)];
//    if (self) {
//        _model = model;
//        _type = type;
//        [self addSubviews];
//        RLMCurrencyPair *pair = [ZXManager sharedInstance].curCurrencyPair;
//        RLMCurUserCurrencyInfo *baseCurrency = [RLMCurUserCurrencyInfo getCurCurrencyByName:pair.baseCurrency];
//
//        switch (type) {
//            case ZxConfirmTypeCreate:{
//
//                switch (_model.transType) {
//                    case TransModeByOffer:
//                        _transTypeLabel.text = NSLocalizedString(@"trans_transTypeByOffer", nil);
//                        _priceLabel.text = _model.price.stringValue;
//                        _priceLabel.hidden = NO;
//                        _priceTitle.hidden = NO;
//                        _amountTitle.sd_layout
//                        .topSpaceToView(_transTypeTitle, 30)
//                        .leftSpaceToView(self, 25)
//                        .widthIs(70)
//                        .heightIs(20);
//                        _priceTitle.text = NSLocalizedString(@"trans_Offer_price", nil);
//                        _amountTitle.text = NSLocalizedString(@"trans_Offer_amount", nil);
//
//                        break;
//                    case TransModeByPath:{
//                        _transTypeLabel.text = NSLocalizedString(@"trans_transTypeByPath", nil);
//                        _priceLabel.hidden = YES;
//                        _priceTitle.hidden = YES;
//                        _amountTitle.sd_layout
//                        .topSpaceToView(_transTypeTitle, 5)
//                        .leftSpaceToView(self, 25)
//                        .widthIs(70)
//                        .heightIs(20);
//                    }
//                        break;
//
//                    default:
//                        break;
//                }
//                switch (_model.modelType) {
//                    case TransModelTypeBuy:
//                        _titleLabel.text = NSLocalizedString(@"trans_title_buy", nil);
//
//                        switch (model.transType) {
//                            case TransModeByOffer:
//                                _amountLabel.text = _model.amount.stringValue;
//
//                                break;
//                            case TransModeByPath:{
//                                _priceLabel.text = @"";
//                                _amountTitle.text = NSLocalizedString(@"trans_buyAmount", nil);
//                                _amountLabel.text = _model.amount.stringValue;
//                            }
//                                break;
//
//                            default:
//                                break;
//                        }
//                        [_confirmBtn setTitle:NSLocalizedString(@"trans_title_buy", nil) forState:UIControlStateNormal];
//                        break;
//                    case TransModelTypeSale:
//                        _titleLabel.text = NSLocalizedString(@"trans_title_sale", nil);
//                        [_confirmBtn setTitle:NSLocalizedString(@"trans_title_sale", nil) forState:UIControlStateNormal];
//                        switch (model.transType) {
//                            case TransModeByOffer:
//                                _amountLabel.text = _model.amount.stringValue;
//
//                                break;
//                            case TransModeByPath:{
//                                _priceLabel.text = @"";
//                                _amountTitle.text = NSLocalizedString(@"trans_saleAmount", nil);
//                                _amountLabel.text = [Util getShowStringWithNumber:_model.canBuyAmount precision:baseCurrency.precision limitLength:baseCurrency.limitLength showLastZero:NO showKValue:NO roundingMode:NSRoundDown];
//                            }
//                                break;
//
//                            default:
//                                break;
//                        }
//                        break;
//
//                    default:
//                        break;
//                }
//            }
//                break;
//
//            case ZxConfirmTypeCancel:{
//                _priceTitle.text = NSLocalizedString(@"trans_Offer_price", nil);
//                _amountTitle.text = NSLocalizedString(@"trans_Offer_amount", nil);
//                _titleLabel.text = NSLocalizedString(@"trans_title_offerCancel", nil);
//                _transTypeLabel.text = NSLocalizedString(@"trans_title_sale", nil);
//                [_confirmBtn setTitle:NSLocalizedString(@"common_confirm", nil) forState:UIControlStateNormal];
//                ActOfferData *data = _model.currentOffer;
//                RLMCurrencyPair *pair = [RLMCurrencyPair getCurrencyPair:data.takerGetsCurrency counterCurrency:data.takerPaysCurrency];
//                if (!pair) {
//                    pair = [RLMCurrencyPair getCurrencyPair:data.takerPaysCurrency counterCurrency:data.takerGetsCurrency];
//                }
//                NSString *currency = data.takerPaysCurrency;
//
//                _currencyLabel.text = [NSString stringWithFormat:@"%@／%@",pair.baseCurrency,pair.counterCurrency];
//                if ([currency isEqualToString:pair.baseCurrency]) {
//                    //买单
//                    _transTypeLabel.text = NSLocalizedString(@"trans_CancelBuyOffer", nil);
//                    NSDecimalNumber *price = [data.takerGetsValue decimalNumberByDividingBy:data.takerPaysValue];
//
//                    _priceLabel.text = [Util getShowStringWithNumber:price precision:pair.precision limitLength:pair.limitLength showLastZero:NO showKValue:NO roundingMode:NSRoundPlain];
//
//                    _amountLabel.text = [Util getShowStringWithNumber:data.takerPaysValue precision:baseCurrency.precision limitLength:baseCurrency.limitLength showLastZero:NO showKValue:NO roundingMode:NSRoundDown];
//
//                } else {
//                    //卖单
//                    _transTypeLabel.text = NSLocalizedString(@"trans_CancelSaleOffer", nil);
//
//                    NSDecimalNumber *price = [data.takerPaysValue decimalNumberByDividingBy:data.takerGetsValue];
//
//                    _priceLabel.text = [Util getShowStringWithNumber:price precision:pair.precision limitLength:pair.limitLength showLastZero:NO showKValue:NO roundingMode:NSRoundPlain];
//
//                    _amountLabel.text = [Util getShowStringWithNumber:data.takerGetsValue precision:baseCurrency.precision limitLength:baseCurrency.limitLength showLastZero:NO showKValue:NO roundingMode:NSRoundDown];
//                }
//            }
//                break;
//            default:
//                break;
//        }
//
//        _currencyTitle.text = NSLocalizedString(@"trans_currencyType", nil);
//        _transTypeTitle.text = NSLocalizedString(@"trans_transType", nil);
//
//        NSString *currency = [NSString stringWithFormat:@"%@/%@",[ZXManager sharedInstance].curCurrencyPair.baseCurrencyAlias,[ZXManager sharedInstance].curCurrencyPair.counterCurrencyAlias];
//        _currencyLabel.text = currency;
//        _notiLabel.text = NSLocalizedString(@"trans_comfirmNoti", nil);
//    }
//    return self;
//}

- (void)addSubviews{
    [self removeAllSubviews];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.cornerRadius = 10;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = kAppMainBlackColor;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _currencyTitle = [[UILabel alloc] init];
    _currencyTitle.textColor = kAppMainBlackColor;
    _currencyTitle.font = [UIFont systemFontOfSize:15];
    _currencyTitle.textAlignment = NSTextAlignmentLeft;
    
    _currencyLabel = [[UILabel alloc] init];
    _currencyLabel.textColor = kAppMainRedColor;
    _currencyLabel.font = [UIFont systemFontOfSize:15];
    _currencyLabel.textAlignment = NSTextAlignmentLeft;
    
    _transTypeTitle = [[UILabel alloc] init];
    _transTypeTitle.textColor = kAppMainBlackColor;
    _transTypeTitle.font = [UIFont systemFontOfSize:15];
    _transTypeTitle.textAlignment = NSTextAlignmentLeft;
    
    _transTypeLabel = [[UILabel alloc] init];
    _transTypeLabel.textColor = kAppMainBlackColor;
    _transTypeLabel.font = [UIFont systemFontOfSize:15];
    _transTypeLabel.textAlignment = NSTextAlignmentLeft;
    
    _priceTitle = [[UILabel alloc] init];
    _priceTitle.textColor = kAppMainBlackColor;
    _priceTitle.font = [UIFont systemFontOfSize:15];
    _priceTitle.textAlignment = NSTextAlignmentLeft;
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = kAppMainRedColor;
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    
    _amountTitle = [[UILabel alloc] init];
    _amountTitle.textColor = kAppMainBlackColor;
    _amountTitle.font = [UIFont systemFontOfSize:15];
    _amountTitle.textAlignment = NSTextAlignmentLeft;
    
    _amountLabel = [[UILabel alloc] init];
    _amountLabel.textColor = kAppMainRedColor;
    _amountLabel.font = [UIFont systemFontOfSize:15];
    _amountLabel.textAlignment = NSTextAlignmentLeft;
    
    _notiLabel = [[UILabel alloc] init];
    _notiLabel.textColor = kAppMainBlackColor;
    _notiLabel.font = [UIFont systemFontOfSize:15];
    _notiLabel.textAlignment = NSTextAlignmentLeft;
    _notiLabel.numberOfLines = 2;
    
    _verticalLine = [[UIView alloc] init];
    _verticalLine.backgroundColor = RGBCOLOR(225, 225, 225);
    
    _horiLine = [[UIView alloc] init];
    _horiLine.backgroundColor = RGBCOLOR(225, 225, 225);
    
    _cancelBtn = [[UIButton alloc] init];
    [_cancelBtn setTitleColor:kAppMainBlackColor forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_cancelBtn setTitle:NSLocalizedString(@"common_cancel", nil) forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kAppMainColor forState:UIControlStateHighlighted];
    [_cancelBtn setTitleColor:kAppMainColor forState:UIControlStateSelected];
    [_cancelBtn addTarget:self action:@selector(didClickSeeOtherBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmBtn = [[UIButton alloc] init];
    [_confirmBtn setTitleColor:kAppMainBlackColor forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_confirmBtn setTitleColor:kAppMainColor forState:UIControlStateHighlighted];
    [_confirmBtn setTitleColor:kAppMainColor forState:UIControlStateSelected];
    [_confirmBtn addTarget:self action:@selector(didClickSeeOtherBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_titleLabel];
    [self addSubview:_transTypeTitle];
    [self addSubview:_priceTitle];
    [self addSubview:_amountTitle];
    [self addSubview:_currencyTitle];
    
    [self addSubview:_transTypeLabel];
    [self addSubview:_priceLabel];
    [self addSubview:_amountLabel];
    [self addSubview:_currencyLabel];
    
    [self addSubview:_notiLabel];
    [self addSubview:_verticalLine];
    [self addSubview:_horiLine];
    
    [self addSubview:_confirmBtn];
    [self addSubview:_cancelBtn];
    
    
    _titleLabel.sd_layout
    .widthIs(self.frame.size.width)
    .topEqualToView(self)
    .leftEqualToView(self)
    .heightIs(40);
    
    _currencyTitle.sd_layout
    .topSpaceToView(_titleLabel, 5)
    .leftSpaceToView(self, 25)
    .heightIs(20);
    [_currencyTitle setSingleLineAutoResizeWithMaxWidth:150];
    
    _currencyLabel.sd_layout
    .topEqualToView(_currencyTitle)
    .leftSpaceToView(_currencyTitle, 5)
    .widthIs(150)
    .heightIs(20);
    
    _transTypeTitle.sd_layout
    .topSpaceToView(_currencyTitle, 5)
    .leftSpaceToView(self, 25)
    .heightIs(20);
    [_transTypeTitle setSingleLineAutoResizeWithMaxWidth:150];
    
    _transTypeLabel.sd_layout
    .topEqualToView(_transTypeTitle)
    .leftSpaceToView(_transTypeTitle, 5)
    .widthIs(150)
    .heightIs(20);
    
    _priceTitle.sd_layout
    .topSpaceToView(_transTypeTitle, 5)
    .leftSpaceToView(self, 25)
    .heightIs(20);
    [_priceTitle setSingleLineAutoResizeWithMaxWidth:150];
    
    _priceLabel.sd_layout
    .topEqualToView(_priceTitle)
    .leftSpaceToView(_priceTitle, 5)
    .widthIs(150)
    .heightIs(20);
    
    _amountTitle.sd_layout
    .topSpaceToView(_transTypeTitle, 30)
    .leftSpaceToView(self, 25)
    .heightIs(20);
    [_amountTitle setSingleLineAutoResizeWithMaxWidth:150];
    
    _amountLabel.sd_layout
    .topEqualToView(_amountTitle)
    .leftSpaceToView(_amountTitle, 5)
    .widthIs(150)
    .heightIs(20);
    
    _notiLabel.sd_layout
    .topSpaceToView(_amountTitle, 15)
    .leftSpaceToView(self, 25)
    .widthIs(Main_Screen_Width * 0.6)
    .heightIs(40);
    
    _cancelBtn.sd_layout
    .bottomSpaceToView(self, 0)
    .leftEqualToView(self)
    .widthIs(self.width*.5)
    .heightIs(44);
    
    _confirmBtn.sd_layout
    .bottomSpaceToView(self, 0)
    .rightEqualToView(self)
    .widthIs(self.width*.5)
    .heightIs(44);
    
    _horiLine.sd_layout
    .topEqualToView(_cancelBtn)
    .centerXEqualToView(self)
    .widthIs(self.width)
    .heightIs(1);
    
    _verticalLine.sd_layout
    .topEqualToView(_cancelBtn)
    .centerXEqualToView(self)
    .widthIs(1)
    .heightIs(_cancelBtn.height);
    
}


#pragma mark - click action
- (void)didClickSeeOtherBtn:(UIButton *)button{
    NSInteger index = 0;
    if ([button isEqual:_confirmBtn]) {
        index = 1;
    }
//    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(ZXConfirmAlertBtnClickedIndex:model:type:)]){
//        [self.delegate ZXConfirmAlertBtnClickedIndex:index model:_model type:_type];
//    }
}


@end
