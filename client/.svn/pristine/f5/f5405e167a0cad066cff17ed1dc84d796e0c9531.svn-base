//
//  DJOrderListBaseViewController.m
//  58DaijiaClient
//  订单基类视图控制器
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderListBaseViewController.h"
#import "DJControlsFactory.h"
#import "DJConst.h"
#import "DJOrderCell.h"
#import "DJevaluationViewController.h"
#import "DJUIUtils.h"
#import <HuangyeLib/ProgressHUD.h>
#import "DJTabController.h"
#import "DJOrderDetailVC.h"

@interface DJOrderListBaseViewController (){
   /**
     *first是判断第一次是否刷新的标识，在addHeader和viewVillAppear中都有包含refreshData的调用
     *为了防止在第一进入订单列表时重复发送http请求而造成服务器压力与数据混乱,所以使用first来标识
     *first在viewDidAppear里面初始化，初始为YES，第一次进入订单列表时addHeader里面的refreshData不会被调用
     *而去调用viewWillAppear里面的refreshData，在addHeader里面会随后设置为NO，这样不会影响下拉刷新功能
    */
    BOOL first;

}

@end
@implementation DJOrderListBaseViewController
@synthesize order;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        initialized = false ;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        initialized = false ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    page = 1;
    first = YES;
    self.data = [[NSMutableArray alloc] init];
    self.order = [[DJOrderModel alloc] init];
    [self addHeader];
    [self addFooter];
    self.view.backgroundColor = [ DJControlsFactory getBackgroundColor ];
    if ( IsIOS7 ) {
        self.edgesForExtendedLayout = UIRectEdgeAll ;
        UIEdgeInsets inset =self.tableView.contentInset;
        inset.bottom = 48 ;
        inset.top = 64;
        self.tableView.contentInset  = inset ;
    }
    [self startLoadingAnimation ] ; //视图第一次加载时要呈现加载等待界面
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

-(void) startLoadingAnimation {
    
    [ProgressHUD show:@"正在加载，请稍候" ] ;
    
}

