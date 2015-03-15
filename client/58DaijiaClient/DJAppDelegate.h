//
//  DJAppDelegate.h
//  58DaijiaClient
//
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"
#import "WeiboSDK.h"
#import "DJWeiboDelegate.h"
#import "DJWeixinDelegate.h"
#import "DJQQDelegate.h"
#import "LocationManagerUtil.h"
#import "DJDriverMainViewController.h"
@class DJTabController;

@interface DJAppDelegate : UIResponder <UIApplicationDelegate >{
    DJWeixinDelegate *_weixinDelegate ;
    DJWeiboDelegate *_weiboDelegate ;
    DJQQDelegate *_qqDelegate ;
    TencentOAuth *_tencentOAuth;
    LocationManagerUtil * locationManagerUtil;
    DJDriverMainViewController *driveCon;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *rootCon;
@end
