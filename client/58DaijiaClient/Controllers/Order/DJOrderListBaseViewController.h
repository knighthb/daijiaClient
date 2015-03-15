//
//  DJOrderListBaseViewController.h
//  58DaijiaClient
//  订单基类视图控制器
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJTableViewCellUtil.h"
#import "MJRefresh.h"
#import "DJLoginViewController.h"



@interface DJOrderListBaseViewController : UITableViewController<DJLoginViewControllerDelegate>
{
    int page;
    BOOL initialized ;
    
@protected
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    __volatile BOOL _isActive ;
    AFJSONRequestOperation *requestOperation ;
}
@property (nonatomic, strong) NSString * baseUrl;
@property (strong ,nonatomic) NSMutableArray * data;
@property (nonatomic, strong) DJOrderModel * order;
@property (nonatomic, strong) NSString * userPhone;
//@property (nonatomic ,assign) BOOL canRefresh;
-(NSMutableArray *) loadMoreData:(NSMutableArray *) data page:(int) page;
-(NSMutableArray *) refreshData:(NSMutableArray *) data;
-(void) setPage : (int) page;
-(int) page;
-(void) stopLoadingAnimation ;

@end
