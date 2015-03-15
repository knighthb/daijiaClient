//
//  DJOrderModel.h
//  58DaijiaClient
//  订单model
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJConst.h"
@interface DJOrderModel : NSObject
{
    int state;
//    float totalPrice;
}
@property (nonatomic, strong) NSString * driverName;
@property (nonatomic, strong) NSString * driverPhoneNum;
@property (nonatomic, strong) NSString * position;
@property (nonatomic, strong) NSString * time;
@property (nonatomic) long long orderId;
@property (nonatomic) BOOL already_comment ;

@property (nonatomic) BOOL comment_closed_state ;
@property (nonatomic, strong) NSString * acctualPrice;
@property (nonatomic, strong) NSString * dPrice;
@property (nonatomic, strong) NSString * totalPrice;
/*"price":"0.0","sid":"22553804647937","orderid":"2606026978976","driver_name":"郭宝林","orderstate":"2","clientlocal":"获取地址失败，请电话联系","clienttele":"15201330376","orderstarttime":"2014-04-28 19:43:12","dprice":"0.0","actualprice":"0.0","s1":null,"s2":null,"s3":null,"s4":null,"s5":null,"s6":null,"already_comment":false,"comment_closed_state":false*/

-(void) setState:(int) orderState;
//-(void) setTotalPrice:(float) price;
-(int) state;
//-(float) totalPrice;

-(DJOrderModel *) transferDicToOrder:(NSDictionary * ) dic;
@end
