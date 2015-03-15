//
//  DJEnumUtil.h
//  58DaijiaClient
//  枚举工具类
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJConst.h"
#import "DJCupponsModel.h"
@interface DJEnumUtil : NSObject
/**
 *  Method : orderStateDescByState:state
 *  Description : 根据订单枚举类返回相应的订单状态描述
 *  Params
 *      state : 订单状态
 *  return : NSString *
 */
+(NSString *) orderStateDescByState:(orderState) State;

/**
 *  Method : cupponTimeDescByCuppon:cuppon
 *  Description : 根据优惠券枚举类返回相应的时间描述
 *  Params
 *      cuppon : 优惠券实体
 *  return : NSString *
 */
+(NSString *) cupponTimeDescByCuppon:(DJCupponsModel *) cuppon;

/**
 *  Method : cupponStateDescByState:state
 *  Description : 根据优惠券枚举类返回相应的状态描述
 *  Params
 *      cuppon : 优惠券状态
 *  return : NSString *
 */
+(NSString *) cupponStateDescByState:(cupponState) state;

+(NSString *) tipsByLoginType:(loginType) type;

+(NSString *) buttonTextByLoginType:(loginType) type;

+(UIButton *) enventByLoginType:(loginType) type target:(id) target button:(UIButton *)button;
@end
