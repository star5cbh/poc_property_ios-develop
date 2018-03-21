//
//  STDefine.h
//
//
//
//  Created by chenbaohui on 2016/12/14.
//  Copyright © 2016年 peersafe_webet. All rights reserved.
//


#ifndef OneLottery_Define_h
#define OneLottery_Define_h


#ifndef SYSTEM_FONT
#define SYSTEM_FONT(__fontsize__)\
[UIFont systemFontOfSize:__fontsize__]
#endif

#ifndef IMAGE_NAMED
#define IMAGE_NAMED(__imageName__)\
[UIImage imageNamed:__imageName__]
#endif

#ifndef NIB_NAMED
#define NIB_NAMED(__nibName__)\
[UINib nibWithNibName:__nibName__ bundle:nil]
#endif


#define Height_NavContentBar 44.0f

#define Height_StatusBar (IS_IPHONE_X==YES)?44.0f: 20.0f

#define Height_NavBar  (IS_IPHONE_X==YES)?88.0f: 64.0f

#define Height_TabBar  (IS_IPHONE_X==YES)?83.0f: 49.0f

//#define kAmoutPrecision                             4
#define kAmoutLengthLimit                           30

#define kGetListPageCount                           15

#define ZXC_MONEY_MULTIPLE                          @"1000000"    //数据库和传到底层的金额倍数，需要实际金额*10000
#define kLeftPadding                                15
#define kAppMainColor                               RGBACOLOR(42, 47, 80, 1)
#define kAppMainWhiteColor                          RGBACOLOR(255, 255, 255, 1)
#define kAppMainBlackColor                          RGBACOLOR(50, 50, 50, 1)
#define kAppMainRedColor                            RGBACOLOR(223, 98, 139, 1)
#define kAppMainTextRedColor                        RGBACOLOR(255, 86, 86, 1)
#define kAppMainTextGreenColor                      RGBACOLOR(0, 156, 104, 1)

#define kAppMainNumRedColor                         RGBACOLOR(247, 104, 147, 1)
#define kAppMainGrayColor                           RGBACOLOR(216, 216, 216, 1)
#define kAppMainBlueColor                           RGBACOLOR(134, 186, 248, 1)
#define kAppMainLineAndTextColor                    RGBACOLOR(107, 116, 173, 1)
#define kAppAccountAlphaTextColor                   RGBACOLOR(107, 116, 173, 0.6)
#define kAppMainBtnNormalColor                      RGBACOLOR(56, 66, 102, 1)
#define kAppMainBtnFocusColor                       RGBACOLOR(45, 53, 82, 1)
#define kAppDestructiveBtnFocusColor                RGBACOLOR(84, 91, 135, 1)
#define kAppTabBarColor                             RGBACOLOR(49, 55, 93, 1)
#define kTransferTitleTextColor                     RGBACOLOR(105, 114, 170, 1)

// 对象非空判断赋值
#define Render_Nil_Obj_Value(key,nilValue) (([(key) isEqualToString:@""] || key == nil || [key isKindOfClass:[NSNull class]]) ? nilValue : key)

#define kAlphaNum                                   @".0123456789"

//data v2接口的服务器地址@"https://data.ripple.com/"

#define kV2BaseUrl                                  @"https://v2api.chainsql.net/"

//业务服务器的地址，例如取费率，资产记录等
#define kPeerSafeBaseUrl                            @"https://zxapi.chainsql.net/"

//chainsql服务器地址
#define kWebSocketUrl                               @"wss://wsapi.chainsql.net"

//费率标准url
#define kFeeStandUrl                                @"http://wallet.chainsql.net/charge%20-%20app.html"

//许可协议url
#define kAgreementLicenceUrl                        @"http://wallet.chainsql.net/User%20protocol%20-%20app.html"

//货币符号定义
#define kRMB                                        @"CNY"
#define kZXC                                        @"ZXC"

#define kZXCOfficalWalletId                         @"zP4pQENuedDKTe2BhMVVsYECesBsjczsfq"


#define kDropDownCellTag                            11111

//账号激活最小的转账xrp数目
#define kMinimumActiveRippleNum                      31

//1个zxc币对应的drop值
#define kOneZXCForDropNum                           1000000

#define kBeeCloudKey                                @"ac84e81e-d1b6-46f6-a074-3090d1feb5d5"
#define kBeeCloudSecret                             @"dc94902b-6262-4f19-b9a1-c7cdeb9728c3"

#define WidthScale                                  Main_Screen_Width/750.0

#define HeightScale                                 ((IS_IPHONE_X==YES) ? (Main_Screen_Height/1624.0) : (Main_Screen_Height/1334.0))

#define kEnterForegroundNotify                      @"kEnterForegroundNotify"

#define kGetCurrencyInfoResultNotify                @"kGetCurrencyInfoResultNotify"

