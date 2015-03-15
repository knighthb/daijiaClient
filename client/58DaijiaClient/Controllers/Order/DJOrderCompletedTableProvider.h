//
//  DJOrderTablePartProvider.h
//  58DaijiaClient

//  提供表格的各部分数据，针对完成的订单，

//  Created by 周文杰 on 14-6-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJOrderDetail.h"
#import "DJOrderProviderFactory.h"

@interface DJOrderCompletedTableProvider : NSObject<DJOrderTableProvider>{
    NSArray *heights ;
}

@property (nonatomic, strong ) DJOrderDetail *model ;

@property (nonatomic, strong ) UITableView *tableView ;

@property (nonatomic, weak ) id delegate ;





@end
