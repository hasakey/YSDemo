//
//  MacroHeader.h
//  ThinkHome
//
//  Created by ThinkHome on 2018/12/21.
//  Copyright © 2018 ThinkHome. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGB_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:1.0]
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR UIColorFromRGB(0xFFA200)

#define MAINCOLOR RGB_COLOR(255,162,0,1)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v  options:NSNumericSearch] ==  NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define EZOpenAppKey @"399e071bdd9243d99eeb244147002158"
#define EZOpenAPPSECRET @"b5d60ec3dc564414419cd2a3704873d7"

#ifdef DEBUG // 调试状态, 打开LOG功能
#define THLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else // 发布状态, 关闭LOG功能
#define THLog(...)
#endif

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define WeXinAppKey @"wx268cde605ba3e4b0"
#define WeXinAppSecret @"c265d958d2affb4a2cc3929fa564e20e"

//是否为测试版本
#define DevelopmentType 1

#if DevelopmentType == 1//当是测试版本

static NSString * const GROUP_NAME = @"group.com.thinkhome.ios";
static NSString * const APP_TOKEN_VERSION = @"5";
static NSString * const ALI_MAP_KEY = @"e50519607433f17dd4cd48ec90f5b8e6";
static NSString * const UM_APP_KEY = @"5ac1f62ba40fa322d80000c9";
static NSString * const ALI_APP_KEY = @"23393120";
static NSString * const ALI_SECRET_KEY = @"ccd1753311a10e6ba1dc0c3d0801be0a";
static NSString * const SERVICECENTER_URL = @"http://dev-faq.thinkhome.com.cn/#/mobile/index?userID=%@&height=%d";
static NSString * const TH_CLIENT_ID = @"ThinkHome_Client_iOS";
//static NSString * const REQUEST_POST_URL = @"http://101.200.39.154:9005/api/V1/";
static NSString * const REQUEST_POST_URL = @"http://dev-ms.thinkhome.com.cn/api/V1/";
static NSString * const TH_APP_KEY = @"07115481-5c24-4d7b-bb55-b7db6c04db1b";
static NSString * const TH_SECRET_KEY = @"99653855-299e-4949-88f1-d473ac627e0c";
static NSString * const TH_WEBSOCKET_URL = @"ws://dev-wss.thinkhome.com.cn:32012";

#elif DevelopmentType == 2//当是预发布版本

static NSString * const GROUP_NAME = @"group.com.thinkhome.ios";
static NSString * const APP_TOKEN_VERSION = @"5";
static NSString * const ALI_MAP_KEY = @"e50519607433f17dd4cd48ec90f5b8e6";
static NSString * const UM_APP_KEY = @"5ac1f62ba40fa322d80000c9";
static NSString * const ALI_APP_KEY = @"23393120";
static NSString * const ALI_SECRET_KEY = @"ccd1753311a10e6ba1dc0c3d0801be0a";
static NSString * const SERVICECENTER_URL = @"http://faq.thinkhome.com.cn/#/mobile/index?userID=%@&height=%d";
static NSString * const TH_CLIENT_ID = @"ThinkHome_Client_iOS";
static NSString * const REQUEST_POST_URL = @"http://dev-new.thinkhome.com.cn/api/V1/";
static NSString * const TH_APP_KEY = @"00025D96-7388-4E9F-86C2-4D8859FFC762";
static NSString * const TH_SECRET_KEY = @"00046A11-2B04-405C-82DA-60C51E44011D";
static NSString * const TH_WEBSOCKET_URL = @"ws://dev-wss.thinkhome.com.cn:32012";

#else//为待发布版本

