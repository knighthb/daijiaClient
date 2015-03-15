//
//  DJCurrentOrderListViewController.m
//  58DaijiaClient
//  当前订单视图控制器
//  Created by huangbin on 14-4-4.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJCurrentOrderListViewController.h"
#import "DJLoginUtil.h"
#import "DJControlsFactory.h"
#import "DJTabController.h"
@interface DJCurrentOrderListViewController (){
    UIView * errorView;
}


@end


@implementation DJCurrentOrderListViewController
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"当前订单" ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (errorView!=nil) {
        [errorView removeFromSuperview];
    }
    else
        errorView = nil;
//    NSArray * array = @[@"a",@"a",@"a",@"a",@"a"];
//    self.data = [[NSMutableArray alloc] initWithArray:array];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *) refreshData:(NSMutableArray *)data
{
    [data removeAllObjects];
    NSString * url = [NSString stringWithFormat:@"%@type=1&page=1&pagesize=%d&r=%d",self.baseUrl,DJ_PAGE_SIZE,arc4random()];
    NSLog(@"order url:%@",url);
    if ( requestOperation != nil ) {
        [requestOperation cancel ];
    }
    requestOperation = [DJAFNetworkingUtil sendJsonHttpRequest:url data:data delegate:self];
    return data;
}

- (NSMutableArray *) loadMoreData:(NSMutableArray *)data page:(int)page
{
    NSString * url = [NSString stringWithFormat:@"%@type=1&page=%d&pagesize=%d&r=%d",self.baseUrl,page,DJ_PAGE_SIZE,arc4random()];
    NSLog(@"all orders url:%@",url);
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
    [self stopLoadingAnimation ];

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
    NSLog(@"%@",error);
    [self.tableView reloadData ];

}


@end
