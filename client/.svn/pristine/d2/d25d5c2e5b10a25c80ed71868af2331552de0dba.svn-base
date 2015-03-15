//
//  DJCupponsModel.h
//  58DaijiaClient
//
//  Created by huangbin on 14-4-11.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 public static int init_state = 0;//正常
 public static int expiration_state = 1;//过期
 public static int used_state = 2;//已使用
 public static int bind_state = 3;//已绑定
 public static int distory_state = 4;//待销毁
 */
static const int INIT_STATUS = 0;
static const int EXPIRATION_STATUS = 1;
static const int USED_STATUS = 2;
static const int BIND_STATUS = 3;
static const int DISTORY_STATUS = 4;


@interface DJCupponsModel : NSObject
{
    float amount;//优惠券价格
    int state;//优惠券状态
}
@property (nonatomic, strong) NSString * useTime;//使用时间
@property (nonatomic, strong) NSString * expireTime;//过期时间
@property (nonatomic, strong) NSString * typeName;//优惠券名
@property (nonatomic, strong) NSString * code;//优惠券码
-(float) amount;
-(int) state;
-(void) setAmount:(float) amout;
-(void) setState:(int) state;
@end
