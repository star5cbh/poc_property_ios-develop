//
//  InputPwdDialogView.m
//  Webet
//
//  Created by zhangyang on 4/1/17.
//  Copyright © 2017年 peersafe_webet. All rights reserved.
//

#import "InputPwdDialogView.h"

@interface InputPwdDialogView ()
{
    UITextField *_inputPwdTextFiled;
    InputPWDType _inputPwdType;
    UIButton *_confirmBtn;
}

@property (nonatomic, strong) WKTextFieldFormatter *pwdFormatter;

@end

@implementation InputPwdDialogView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithType:(InputPWDType)inputPwdType {
    self = [super initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 414 * HeightScale)];
    if (self) {
        _inputPwdType = inputPwdType;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIView *topView = [[UIView alloc] init];
        
        UIButton *closeBtn = [[UIButton alloc] init];
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(didClickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kAppMainBlackColor;
        titleLabel.text = NSLocalizedString(@"common_input_pwd", nil);
        
        [topView addSubview:closeBtn];
        [topView addSubview:titleLabel];
        
        _inputPwdTextFiled = [[UITextField alloc] init];
        _inputPwdTextFiled.secureTextEntry = YES;
        [_inputPwdTextFiled setValue:[NSNumber numberWithInt:8] forKey:@"paddingLeft"];
        _inputPwdTextFiled.layer.cornerRadius = 5;
        _inputPwdTextFiled.layer.borderWidth = 1;
        _inputPwdTextFiled.layer.borderColor = [kAppMainGrayColor CGColor];
        
        _pwdFormatter = [[WKTextFieldFormatter alloc] initWithTextField:_inputPwdTextFiled];
        _pwdFormatter.formatterType = WKFormatterTypePassWord;
        
        [_inputPwdTextFiled addTarget:self action:@selector(textFiledEditChanged:) forControlEvents:UIControlEventEditingChanged];
        [_inputPwdTextFiled becomeFirstResponder];
        UILabel *noteLabel = nil;
        UILabel *feeLabel = nil;
        if (InputPWDTypeCreate == inputPwdType) {
            noteLabel = [[UILabel alloc] init];
            noteLabel.font = [UIFont systemFontOfSize:11.0];
            noteLabel.textColor = kAppMainColor;
            noteLabel.text = NSLocalizedString(@"note", nil);
            
            feeLabel = [[UILabel alloc] init];
            feeLabel.font = [UIFont systemFontOfSize:11.0];
            feeLabel.textColor = kAppMainColor;
            feeLabel.text = NSLocalizedString(@"activity_fee_tip", nil);
            
            [self addSubview:noteLabel];
            [self addSubview:feeLabel];
        }else if (InputPWDTypeEdit == inputPwdType) {
            noteLabel = [[UILabel alloc] init];
            noteLabel.font = [UIFont systemFontOfSize:11.0];
            noteLabel.textColor = kAppMainColor;
            noteLabel.text = NSLocalizedString(@"note", nil);
            
            feeLabel = [[UILabel alloc] init];
            feeLabel.font = [UIFont systemFontOfSize:11.0];
            feeLabel.textColor = kAppMainColor;
            feeLabel.text = NSLocalizedString(@"activity_editFee_tip", nil);
            
            [self addSubview:noteLabel];
            [self addSubview:feeLabel];
        }
//        else if (InputPWDTypeTransfer == inputPwdType) {
//            noteLabel = [[UILabel alloc] init];
//            noteLabel.font = [UIFont systemFontOfSize:11.0];
//            noteLabel.textColor = kAppMainColor;
//            noteLabel.text = NSLocalizedString(@"note", nil);
//            
//            feeLabel = [[UILabel alloc] init];
//            feeLabel.font = [UIFont systemFontOfSize:11.0];
//            feeLabel.textColor = kAppMainColor;
//            feeLabel.text = NSLocalizedString(@"transferFeetip", nil);
//            
//            [self addSubview:noteLabel];
//            [self addSubview:feeLabel];
//        }
        else if (inputPwdType == InputPWDTypeLogin) {
            noteLabel = [[UILabel alloc] init];
            noteLabel.font = [UIFont systemFontOfSize:11.0];
            noteLabel.textColor = kAppMainColor;
            noteLabel.text = NSLocalizedString(@"note", nil);
            [self addSubview:noteLabel];
        }else if (inputPwdType == InputPWDTypeDeleteUser) {
            noteLabel = [[UILabel alloc] init];
            noteLabel.font = [UIFont systemFontOfSize:11.0];
            noteLabel.textColor = kAppMainColor;
            noteLabel.text = NSLocalizedString(@"note", nil);
            [self addSubview:noteLabel];
        } else if (inputPwdType == InputPWDTypeWithdrawConfirm) {
            noteLabel = [[UILabel alloc] init];
            noteLabel.font = [UIFont systemFontOfSize:11.0];
            noteLabel.textColor = kAppMainColor;
            noteLabel.text = NSLocalizedString(@"note", nil);
            
            feeLabel = [[UILabel alloc] init];
            feeLabel.font = [UIFont systemFontOfSize:11.0];
            feeLabel.textColor = kAppMainColor;
            feeLabel.text = NSLocalizedString(@"withdrawConfirmInputPwdTip", nil);
            
            [self addSubview:noteLabel];
            [self addSubview:feeLabel];
        }
        
        _confirmBtn = [[UIButton alloc] init];
        _confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _confirmBtn.titleLabel.textColor = [UIColor whiteColor];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_confirmBtn setTitleColor:kAppMainLineAndTextColor forState:UIControlStateDisabled];
        [_confirmBtn setTitle:NSLocalizedString(@"common_confirm", nil) forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_pwd_normal"] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_pwd_focus"] forState:UIControlStateHighlighted];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btn_pwd_disabled"] forState:UIControlStateDisabled];
        [_confirmBtn addTarget:self action:@selector(didClick_confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setEnabled:NO];
        
        [self addSubview:topView];
        [self addSubview:_inputPwdTextFiled];
        [self addSubview:_confirmBtn];
        
        topView.sd_layout
        .widthIs(self.frame.size.width)
        .heightIs(35);
        
        closeBtn.sd_layout
        .leftSpaceToView(topView, 5)
        .topEqualToView(topView)
        .heightIs(35)
        .widthEqualToHeight();
        
        titleLabel.sd_layout
        .centerXEqualToView(topView)
        .centerYEqualToView(topView)
        .widthIs(Main_Screen_Width * 0.6)
        .autoHeightRatio(0);
        
        _inputPwdTextFiled.sd_layout
        .topSpaceToView(topView, 60 * HeightScale)
        .centerXEqualToView(self)
        .widthIs(self.frame.size.width - 60 * WidthScale)
        .heightIs(74 * HeightScale);
        
//        if (InputPWDTypeCreate == inputPwdType
//            || InputPWDTypeEdit == inputPwdType
//            || InputPWDTypeTransfer == inputPwdType
//            || InputPWDTypeWithdrawConfirm == inputPwdType) {
//            
//            noteLabel.sd_layout
//            .topSpaceToView(_inputPwdTextFiled, 14 * HeightScale)
//            .leftSpaceToView(self, 50 * WidthScale)
//            .autoHeightRatio(0);
//            
//            [noteLabel setSingleLineAutoResizeWithMaxWidth:60];
//            
//            feeLabel.sd_layout
//            .topSpaceToView(_inputPwdTextFiled, 14 * HeightScale)
//            .leftSpaceToView(noteLabel, 0)
//            .widthIs(Main_Screen_Width * 0.8)
//            .autoHeightRatio(0);
//            
//            _confirmBtn.sd_layout
//            .topSpaceToView(_inputPwdTextFiled, 78 * WidthScale)
//            .centerXEqualToView(self)
//            .widthIs(self.frame.size.width - 60 * WidthScale)
//            .heightIs(80 * HeightScale);
//        } else {
            _confirmBtn.sd_layout
            .topSpaceToView(_inputPwdTextFiled, 60 * WidthScale)
            .centerXEqualToView(self)
            .widthIs(self.frame.size.width - 60 * WidthScale)
            .heightIs(80 * HeightScale);
//        }
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)textFiledEditChanged:(UITextField *)textField{
    NSString *toBeString = textField.text;
    toBeString = [toBeString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (toBeString.length > 0) {
        [_confirmBtn setEnabled:YES];
    } else {
        [_confirmBtn setEnabled:NO];
    }
}

#pragma mark - click action
- (void)didClickCloseBtn:(UIButton *)button{
    if (self.delegate != nil){
        [self.delegate inPutPwdViewDidCloseDialogView];
    }
}

- (void)didClick_confirmBtn:(UIButton *)button{
    if (self.delegate != nil){
        [self.delegate inPutPwdViewConfirmClicked:_inputPwdTextFiled.text pwdType:_inputPwdType];
    }
}

@end
