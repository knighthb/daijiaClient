//
//  DJOrderDetail.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderDetail.h"
#import "DJOrderStatus.h"

@implementation DJOrderDetail

-(id) init{
    self = [super init ] ;
    if (self ) {
        self.statusList = [[NSMutableArray alloc ] init ] ;
        
        DJOrderStatus *status1 = [[DJOrderStatus alloc ] initWithStatusName:@"司机已确认" time:@"2014-6-18 14:36" location:@"北京市北美国际商务中心" ] ;
        DJOrderStatus *status2 = [[DJOrderStatus alloc ] initWithStatusName:@"司机已就位" time:nil location:nil ] ;
        DJOrderStatus *status3 = [[DJOrderStatus alloc ] initWithStatusName:@"司机已开车" time:nil location:nil ] ;
        DJOrderStatus *status4 = [[DJOrderStatus alloc ] initWithStatusName:@"完成代驾" time:nil location:nil ] ;
        [self.statusList addObject:status1 ] ;
        [self.statusList addObject:status2 ] ;
        [self.statusList addObject:status3 ] ;
        [self.statusList addObject:status4 ] ;
        
        self.currentStatus = ORDER_STATUS_DRIVER_READY        ;
    }
    return self ;
}

-(void) deserialize:(NSDictionary *)map {
 
    
    
    
}


@end
