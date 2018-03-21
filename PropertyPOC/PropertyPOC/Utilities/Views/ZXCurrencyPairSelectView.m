//
//  ZXCurrencyPairSelectView.m
//  ZXWallet
//
//  Created by Turbo on 2017/11/28.
//  Copyright © 2017年 peersafe_ZXWallet-ios. All rights reserved.
//

#import "ZXCurrencyPairSelectView.h"

@interface ZXCurrencyPairSelectView ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger _fromIndex;
    NSInteger _toIndex;
}
@property (nonatomic, strong) UIButton *maskView;   /* 半透明蒙版 */
@property (nonatomic, strong) UIView *pairBaseView; /* 选择器底板 */
@property (nonatomic, strong) UIPickerView *fromPairPickerView; /* 左边币种选择器 */
@property (nonatomic, strong) UIPickerView *toPairPickerView;   /* 右边币种选择器 */
@property (nonatomic, strong) UIButton *cancelButton; /* 取消按钮 */
@property (nonatomic, strong) UIButton *ensureButton; /* 确定按钮 */

@property (nonatomic, strong) NSArray *pairsArray; /* 币种数组 */

@property (nonatomic, strong) NSMutableArray *fromPairsArray;   /* 左边币种数组 */
@property (nonatomic, strong) NSMutableArray *toPairsArray;     /* 右边币种数组 */

@end