#define kNetworkChangedNotification                 @"wbNetworkChangedNotify"

#define kAccountLogoutNotify                        @"kAccountLogoutNotify"

//挂单变化的通知
#define kOrderChangeNotify                          @"kOrderChangeNotify"
#define kOrderTakerGetsCurrency                     @"kOrderTakerGetCurrency"
#define kOrderTakerPaysCurrency                     @"kOrderTakerPaysCurrency"

#define kAccountCurrencyChangeInfoType              @"curreyInfoType"

#define kAccountOrderChangeNotify                   @"kAccountOrderChangeNotify"

#define kWebSocketFailNotify                        @"kWebSocketFailNotify"
#define kWebSocketSuccessNotify                     @"kWebSocketSuccessNotify"


#define KLaunchAppCount                             @"launchAppCount"
#define KBuildCount                                 @"buildAppCount"

#define BANNER_GET_URL                              @"http://oneadmin.peersafe.cn/getBanner"
#define BANNER_IMAGE_URL_PREFIX                     @"http://oneadmin.peersafe.cn/banner/"

//导入导出相关的key值
#define kImOrExportProcDir                          @"tempProcImOrExport"
#define kUserExtraInfoDir                           @"user_extra_info"
#define kImOrExportICloudWorkDir                    @"Documents/wallet"

#define kSharePrefixUrl                             @"http://oneadmin.peersafe.cn"

//misc表只有一条，每次更新或者插入表使用同样的主键
#define RLMMiscPrimaryKey                           @"RLMMiscId"

//货币对涨跌幅的精度
#define kRiseOrFallRangePrecision                   4
#define kRiseOrFallRangePercentPrecision            2

typedef enum : NSUInteger {
    STNetWorkAccessWifi                             = 1,
    STNetWorkAccess2G                               = 2,
    STNetWorkAccess3G                               = 3,
    STNetWorkAccess4G                               = 4,
    STNetWorkAccessUnknow                           = 5,
} STNetWorkAccess;


typedef enum : NSUInteger {
    ZXGetCurrencyInfoStatusFail                     = -1,
    ZXGetCurrencyInfoStatusGeting                   = 0,
    ZXGetCurrencyInfoStatusSuccess                  = 1,
} ZXGetCurrencyInfoStatus;

typedef enum : NSUInteger {
    ZXConnectStatusNoNetWork                        = -1,
    ZXConnectStatusBothNotConnect                   = 1,
    ZXConnectStatusNotConnectToWeb                  = 2,
    ZXConnectStatusNotConnectToHttp                 = 3,
    ZXConnectStatusConnectingToWeb                  = 4,
    ZXConnectStatusConnectBoth                      = 5,
    
} ZXConnectStatus;

typedef NS_ENUM(NSUInteger, InputPWDType) {
    InputPWDTypeCreate                              = 0,                //创建活动
    InputPWDTypeEdit                                = 1,                //修改活动
    InputPWDTypeOfferConfirm                        = 2,                //订单确认
    InputPWDTypeOfferCancel                         = 3,                //撤单
    InputPWDTypeTransfer                            = 4,                //转账
    InputPWDTypeDeleteUser                          = 5,                //删除用户
    InputPWDTypeLogin                               = 6,                //登录
    InputPWDTypeWithdrawApplying                    = 7,                //提现申请
    InputPWDTypeWithdrawConfirm                     = 8,                //提现确认
    InputPWDTypeWithdrawAppeal                      = 9,                //提现申诉
    InputPWDTypeExportByICloud                      = 10,               //钱包以icloud导出
    InputPWDTypeImportByICloud                      = 11,               //钱包以icloud导入
};

typedef NS_ENUM(NSUInteger, ZxConfirmType) {
    ZxConfirmTypeCreate                             = 0,                //创建
    ZxConfirmTypeCancel                             = 1,                //取消
};

typedef NS_ENUM(NSUInteger, SimpleWaitingDialogType) {
    SimpleWaitingDialogTypeWithdraw                 = 0,                //提现
    
};


typedef NS_ENUM(NSUInteger, TransactionType) {
    TransactionTypeTransferToOther                  = 1,                //转账给他人
    TransactionTypeRecvTransfer                     = 2,                //他人给我转账
    TransactionTypeRecvRecharge                     = 3,                //充值（官方给我转账）
    TransactionTypeGetUserInfo                      = 4,                //查询信息
    TransactionTypeGetBalance                       = 5,                //查余额
    TransactionTypeGetTXs                           = 6,                //查交易记录
    TransactionTypeSubmit                           = 7,                //submit结果
    TransactionTypeGetOffers                        = 8,                //查询订单
    TransactionTypeGetAccountOffers                 = 9,                //查询自己的订单
    TransactionTypeGetPrice                         = 10,                //查询市价
    TransactionTypeCloseGetPrice                    = 11,                //关闭查询市价
    TransactionTypeMarketPriceBuy                   = 12,                //市价买
    TransactionTypeListenOrderBook                  = 13,                //监听订单的通知
    TransactionTypeListenAccountInfo                = 14,                //监听账户交易的通知
    TransactionTypeUnListenAccountInfo              = 15,                //取消监听账户交易的通知
    TransactionTypeListenServerInfo                 = 16,                //监听服务器和账单交易变化的通知
    TransactionTypeGetServerInfo                    = 17,                //获取chainsql节点信息
};

