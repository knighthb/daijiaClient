//
//  DJAppDelegate.m
//  58DaijiaClient
//
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJAppDelegate.h"
#import "DJControlsFactory.h"
#import "DJShareViewController.h"
#import "DJDriveListViewController.h"
#import "DJOrderMainViewController.h"
#import "DJMoreViewController.h"
#import "DJControlsFactory.h"
#import "DJDriverMainViewController.h"
#import "DJPriceViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "BaiduMobStat.h"
#import "DJTabController.h"
#import "LocationManagerUtil.h"


#define QUDAO_TEST @"测试渠道"
#define QUDAO_APPSTORE @"Appstore"


@implementation DJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [self addStatHelper ];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    NSMutableArray *subVCs = [[NSMutableArray alloc ] init ] ;
    driveCon = [[DJDriverMainViewController alloc ]init ];
    [subVCs addObject:driveCon ];
    
    DJOrderMainViewController *orderCon = [[DJOrderMainViewController alloc ]init ];
    [subVCs addObject: orderCon ];
    
    DJPriceViewController *protocol = [[DJPriceViewController alloc ] init ] ;
    [subVCs addObject: protocol ];

    DJShareViewController *share = [[ DJShareViewController alloc] init] ;
    [subVCs addObject: share ];
    DJMoreViewController *moreCon = [[DJMoreViewController alloc ]init ]; //[storyboard instantiateViewControllerWithIdentifier:@"more"]; //
    [subVCs addObject: moreCon ];
    
    self.rootCon = [DJControlsFactory createNavigation: [DJControlsFactory createTab: subVCs ] ] ;
    self.window.rootViewController = self.rootCon;
    [self.window makeKeyAndVisible];

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;//发送请求时在状态栏加一个acttivityIndicator
    
    [self registerSDKs ] ;
    
    locationManagerUtil =[LocationManagerUtil sharedLocationManagerUtil];
    locationManagerUtil.locationManager.delegate = (id)driveCon.delegate;

    
    return YES;
}


-(void) addStatHelper {
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
#ifdef DEBUG
    statTracker.channelId = QUDAO_TEST;//设置您的app的发布渠道
#else
    statTracker.channelId = QUDAO_APPSTORE;//设置您的app的发布渠道
#endif
    
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.enableDebugOn = YES; //打开调试模式，发布时请去除此行代码或者设置为False即可。
    statTracker.logSendInterval = 1; //为1时表示发送日志的时间间隔为1小时,只有 statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch这时才生效。
    statTracker.logSendWifiOnly = NO; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 1;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    
    NSString *adId = @"";
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f){
//        adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
    
    statTracker.adid = adId;
    
    [statTracker startWithAppId:@"fe97bf2530"];//设置您在mtj网站上添加的app的appkey

}

-(void) registerSDKs {
    
    [WXApi registerApp:@"wxc236f2842142a87a" ] ;
    [WeiboSDK registerApp:@"3697621047" ];
    //APP ID：101052525
    //APP KEY：969ea192bac7e0c33d5abd0927ca6047
    _weixinDelegate = [[DJWeixinDelegate alloc ] init] ;
    _weiboDelegate = [[DJWeiboDelegate alloc ] init ] ;
    _qqDelegate = [[DJQQDelegate alloc ] init ] ;
   _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101052525"  andDelegate:_qqDelegate ];
    _tencentOAuth.redirectURI = @"www.58.com";
//    NSArray *_permissions =  [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil] ;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    locationManagerUtil.locationManager.delegate = (id)driveCon.delegate;
    [locationManagerUtil.locationManager stopUpdatingLocation];
    id rootVC = self.rootCon ;
    if ( [ rootVC respondsToSelector:@selector(enterBackground) ]) {
        [ rootVC enterBackground ] ;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

    locationManagerUtil.locationManager.delegate = (id)driveCon.delegate;
    [ locationManagerUtil.locationManager startUpdatingLocation];
    id rootVC = self.rootCon ;
    if ( [ rootVC respondsToSelector:@selector(enterForground) ]) {
        [ rootVC enterForground ] ;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    BOOL returnCode = [WXApi handleOpenURL:url delegate:_weixinDelegate ] ;
    returnCode = returnCode || [WeiboSDK handleOpenURL:url delegate:_weiboDelegate ] ;
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[DJQQDelegate class]];
    returnCode = returnCode || [TencentOAuth HandleOpenURL:url];
    return returnCode ;
}

-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[DJQQDelegate class]];
     return [WXApi handleOpenURL:url delegate:_weixinDelegate ] || [TencentOAuth HandleOpenURL:url] || [WeiboSDK handleOpenURL:url delegate:_weiboDelegate ];
    
}

//-(void) didFailWithError:(NSError *)error{
//    if([driveCon.selectedController isKindOfClass:[DJDriveListViewController class]]){
//        DJDriveListViewController * controller = (DJDriveListViewController *)driveCon.selectedController;
//        [controller.tableView reloadData];
//    }
//}

//-(void) didUpdateLocation{
//    if([driveCon.selectedController isKindOfClass:[DJDriveListViewController class]] &&
//       [driveCon.selectedController respondsToSelector:@selector(refreshData:)]){
//        DJDriveListViewController * controller = (DJDriveListViewController *)driveCon.selectedController;
//        [controller refreshData:controller.data];
//    }
//}


@end