static NSString * const GROUP_NAME = @"group.com.ThinkHome.ThinkHome";
static NSString * const APP_TOKEN_VERSION = @"3";
static NSString * const ALI_MAP_KEY = @"b1a1627e0c46a67ef14cb9cffc4adb33";
static NSString * const UM_APP_KEY = @"553ee070e0f55aada7003f09";
static NSString * const ALI_APP_KEY = @"23300013";
static NSString * const ALI_SECRET_KEY = @"708f30aa5b7f3b54e131f4827a19332a";
static NSString * const SERVICECENTER_URL = @"http://faq.thinkhome.com.cn/#/mobile/index?userID=%@&height=%d";
static NSString * const TH_CLIENT_ID = @"ThinkHome_Client_iOS";
static NSString * const REQUEST_POST_URL = @"https://ms.thinkhome.com.cn/api/V1/";
static NSString * const TH_APP_KEY = @"4110f405-58b3-4041-9b71-1af1fbc8f768";
static NSString * const TH_SECRET_KEY = @"8dc5ef1e-97a7-419b-b63b-2a7cdecbb557";
static NSString * const TH_WEBSOCKET_URL = @"ws://wss.thinkhome.com.cn:32012";

#endif


static NSString * const CHECK_EMAIL_SPEC = @"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
//#define CheckNormalImport @"^[A-Za-z0-9\u4E00-\u9FA5' _-]+$"
//#define CheckPassword "^[A-Za-z0-9]+$"
//
//#define BaseTimeFormat @"yyyy-MM-dd HH:mm:ss"

//本地沙盒数据
static NSString * const NOW_ACCOUNT_DATA_KEY = @"NowUser";
static NSString * const NOW_ACCOUNT_INFO_DATA_KEY = @"NowAccountInfo";
static NSString * const ACCOUNT_LIST_DATA_KEY = @"AccountList";
static NSString * const NOW_HOUSE_DATA_KEY = @"NowHouse";
static NSString * const NOW_HOUSE_INFO_DATA_KEY = @"HouseSetitng";
static NSString * const SOUND_INFO_DATA_KEY = @"SoundOpenInfo";
static NSString * const HOMEPAGE_INFO_LIST_DATA_KEY = @"HomePageList";
static NSString * const SPECIALPASSWORD_LIST_DATA_KEY = @"SpecialPasswordList";
static NSString * const LOCATION_VERSION_KEY = @"LocalVersion";
static NSString * const DEVICE_BASE_INFO_KEY = @"DeviceBaseInfo";
static NSString * const DEVICE_BASE_INFO_VERSION_KEY = @"DeviceBaseInfoVersion";

//本地通知

//数据库
static NSString * const HOUSE_TABLE_NAME = @"house";
static NSString * const ROOM_TABLE_NAME = @"rooms";
static NSString * const DEVICE_TABLE_NAME = @"shebei";
static NSString * const TERMINAL_TABLE_NAME = @"terminal";
static NSString * const SENCE_TABLE_NAME = @"changjing";
static NSString * const FLOORPLANS_TABLE_NAME = @"floorplans";
static NSString * const FLOORAREAS_TABLE_NAME = @"floorareas";
static NSString * const FLOOR_TABLE_NAME = @"floor";
static NSString * const DELAY_TABLE_NAME = @"delay";
static NSString * const LONGOPENTIME_TABLE_NAME = @"longOpenTime";

#define LOCATION_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_RATIO SCREEN_WIDTH/375
#define M_WIDTH [[UIScreen mainScreen] bounds].size.width
#define M_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height
#define ChevronFrame(height) CGRectMake(M_WIDTH-28, height/2-7, 8, 14)
#define TitleHeight ([[UIApplication sharedApplication] statusBarFrame].size.height == 44  ?  88 : 64)
#define TabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height == 44  ?  83 : 48)
#define TableViewFooterHeight ([[UIApplication sharedApplication] statusBarFrame].size.height == 44  ?  38 : 1)
#define KeyBoradHeight ([[UIApplication sharedApplication] statusBarFrame].size.height == 44  ?  300 : 230)
#define SwitchHeight 31
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \

NS_ASSUME_NONNULL_BEGIN

@interface MacroHeader : NSObject

@end

NS_ASSUME_NONNULL_END
