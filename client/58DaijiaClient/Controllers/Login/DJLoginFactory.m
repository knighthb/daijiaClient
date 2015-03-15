//
//  DJLoginFactory.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJLoginFactory.h"
#import "DJLoginViewController.h"
#import "DJLoginViewController2.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static const int MCC_NOCARD = 0 ;

static const int MCC_CHINA = 460 ;

static const int MCC_OTHERS = 1 ;


@implementation DJLoginFactory


+(UIViewController *) newLoginViewControllerWithTitle:(NSString *) title type:(loginType) type delegate:(id) delegate{
    
    
    UIViewController *loginVC ;
    
    if ( [DJLoginFactory isWithinChina ] ) {
        loginVC = [[DJLoginViewController alloc] initWithTitle:title type:type delegate:delegate];

    }else {
        loginVC =  [[DJLoginViewController2 alloc] initWithTitle:title type:type delegate:delegate];

    }
    
    return loginVC ;
}

+(BOOL ) isWithinChina {
    
    if ([ DJLoginFactory getSMSServiceNumber ] == MCC_CHINA ) {
        return true ;
    }else if( [ DJLoginFactory getSMSServiceNumber ] == MCC_NOCARD )
        return true ;
    return  false ;
}

+(NSMutableDictionary*) getSIMServiceProvider
{
    //  用 CTTelephonyNetworkInfo 与 CTCarrier 这两个 class，就可以取得电信商资讯，例如：
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    
    NSMutableDictionary * map = [[NSMutableDictionary alloc]initWithCapacity: 3 ] ;
    NSLog( @"通信提供商是：%@", carrier.carrierName );
    if ( ! carrier.carrierName ) {
        [map setObject:@"-1" forKey:@"ISP_name" ] ;
    }else
        [map setObject:carrier.carrierName forKey:@"ISP_name" ] ;
    
    if ( ! carrier.mobileCountryCode ) {
        [map setObject:@"-1" forKey:@"countryCode" ] ;
    }else
        [map setObject:carrier.mobileCountryCode forKey:@"countryCode" ] ;
    
    if ( ! carrier.mobileNetworkCode ) {
        [map setObject:@"-1" forKey:@"newworkCode" ] ;
    }else
        [map setObject:carrier.mobileNetworkCode forKey:@"newworkCode" ] ;
    return map ;
    //    结果像是：
    
    //    CTCarrier (0x140dc0) {
    //        Carrier name: [中华电信]
    //        Mobile Country Code : [466]
    //        Mobile Network Code:[92]
    //        ISO Country Code:[tw]
    //        Allows VOIP? [YES]
    //    }
}

+(int ) getSMSServiceNumber{
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;

    //////记录移动网络码（MNC）由两位数字组成，用于识别移动用户所归属的移动网。中国移动TD系统使用00，中国联通GSM系统使用01，中国移动GSM系统使用02，中国电信CDMA系统使用03////
//    if ( [carrier.mobileNetworkCode isEqualToString:@"00" ] ) { //中国移动TD
//        return SMS_SERVICE_NUMBER_YI_DONG ;
//    }else if ( [carrier.mobileNetworkCode isEqualToString:@"01" ] ) { //中国联通GSM
//        return SMS_SERVICE_NUMBER_LIAN_TONG ;
//    }else if ( [carrier.mobileNetworkCode isEqualToString:@"02" ] ) { //中国移动GSM
//        return SMS_SERVICE_NUMBER_YI_DONG ;
//    }else if ( [carrier.mobileNetworkCode isEqualToString:@"03" ] ) { //中国电信CDMA
//        return SMS_SERVICE_NUMBER_DIAN_XIN ;
//    }else if( [carrier.mobileNetworkCode isEqualToString:@"65535" ] ) { //中国电信CDMA
//        return @"no card" ;
//    }
    //    NSLog( carrier.mobileNetworkCode ) ; //65535没装卡
    if ( carrier.mobileCountryCode  == nil || carrier.mobileCountryCode.length == 0 ) {
        return MCC_NOCARD ;
    }
    
    if ( [carrier.mobileCountryCode isEqualToString:@"460" ])
        
        return MCC_CHINA ;
    
    return  MCC_OTHERS ;

    
    
}


@end
