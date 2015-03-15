//
//  DJConst.h
//  58DaijiaClient
//
//  Created by 58 on 14-4-3.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


#define _DJDEBUGGER YES

@class DJConst;

static  DJConst * instance = nil;
static BOOL canRefresh = YES;
static BOOL canReturn = YES;
static  NSString *  const BASE_URL = @"http://daijiabox.test.58v5.cn/api" ; // @"http://daijia.58.com/api" ;//
@interface DJConst : NSObject


+(DJConst *) getDJConstInstance;
+(BOOL) canRefresh;

+(void) setCanRefresh:(BOOL) flag;

+(BOOL) canReturn;

+(void) setCanreturn:(BOOL) flag;

typedef enum orderState {
  INIT = 0,
  CONFIRM,
  REFUSE,
  TIMEOUT,
  ATPOSITION,
  DRIVING,
  FINISH
} orderState;

typedef enum cupponState{
   UNUSED = 0,//未使用
   EXPIRATION,//过期
   USED,//已使用
   BIND,//已绑定
   DESTROY//待销毁
} cupponState;

typedef enum loginType{
    LOGIN = 0,
    REGIST
} loginType;

@property (strong) CLLocation * location;


@end
