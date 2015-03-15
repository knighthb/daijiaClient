//
//  DJOrderModel.m
//  58DaijiaClient
//  订单model
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderModel.h"

@implementation DJOrderModel
@synthesize driverName;
@synthesize position;
@synthesize time;
@synthesize driverPhoneNum;
@synthesize orderId;
@synthesize dPrice;
@synthesize acctualPrice;
-(id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void) setState:(int)orderState
{
    state = orderState;
}

//-(void) setTotalPrice:(float)price
//{
//    totalPrice =  price;
//}

-(int) state
{
    return state;
}

-(DJOrderModel *) transferDicToOrder:(NSDictionary * ) dic
{
    DJOrderModel * order = [[DJOrderModel alloc] init];
    order.time = [dic objectForKey:@"orderstarttime"];
    order.state = [[dic objectForKey:@"orderstate"] integerValue];
    order.driverPhoneNum = [dic objectForKey:@"clienttele"];
    order.totalPrice = [dic objectForKey:@"price"];
    order.position = [dic objectForKey:@"clientlocal"];
    order.already_comment = [[dic objectForKey:@"already_comment"] boolValue];
    order.comment_closed_state = [[dic objectForKey:@"comment_closed_state"] boolValue];
    order.acctualPrice = [dic objectForKey:@"actualprice"];
    order.dPrice = [dic objectForKey:@"dprice"];
    order.orderId = [[dic objectForKey:@"orderid"] longLongValue];
    if ([dic objectForKey:@"driver_name"]== [NSNull null]) {
        order.driverName = @"张师傅";
    }else
        order.driverName = [dic objectForKey:@"driver_name"];
    return order;
}

@end
