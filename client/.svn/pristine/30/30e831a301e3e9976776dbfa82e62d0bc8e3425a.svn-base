//
//  StrechCellViewController.m
//  Demos
//
//  Created by 周文杰 on 14-6-10.
//  Copyright (c) 2014年 周文杰. All rights reserved.
//

#import "DJOrderDetailVC.h"
#import "DJOrderDetailCell.h"
#import "DJOrderDetailCell2.h"
#import "DJUIUtils.h"
#import "DJOrderStatus.h"
#import "DJStarSlider.h"
#import "DJevaluationViewController.h"
#import "DJControlsFactory.h"

@interface DJOrderDetailVC ()

@end

@implementation DJOrderDetailVC

#pragma mark - View lifecycle

-(id) initWithOrder:(DJOrderModel *) order {
    self = [super init ] ;
    if (self) {
        self.order = order ;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    statusList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  [DJUIUtils getWindowWidth],  [DJUIUtils getWindowHeight]) style:UITableViewStyleGrouped];
    statusList.delegate = self;
    statusList.dataSource = self;
    statusList.separatorStyle = UITableViewCellSeparatorStyleNone ;
    UIEdgeInsets inset ;
    inset.top = 30 ;
    statusList.contentInset = inset ;
    [self.view addSubview:statusList];
        
    driverView = [[UIView alloc] initWithFrame:CGRectMake( 0 , 64 , [DJUIUtils getWindowWidth] , 52 ) ];
    driverView.backgroundColor = [UIColor grayColor] ;
    
    [self.view addSubview:driverView ] ;
    [self.view bringSubviewToFront:driverView ] ;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ] ;
    
    //请求服务器
    self.model = [[DJOrderDetail alloc] init ] ;
    if ( self.model.currentStatus == ORDER_STATUS_DRIVER_CONFIRMED ) { //
        [heights replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:HEITH_EXTENTED_CELL + 20  ]];
    }
    if ( self.model.currentStatus == ORDER_STATUS_DRIVER_READY ) { //
        [heights replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:HEITH_EXTENTED_CELL ]];
    }
    
    tablePart = [DJOrderProviderFactory getTableProvider:self.model delegate:self ] ;
    [statusList reloadData ] ;
}

#pragma mark - uitableview的回调
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [tablePart numberOfSection ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [tablePart numberOfRowInSection:section ];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [tablePart tableView:tableView cellForRowAtIndexPath:indexPath ] ;
   
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [tablePart viewForFooterInSection:section ] ;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    NSInteger row = indexPath.row ;
//    NSMutableArray *rows= [ [NSMutableArray alloc ] init] ;
//
//    if ( _currentExtend >= 0  ) { //当前已经有展开的了
//        NSIndexPath *row1 = [NSIndexPath indexPathForRow:_currentExtend inSection:0 ]  ;
//        [rows addObject:row1 ] ;
//    }
//    if (row == _currentExtend )  //row当前已经展开
//    {
//        [heights replaceObjectAtIndex:row withObject:[NSNumber numberWithFloat: HEITH_NORMAL_CELL ] ] ;
//        _currentExtend = -1 ;
//    }
//    else
//    {
//        [heights replaceObjectAtIndex:row withObject:[NSNumber numberWithFloat:HEITH_EXTENTED_CELL ] ] ; //当前选中行展开
//        if ( _currentExtend >= 0  ) {
//            [heights replaceObjectAtIndex:_currentExtend withObject:[NSNumber numberWithFloat: HEITH_NORMAL_CELL ] ] ; //之前展开的要收起
//        }
//        [rows addObject:indexPath ] ;
//        _currentExtend = row ;
//    }
//
//    [tableView reloadRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationFade ] ;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tablePart heightOfRow:indexPath.row inSection:indexPath.section ] ;
}

-(CGFloat ) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ( section == 1 ) {
        return 140 ;
    }
    return  0 ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  点击星星的回调
-(void) slider:(DJStarSlider*)slider didSelectIndex:(NSInteger) index {
    
    DJevaluationViewController *vc = [[DJevaluationViewController alloc ] initWithOrderId:self.order.orderId ] ;
    [vc setScore:slider.score ] ;
    
}

-(IBAction ) share:(id)sender {
    
    
    
}

@end
