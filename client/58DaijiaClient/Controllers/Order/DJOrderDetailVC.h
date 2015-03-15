//
//  StrechCellViewController.h
//  Demos
//
//  Created by 周文杰 on 14-6-10.@property (strong , nonatomic) //  Copyright (c) 2014年 周文杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJOrderModel.h"
#import "DJOrderDetail.h"
#import "DJOrderProviderFactory.h"


@interface DJOrderDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *statusList ;

    NSMutableArray *heights ;
    
    NSInteger _currentExtend ;
    
    UIView *driverView ;
    
    id<DJOrderTableProvider> tablePart ;
}

@property (strong , nonatomic) DJOrderModel *order ;

@property (strong , nonatomic) DJOrderDetail *model ;

-(id) initWithOrder:(DJOrderModel *) order ;

@end
