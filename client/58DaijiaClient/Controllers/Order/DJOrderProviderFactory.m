//
//  DJOrderProviderFactory.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderProviderFactory.h"
#import "DJOrderDetail.h"
#import "DJOrderCompletedTableProvider.h"
#import "DJOrderUncompletedTableProvider.h"


@implementation DJOrderProviderFactory

+(id<DJOrderTableProvider>) getTableProvider:(DJOrderDetail *) order delegate:(id) delegate {

    if ( order == nil ) {
        return  nil ;
    }
    
    if (order.currentStatus == ORDER_STATUS_COMPLETED ) {
        DJOrderCompletedTableProvider * provider = [[DJOrderCompletedTableProvider  alloc] init ];
        provider.model = order ;
        provider.delegate = delegate ;
        return provider ;
    }else{ // (order.currentStatus == ORDER_STATUS_COMPLETED ) {
        DJOrderUncompletedTableProvider * provider = [[DJOrderUncompletedTableProvider  alloc] init ];
        provider.model = order ;
        provider.delegate = delegate ;
        return provider ;
    }
}

@end
