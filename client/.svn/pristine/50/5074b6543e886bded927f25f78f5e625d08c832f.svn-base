//
//  DJEnumUtil.m
//  58DaijiaClient
//  枚举工具类
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJEnumUtil.h"
#import "DJCupponsModel.h"

@implementation DJEnumUtil
+(NSString *) orderStateDescByState:(orderState) State
{
    switch(State){
        case CONFIRM : return @"司机已确认";
        case REFUSE : return @"已取消";
        case TIMEOUT : return @"超时关闭";
        case ATPOSITION : return  @"司机已就位";
        case DRIVING : return @"司机已开车";
        case FINISH : return  @"完成代驾";
        default: return @"超时关闭";
    }
}

+(NSString *) cupponStateDescByState:(cupponState) state
{
    switch (state) {
        case UNUSED: return @"未消费";
        case USED: return @"已消费";
        case EXPIRATION: return @"已过期";
        case BIND: return @"绑定";
        case DESTROY: return @"待销毁";
        default: return @"未知";
    }
}


+(NSString *) cupponTimeDescByCuppon:(DJCupponsModel *) cuppon
{
    switch (cuppon.state) {
        case UNUSED:
            return [NSString stringWithFormat:@"有效期 : %@",cuppon.expireTime];
        case USED:
            return [NSString stringWithFormat:@"消费日期 : %@", cuppon.useTime];
        case EXPIRATION:
            return [NSString stringWithFormat:@"过期日期 : %@", cuppon.expireTime];
        default:
            return nil;
    }
}

+(NSString *) tipsByLoginType:(loginType) type{
    switch (type) {
        case LOGIN:
            return @"输入手机号码登录";
        case REGIST:
            return @"为了让司机到达后联系您，请绑定手机";
        default:
            return @"";
    }
}

+(NSString *) buttonTextByLoginType:(loginType) type{
    switch (type) {
        case LOGIN:
            return @"绑定手机并登录";
        case REGIST:
            return @"绑定手机";
        default:
            return @"";
    }
}

+(UIButton *) enventByLoginType:(loginType) type target:(id) target button:(UIButton *)button
{
    switch (type) {
        case LOGIN:
            [button addTarget:target action:@selector(bindAndLogin:) forControlEvents:UIControlEventTouchUpInside];
            return button;
        case REGIST:
            [button addTarget:target action:@selector(bind:) forControlEvents:UIControlEventTouchUpInside];
            return button;
        default:
            return button;
    }
}
@end