@implementation ZXCurrencyPairSelectView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpSubViews {
    
    // 半透明蒙版
    self.maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.maskView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    [self.maskView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.maskView];
    
    // 选择器baseView
    self.pairBaseView = [[UIView alloc] init];
    self.pairBaseView.backgroundColor = kAppTabBarColor;
    [self addSubview:self.pairBaseView];
    
    // 左边币种选择器
    self.fromPairPickerView = [[UIPickerView alloc]init];
    self.fromPairPickerView.backgroundColor = [UIColor clearColor];
    self.fromPairPickerView.dataSource = self;
    self.fromPairPickerView.delegate = self;
    [self.pairBaseView addSubview:self.fromPairPickerView];
    
    // 左边币种选择器选中细线
    UIView *left_top_line = [[UIView alloc] init];
    left_top_line.backgroundColor = kAppMainWhiteColor;
    left_top_line.alpha = 0.1;
    [self.pairBaseView addSubview:left_top_line];
    
    UIView *left_bot_line = [[UIView alloc] init];
    left_bot_line.backgroundColor = kAppMainWhiteColor;
    left_bot_line.alpha = 0.1;
    [self.pairBaseView addSubview:left_bot_line];
    
    // 右边币种选择器
    self.toPairPickerView = [[UIPickerView alloc]init];
    self.toPairPickerView.backgroundColor = [UIColor clearColor];
    self.toPairPickerView.dataSource = self;
    self.toPairPickerView.delegate = self;
    [self.pairBaseView addSubview:self.toPairPickerView];
    
    // 右边币种选择器选中细线
    UIView *right_top_line = [[UIView alloc] init];
    right_top_line.backgroundColor = kAppMainWhiteColor;
    right_top_line.alpha = 0.1;
    [self.pairBaseView addSubview:right_top_line];
    
    UIView *right_bot_line = [[UIView alloc] init];
    right_bot_line.backgroundColor = kAppMainWhiteColor;
    right_bot_line.alpha = 0.1;
    [self.pairBaseView addSubview:right_bot_line];
    
    // 转换图片
    UIImageView *transformImgView = [[UIImageView alloc] init];
    transformImgView.image = [UIImage imageNamed:@"pair_transform"];
    [self.pairBaseView addSubview:transformImgView];
    
    // 取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelButton.backgroundColor = kAppMainBtnFocusColor;
    [self.cancelButton setTitle:NSLocalizedString(@"common_cancel", @"nil") forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = SYSTEM_FONT(16.0f);
    [self.cancelButton setTitleColor:kAppMainWhiteColor forState:UIControlStateNormal];
    self.cancelButton.layer.cornerRadius = 4.0f;
    self.cancelButton.layer.borderColor = kAppDestructiveBtnFocusColor.CGColor;
    self.cancelButton.layer.borderWidth = 1.0f;
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.pairBaseView addSubview:self.cancelButton];
    
    // 确定按钮
    self.ensureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.ensureButton.backgroundColor = kAppDestructiveBtnFocusColor;
    [self.ensureButton setTitle:NSLocalizedString(@"common_confirm", @"nil") forState:UIControlStateNormal];
    self.ensureButton.titleLabel.font = SYSTEM_FONT(16.0f);
    [self.ensureButton setTitleColor:kAppMainWhiteColor forState:UIControlStateNormal];
    [self.ensureButton addTarget:self action:@selector(ensureClick) forControlEvents:UIControlEventTouchUpInside];
    self.ensureButton.layer.cornerRadius = 4.0f;
    [self.pairBaseView addSubview:self.ensureButton];
    
    
    // view.sd_layout
    self.maskView.sd_layout
    .xIs(0)
    .yIs(0)
    .widthIs(self.frame.size.width)
    .heightIs(Main_Screen_Height);
    
    self.pairBaseView.sd_layout
    .xIs(0)
    .yIs(- (496.0f * HeightScale + 64.0f))
    .widthIs(self.frame.size.width)
    .heightIs(496.0f * HeightScale);
    
    self.fromPairPickerView.sd_layout
    .xIs(0)
    .yIs(10.0f * HeightScale)
    .widthIs(self.frame.size.width/2)
    .heightIs(356.0f * HeightScale);
    
    left_top_line.sd_layout
    .xIs(97.5f * WidthScale)
    .yIs(150.0f * HeightScale)
    .widthIs(180.0f * WidthScale)
    .heightIs(2.0f * HeightScale);
    
    left_bot_line.sd_layout
    .xIs(97.5f * WidthScale)
    .yIs(218.0f * HeightScale)
    .widthIs(180.0f * WidthScale)
    .heightIs(2.0f * HeightScale);
    
    self.toPairPickerView.sd_layout
    .leftSpaceToView(self.fromPairPickerView, 0)
    .topSpaceToView(self.pairBaseView, 10.0f *HeightScale)
    .widthIs(self.frame.size.width/2)
    .heightIs(356.0f * HeightScale);
    
    right_top_line.sd_layout
    .leftSpaceToView(self.fromPairPickerView, 97.5f * WidthScale)
    .topSpaceToView(self.pairBaseView, 150.0f * HeightScale)
    .widthIs(180.0f * WidthScale)
    .heightIs(2.0f * HeightScale);
    
    right_bot_line.sd_layout
    .leftSpaceToView(self.fromPairPickerView, 97.5f * WidthScale)
    .topSpaceToView(self.pairBaseView, 218.0f * HeightScale)
    .widthIs(180.0f * WidthScale)
    .heightIs(2.0f * HeightScale);
    
    transformImgView.sd_layout
    .leftSpaceToView(self.pairBaseView, Main_Screen_Width/2 - 27.0f * WidthScale)
    .topSpaceToView(self.pairBaseView, 188.0f * HeightScale - 21.0f * HeightScale)
    .widthIs(54.0f * WidthScale)
    .heightIs(42.0f * HeightScale);
    
    self.cancelButton.sd_layout
    .bottomSpaceToView(self.pairBaseView, 40.0f * HeightScale)
    .leftSpaceToView(self.pairBaseView, 52.0f * WidthScale)
    .widthIs(290.0f * WidthScale)
    .heightIs(80.0f * HeightScale);
    
    self.ensureButton.sd_layout
    .bottomSpaceToView(self.pairBaseView, 40.0f * HeightScale)
    .rightSpaceToView(self.pairBaseView, 52.0f * WidthScale)
    .widthIs(290.0f * WidthScale)
    .heightIs(80.0f * HeightScale);
    
}

