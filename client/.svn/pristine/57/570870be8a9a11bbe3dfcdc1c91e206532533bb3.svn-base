//
//  DJOrderDetail.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ORDER_STATUS_DRIVER_CONFIRMED = 0,
    ORDER_STATUS_DRIVER_READY ,
    ORDER_STATUS_DRIVING ,
    ORDER_STATUS_COMPLETED,
    ORDER_STATUS_CANCEL
} OrderStatus ;

typedef enum {
    ORDER_COMMENT_TODO = 100,
    ORDER_COMMENT_COMPLETED ,
    ORDER_COMMENT_CLOSED
} OrderCommentStatus ;

@interface DJOrderDetail : NSObject

@property int currentStatus ;

@property ( nonatomic , strong ) NSMutableArray *statusList ;

@property int commentStatus ;

@end