-(void) stopLoadingAnimation {
    
    [ProgressHUD dismiss ] ;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    self.baseUrl = [NSString stringWithFormat:@"%@/guest/order/list?mobile=%@&",BASE_URL,self.userPhone];
    if ( [DJConst canRefresh]) {
        /**canRefresh是订单列表能否刷新的标识
          * canRefresh = NO 发生在登录页面按取消时，主要是防止点取消后会重复弹出登录框
          * canRefresh初始是YES，在DJConst里面初始化的
         */
        [self refreshData:self.data];
    }
    [DJConst setCanRefresh:YES];
    _isActive = YES ;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated ] ;
    _isActive = NO;
    [requestOperation cancel ] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if ([self.data count]==0) {
        return 1;
    }else
        return [self.data count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( ! initialized ) {
        //这是第一次进来，
        //此时应该展示加载界面
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loading"];
        cell.backgroundColor = [ DJControlsFactory getBackgroundColor ] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        initialized = YES ;
        return cell ;
    }
    
    if ([self.data count]==0) {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"empty"];
        if (cell==nil) {
                        //创建并初始化没司机视图，下次会使用
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"empty"];
            cell.contentView.layoutFrame = [[CUSFillLayout alloc ] init ] ;
            CGRect frame = self.tableView.frame;
            frame.size.width = [DJUIUtils getWindowWidth] ;
            UIView *emptyView = [DJControlsFactory createEmptyView:frame image:@"无订单" title:@"您还没有相关的订单" description:@""];//暂时没有相关数据
            [cell.contentView addSubview: emptyView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    NSDictionary * dic = [self.data objectAtIndex:indexPath.row];
    order = [order transferDicToOrder:dic];
    NSString * CellIdentifier = @"orderCell";
    if (order.state == FINISH) {
        if (!order.comment_closed_state) {
            if (order.already_comment) {
                CellIdentifier = @"already_commentCell";
            }else
            {
                CellIdentifier = @"finishOrderCell";
            }
        }
        else
            CellIdentifier = @"comment_closedOrderCell";
    }
    DJOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DJOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier order:order] ;
    }
    cell.stateLabel.text = [DJEnumUtil orderStateDescByState:order.state];
    NSString * driverTitle = [[cell.driverName.text componentsSeparatedByString:@":"] objectAtIndex:0];
    cell.driverName.text = [NSString stringWithFormat:@"%@:%@",driverTitle,order.driverName];
    NSString * positionTitle = [[cell.position.text componentsSeparatedByString:@":"] objectAtIndex:0];
    cell.position.text = [NSString stringWithFormat:@"%@:%@",positionTitle,order.position];
    cell.timeText.text = order.time;
    if ( order.state == REFUSE) {
        cell.stateLabel.textColor = HexToUIColorRGB(0x8d8d8d);
    }
    if (order.state == FINISH) {
        [cell showCommentButton:YES ] ;
        cell.priceLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        cell.priceLabel.text  =  [NSString stringWithFormat:@"¥%@ (总额¥%@ 优惠¥%@)",order.acctualPrice,order.totalPrice,order.dPrice];
        cell.commentButton.tag = indexPath.row;

        if (!order.comment_closed_state) {
            if (!order.already_comment) {
//                cell.commentButton.tag = indexPath.row;
                [cell.commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{ //订单关闭，删除评价按钮以及状态文本
            [cell showCommentButton:NO ] ;

        }
    }
    [cell.phoneButoon setTitle:order.driverPhoneNum forState:UIControlStateNormal];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.data count]==0) {
        return self.tableView.frame.size.height;
    }
    int state = [[[self.data objectAtIndex:indexPath.row] objectForKey:@"orderstate"] integerValue];
    if ( state == FINISH) {
        return ORDER_CONTENT_FINISH_CELL_HEIGHT;
    }
    else
        return ORDER_CONTENT_CELL_HEIGHT;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DJOrderModel *order1 =  [self.data objectAtIndex:indexPath.row ] ;
    DJOrderDetailVC *detail = [[DJOrderDetailVC alloc ] initWithOrder:order1 ] ;
    
    [self.navigationController pushViewController:detail animated:YES ] ;
}

-(void) setPage:(int)mypage
{
    self.page = mypage;
}

-(int) page
{
    return self.page;
}


- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //向服务器发送请求下一页数据
        page++;
        if (!first) {
            [self loadMoreData:self.data page:page];
        }
        first = NO;
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}

- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
//    [DJConst setCanRefresh:NO];
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        //清除所有数据，然后重新向服务器请求数据，填充数据
        if (!first) {
            [self refreshData:self.data];
        }
        first = NO;
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

-(IBAction)comment:(id)sender
{
    NSLog(@"comment");
    UIButton * button;
    if ([sender isKindOfClass:[UIButton class]]) {
        button =  (UIButton *) sender;
       NSDictionary * dic = [self.data objectAtIndex:button.tag];
        [self.navigationController pushViewController:[[DJevaluationViewController alloc]initWithOrderId:[[dic objectForKey:@"orderid"] longLongValue]] animated:YES];
    }
}

#pragma mark 登录页面取消回调
-(void)loginViewController:(DJLoginViewController *)vc didExitWithCode:(DJLoginState)state
{
    //登录页面点击取消按钮之后，一般是userPhone ＝nil，重新确认一下，如果是空的则把当前数据清空，再刷新talbeView
    //防止用户在查看更多页面退出登录之后,切换到订单页面进入登录页面时取消登录后可能会显示之前用户的订单数据
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * phone = [userDefaults objectForKey:@"userPhone"];
    if(phone==nil)
    {
        [self.data removeAllObjects];
        [self.tableView reloadData];
    }
    //取消登录，返回刚才的界面
    if ( state != DJLOGINSTATESUCESS ) {
        DJTabController *tab = [DJTabController shareInstance ] ;
        [tab showPrevious ];
    }
    
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
@end