typedef NS_ENUM(NSUInteger, TransMode) {
    TransModeByOffer                                 = 0,                //限价交易
    TransModeByPath                                  = 1,                //市价交易
};

typedef NS_ENUM(NSUInteger, WithdrawPlatform) {
    WithdrawPlatformWechat                          = 1,                //微信平台
    WithdrawPlatformAlipay                          = 2,                //支付宝平台
};

typedef NS_ENUM(NSUInteger, ErrorType) {
    ErrorTypeNone                                   = 0,                //成功
    ErrorTypeFailed                                 = 1,                //一般失败情况
    ErrorTypeJsonFormatError                        = 2,                //json格式错误
    ErrorTypeJsonActNotFound                        = 18,               //账号未找到
    ErrorTypeSocketNotConnect                       = 20,               //socket未连接
};

typedef NS_ENUM(int, CurrencyTrend) {
    CurrencyTrendRise                               = 0,                //上升
    CurrencyTrendDown                               = 1,                //下降
    CurrencyTrendKeep                               = 2,                //不变
};

typedef NS_ENUM(NSInteger, FeeType) {
    FeeTypeTransaction                               = 0,
    FeeTypeWithdraw                                  = 1,
};

typedef NS_ENUM(NSInteger, TransModelType) {
    TransModelTypeBuy                                 = 0,
    TransModelTypeSale                                = 1,
    TransModelTypelist                                = 2,
};

typedef NS_ENUM(NSInteger, ActivateStateType) {
    ActivateStateTypeCreateFail                             = -5,
    ActivateStateTypeNotCreate                              = -4,
    ActivateStateTypeCreating                               = -3,
    ActivateStateTypeCreated                                = -2,
    
    ActivateStateTypeActiveFail                             = -1,
    ActivateStateTypeNotActive                              = 0,
    ActivateStateTypeActiving                               = 1,
    ActivateStateTypeActivated                              = 2,
    
    ActivateStateTypeTrustFail                              = 3,
    ActivateStateTypeNotTrust                               = 4,
    ActivateStateTypeTrusting                               = 5,
    ActivateStateTypeTrusted                                = 6,
    
};

typedef NS_ENUM(NSInteger, NoNetShowType) {
    NoNetShowTypeNotShow                                   = -1,
    NoNetShowTypeShowBottom                                = 0,
    NoNetShowTypeShowMiddle                                = 1,
    NoNetShowTypeShowBoth                                  = 2,
    NoNetShowTypeShowFirstTime                             = 3,
    
};

typedef NS_ENUM(NSInteger, CurrencyTrustState) {
    
    CurrencyTrustStateTrustFail                              = -1,
    CurrencyTrustStateNotTrust                               = 0,
    CurrencyTrustStateTrusting                               = 1,
    CurrencyTrustStateTrusted                                = 2,
    
};

typedef NS_ENUM(NSInteger, WithdrawState) {
    WithdrawStateWaiting                                     = 0,
    WithdrawStateScuess                                      = 1,
    WithdrawStateFail                                        = 2,              //失败
    WithdrawStateRefound                                     = 3,              //已退款
    
};

typedef NS_ENUM(NSInteger, PeerSafeServerRespCode) {
    PeerSafeServerRespCodeSuccess                            = 10000,  //成功
    PeerSafeServerRespCodeRecNotFound                        = 10001,  //查询记录未找到
    PeerSafeServerRespCodeInsertErr                          = 10002,  //插入数据失败
    PeerSafeServerRespCodeDuplicateErr                       = 10003,  //用户名已被注册
    PeerSafeServerRespCodeParaErr                            = 10004,  //参数错误
    PeerSafeServerRespCodeSignErr                            = 10005,  //签名错误
//    PeerSafeServerRespCodeDelErr                             = 10006,  //删除ac人品;查询r't'x
    PeerSafeServerRespCodeInvalidWalletErr                   = 10007,  //无效钱包地址
    PeerSafeServerRespCodeDuplicateDeviceErr                 = 10008,  //设备id 注册超限m4
    PeerSafeServerRespCodeHasRegErr                          = 10009,  //注册传送的同样的用户名和钱包地址的用户已被注册
};

#endif