#pragma mark - pickerView delegate && datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == self.fromPairPickerView) {
        return self.fromPairsArray.count;
    } else {
        return self.toPairsArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title;
    if (pickerView == self.fromPairPickerView) {
        title = self.fromPairsArray[row];
        return title;
    } else  {
        title = self.toPairsArray[row];
        return title;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 78.0f * HeightScale;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    // 隐藏两条picker自带分割线
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = SYSTEM_FONT(17);
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.textColor = kAppMainWhiteColor;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - pickerView didSelectRow

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.fromPairPickerView) {
        _fromIndex = row;
        _baseCurrencyAlias = self.fromPairsArray[_fromIndex];
        [self separateToPairData];
    } else if (pickerView == self.toPairPickerView) {
        _toIndex = row;
    }
    
    _counterCurrencyAlias = self.toPairsArray[_toIndex];
    
}

// 分离出左边已选币种数据作为右边币种数据
- (void)separateToPairData {
    
    self.toPairsArray = [self.pairsArray mutableCopy];
    [self.toPairsArray removeObject:_baseCurrencyAlias];
    [self.fromPairPickerView reloadComponent:0];
    [self.toPairPickerView reloadComponent:0];
}

// 计算并设置已选币种状态
- (void)getPairStatus {
    
    _fromIndex = 0;
    _toIndex = 0;
    self.fromPairsArray = [NSMutableArray arrayWithArray:_pairsArray];
    self.toPairsArray = [NSMutableArray arrayWithArray:_pairsArray];
    
    if (!self.baseCurrencyAlias && !self.counterCurrencyAlias) {
        // 如果没有设置初始币种,默认从0开始
        _baseCurrencyAlias = self.fromPairsArray[_fromIndex];
        [self separateToPairData];
        _counterCurrencyAlias = self.toPairsArray[_toIndex];
    } else {
        [self separateToPairData];
        _fromIndex = [self.fromPairsArray indexOfObject:_baseCurrencyAlias];
        _toIndex = [self.toPairsArray indexOfObject:_counterCurrencyAlias];
        
        // 滚轮滚动到已选币种位置
        [self.fromPairPickerView selectRow:_fromIndex inComponent:0 animated:NO];
        [self.toPairPickerView selectRow:_toIndex inComponent:0 animated:NO];
    }
}

// 弹出币种选择器
- (void)showInView:(UIView *)view pairsArray:(NSArray *)pairsArray {
    
    self.pairsArray = pairsArray;
    
    // 初始化子视图
    [self setUpSubViews];
    
    self.hidden = NO;

    self.showStatus = StatusShow;

    // 计算并设置币种选中状态
    [self getPairStatus];
    
    [view addSubview:self];
    
    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect tempFrame = self.pairBaseView.frame;
        tempFrame.origin.y = 0;
        self.pairBaseView.frame = tempFrame;
        self.maskView.alpha = 1;
        
    }completion:^(BOOL finished){
        
    }];
}

// 确定
- (void)ensureClick {
    
    if (self.pairsblock) {
        self.pairsblock(_baseCurrencyAlias, _counterCurrencyAlias);
    }
    
    if ([self.delegate respondsToSelector:@selector(currencyPairViewSelectDidFinish:toCurPair:)]) {
        [self.delegate currencyPairViewSelectDidFinish:_baseCurrencyAlias toCurPair:_counterCurrencyAlias];
    }
    
    [self dismiss];
}

// 隐藏币种选择器
- (void)dismiss {
    
    self.showStatus = StatusHidden;

    [UIView animateWithDuration:.28 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect tempFrame = self.pairBaseView.frame;
        tempFrame.origin.y = - (496.0f * HeightScale + 64.0f);
        self.pairBaseView.frame = tempFrame;
        self.maskView.alpha = 0;
        [[self.pairBaseView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.pairBaseView removeFromSuperview];
        [self.maskView removeFromSuperview];
        self.pairBaseView = nil;
        self.maskView = nil;
        
    }completion:^(BOOL finished){
        self.hidden = YES;
    }];
}

@end

