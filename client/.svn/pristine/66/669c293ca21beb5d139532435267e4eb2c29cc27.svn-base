//
//  DJAllOrderListViewController.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJAllOrderListViewController.h"
#import "DJControlsFactory.h"
#import "DJLoginUtil.h"
#import "DJTabController.h"
@interface DJAllOrderListViewController ()

@end

@implementation DJAllOrderListViewController
//@synthesize order;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"全部订单" ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.data = [[NSMutableArray alloc] init];
//    self.order = [[DJOrderModel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *) refreshData:(NSMutableArray *)data
{
    [data removeAllObjects];
    page = 1;
    NSString * url = [NSString stringWithFormat:@"%@type=2&page=1&pagesize=%d&r=%d",self.baseUrl,DJ_PAGE_SIZE,arc4random()];
    if ( requestOperation != nil ) {
        [requestOperation cancel ];
    }
    requestOperation = [DJAFNetworkingUtil sendJsonHttpRequest:url data:data delegate:self];
    return data;
}


- (NSMutableArray *) loadMoreData:(NSMutableArray *)data page:(int)page
{

    NSString * url = [NSString stringWithFormat:@"%@type=2&page=%d&pagesize=%d&r=%d",self.baseUrl,page,DJ_PAGE_SIZE,arc4random()];
    if ( requestOperation != nil ) {
        [requestOperation cancel ];
    }
    requestOperation = [DJAFNetworkingUtil sendJsonHttpRequest:url data:data delegate:self];
    return data;
}



#pragma mark - AFNProcessDelegate implementions
-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data
{
//    NSDictionary * order = (NSDictionary *) JSON;
//    NSArray * moreData = [order objectForKey:@"data"];
//    if ([moreData isKindOfClass:[NSArray class]]) {
//        [data addObjectsFromArray:moreData];
//        [self.tableView reloadData];
//    }
//    else{
//        [DJControlsFactory showError:@"加载出错啦"];
//    }
    [self stopLoadingAnimation ] ;
    if ( ! _isActive ) { //当前视图已经不在活跃
        // viewController is visible
        return ;
    }
    
    NSDictionary * order = (NSDictionary *) JSON;
    int code = [[order objectForKey:@"code"] integerValue];
    switch (code) {
        case 0:
        {
            NSArray * moreData = [order objectForKey:@"data"];
            if ([moreData isKindOfClass:[NSArray class]]) {
                if ([moreData count] > 0) {
                    [data addObjectsFromArray:moreData];
                }
            }
            else{
                [DJControlsFactory showError:@"加载出错啦"];                
            }
            [self.tableView reloadData];
            [DJConst setCanRefresh:YES];
            
        }
            break;
        case 13:{
            [DJLoginUtil login:[DJTabController shareInstance] tilte:@"订单" delegate:self];
            [DJConst setCanRefresh:NO];
        }
            break;
        default:
            break;
    }
    if ( _DJDEBUGGER ) {
        NSLog(@"respose :%@",JSON);
    }
}




-(void) processAFNErrorResult:(NSURLRequest *)request
                     response:(NSHTTPURLResponse *)response
                        error:(NSError *)error
                         json:(id) JSON
{
    if ( _DJDEBUGGER ) {
        NSLog(@"全部订单，请求失败:%@",error);
    }
    [self.tableView reloadData ];

    [self stopLoadingAnimation ] ;

}


-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews ] ;
        
}

@end
