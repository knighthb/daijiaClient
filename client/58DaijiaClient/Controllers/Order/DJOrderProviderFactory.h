//
//  DJOrderProviderFactory.h
//  58DaijiaClient

// 订单详情的列表提供器的工厂，
// 生产两种列表提供器：完成订单的列表提供器、未完成订单的列表提供器
// DJOrderTableProvider接口是所有列表提供器的接口

//  Created by 周文杰 on 14-6-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>


static const CGFloat HEITH_LOW_CELL = 46.0f;
static const CGFloat HEITH_NORMAL_CELL = 70.0f;
static const CGFloat HEITH_EXTENTED_CELL = 260.0f;


@class DJOrderDetail ;

@protocol DJOrderTableProvider <NSObject>

-(int) numberOfSection ;

-(int) numberOfRowInSection:(int) section ;

-(CGFloat ) heightOfRow:(int) row inSection:(int) section ;

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath ;

@optional
-(UIView *) viewForFooterInSection:(NSInteger)section ;

@end

@interface DJOrderProviderFactory : NSObject

+(id<DJOrderTableProvider>) getTableProvider:(DJOrderDetail *) order delegate:(id) delegate ;

@end


