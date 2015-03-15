//
//  DJOrderTablePartProvider.h
//  58DaijiaClient

//  提供表格的各部分数据，针对未完成的订单，包括正在进行着的和已关闭的

//  Created by 周文杰 on 14-6-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DJOrderDetail.h"
#import "DJOrderProviderFactory.h"


@interface DJOrderUncompletedTableProvider : NSObject<DJOrderTableProvider>{
    NSMutableArray *heights ;
    int _currentExtend;
}

@property (nonatomic, strong ) DJOrderDetail *model ;

@property (nonatomic, weak ) id delegate ;

-(int) numberOfSection ;

-(int) numberOfRowInSection:(int) section ;

-(CGFloat ) heightOfRow:(int) row inSection:(int) section ;

- (UITableViewCell *) cellForRowAtIndexPath:(NSIndexPath *)indexPath ;


@end
