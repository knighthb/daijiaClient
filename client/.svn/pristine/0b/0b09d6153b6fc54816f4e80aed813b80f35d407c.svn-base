//
//  DJPrevilageViewController.m
//  58DaijiaClient
//  优惠券
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJPrevilageViewController.h"
#import "MJRefresh.h"
#import "DJAFNetworkingUtil.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"
#import "DJPrevilageCell.h"
#import "DJLoginUtil.h"
#import "DJTabController.h"
#import "DJRespAnalyser.h"
#import <HuangyeLib/ProgressHUD.h>

const NSString *COUPON_URL = @"/discount/user/bindcoupon" ;


@interface DJPrevilageViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@end

@implementation DJPrevilageViewController
@synthesize couponList;
@synthesize cuppons;
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"优惠券" ;
        page = 1 ;
        self.data = [[NSMutableArray alloc] init];
        self.cuppons = [[DJCupponsModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.contentView.backgroundColor = [DJControlsFactory getBackgroundColor ] ;
    
    CUSLinnerLayout *layout = [ [CUSLinnerLayout alloc] init ] ;
    layout.marginTop = layout.marginLeft = layout.marginRight = layout.marginBottom = 0 ;
    
    layout.spacing = 0 ;
    self.contentView.layoutFrame = layout ;
    UIView *inputView = [self buildInputView ] ;
    CUSLinnerData *data2 = [[CUSLinnerData alloc ] init ] ;
    data2.height = 50 ;
    inputView.layoutData = data2 ;
    [self.contentView addSubview:inputView ];
    
    //列表
    self.couponList = [[UITableView alloc ] init ] ;
    couponList.backgroundColor = [ DJControlsFactory getBackgroundColor ] ;
    couponList.separatorStyle = UITableViewCellSeparatorStyleNone ;
//    [couponList setTableFooterView:[self buildDescriptionView] ];
    [couponList setDelegate:self];
    [couponList setDataSource:self];
    CUSLinnerData *data1 = [[CUSLinnerData alloc ] init ] ;
    data1.fill = true ;
    couponList.layoutData = data1 ;
    [self.contentView addSubview:couponList ] ;
    
//    self.couponList.userInteractionEnabled = false ;

    [self addFooter];
    [self addHeader];
    self.baseUrl = [NSString stringWithFormat:@"%@/discount/user/couponslist",BASE_URL];
    

    keyboard = [[UIKeyboardViewController alloc ] initWithControllerDelegate:self ] ;
    [keyboard addToolbarToKeyboard];
    
    [self refreshData ] ;
}

-(UIView *) buildDescriptionView{
    if (_desView) {
        return _desView ;
    }
    _desView =  [[UIView alloc ] initWithFrame:CGRectMake(0, 0, [DJUIUtils getWindowWidth], 115) ] ;
    _desView.backgroundColor = [DJControlsFactory getBackgroundColor ] ;
    
    CUSLinnerLayout *layout = [[CUSLinnerLayout alloc ] init] ;
    layout.type = CUSLayoutTypeVertical ;
    layout.marginTop = 10 ;
    layout.marginLeft = layout.marginRight = 10 ;
    layout.spacing = 5 ;
    _desView.layoutFrame = layout ;
    
    UILabel *titleLabel = [DJControlsFactory createLabel:H2 text:@"使用规则说明" ] ;
    CUSLinnerData *data1 = [[CUSLinnerData alloc ] init ];
    data1.height = 24 ;
    titleLabel.layoutData = data1 ;
    [_desView addSubview:titleLabel ] ;
    
    UILabel *rule1 = [DJControlsFactory createLabel:NORMAL_TEXT text:@"1、绑定优惠码后，使用58代驾服务将自动进行优惠处理" ] ;
    CUSLinnerData *data2 = [[CUSLinnerData alloc ] init ];
    data2.width = [DJUIUtils getWindowWidth] - 20 ;
    data2.height = [DJUIUtils getLabelHeight: rule1 forWidth:[DJUIUtils getWindowWidth] - 20 ] + 5 ;
    rule1.layoutData = data2 ;
    rule1.numberOfLines = 2 ;
    [_desView addSubview:rule1 ] ;
    
    UILabel *rule2 = [DJControlsFactory createLabel:NORMAL_TEXT text:@"2、单笔订单最多可使用1张优惠券" ] ;
    CUSLinnerData *data3 = [[CUSLinnerData alloc ] init ];
    data3.width = [DJUIUtils getWindowWidth] - 20 ;
    data3.height =  16 ;
    rule2.layoutData = data3 ;

    [_desView addSubview:rule2 ] ;
    
    UILabel *rule3 = [DJControlsFactory createLabel:NORMAL_TEXT text:@"3、存在多张优惠券时，优先使用面额最大的一张" ] ;
    CUSLinnerData *data4 = [[CUSLinnerData alloc ] init ];
    data4.width = [DJUIUtils getWindowWidth] - 20 ;
    data4.height = 16 ;// [DJUIUtils getLabelHeight: rule1 forWidth:[DJUIUtils getWindowWidth] - 20 ] - 15 ;
    rule3.layoutData = data4 ;
    [_desView addSubview:rule3 ] ;
    
    UILabel *rule4 = [DJControlsFactory createLabel:NORMAL_TEXT text:@"4、7天内只可以享受1次优惠" ] ;
    CUSLinnerData *data5 = [[CUSLinnerData alloc ] init ];
    data5.width = [DJUIUtils getWindowWidth] - 20 ;
    data5.height = 16 ;// [DJUIUtils getLabelHeight: rule1 forWidth:[DJUIUtils getWindowWidth] - 20 ] ;
    rule4.layoutData = data5 ;
    [_desView addSubview:rule4 ] ;
    
    UILabel *rule5 = [DJControlsFactory createLabel:NORMAL_TEXT text:@"5、拨打400客服电话找代驾不享受优惠" ] ;
    CUSLinnerData *data6 = [[CUSLinnerData alloc ] init ];
    data6.width = [DJUIUtils getWindowWidth] - 20 ;
    data6.height = 16   ;
    rule5.layoutData = data6 ;
    [_desView addSubview:rule5 ] ;
    
    UILabel *rule6 = [DJControlsFactory createLabel:NORMAL_TEXT text:@"本活动最终解释权归58同城所有" ] ;
    CUSLinnerData *data7 = [[CUSLinnerData alloc ] init ];
    data7.width = [DJUIUtils getWindowWidth] - 20 ;
    data7.height =  16  ;
    rule6.layoutData = data7 ;
    [_desView addSubview:rule6 ] ;
    
    return _desView ;
}

-(UIView *) buildInputView {
    UIView *largerContainer =[[UIView alloc ] init ] ;
    CUSLinnerLayout *layout1 = [[CUSLinnerLayout alloc ] init ] ;
//    largerContainer.layoutFrame = layout1 ;
    layout1.type = CUSLayoutTypeVertical ;
    layout1.marginLeft = layout1.marginRight = 0 ;
    layout1.marginBottom = layout1.marginTop = 0 ;
    layout1.spacing = 0 ;

    UIView *container = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, [DJUIUtils getWindowWidth], 49) ] ;
    container.backgroundColor = [UIColor whiteColor ] ;
    CUSLinnerLayout *layout = [[CUSLinnerLayout alloc ] init ] ;
    container.layoutFrame = layout ;
    layout.type = CUSLayoutTypeHorizontal ;
     layout.marginLeft = layout.marginRight = 10 ;
    layout.marginBottom = layout.marginTop = 6 ;
    layout.spacing = 5 ;
//    if ( IsIOS7 ) {
//        int top = self.topLayoutGuide.length ;
//        layout.marginTop = top == 0 ? 64 : top ;
//    }
    self.input = [DJControlsFactory createTextFiled:@"请输入优惠券码" delegate:self ] ;//[[UITextField alloc ] init ];
//    self.input.delegate = self ;
//    self.input.layer.cornerRadius = 6.0 ;
//    self.input.layer.borderColor = ([DJControlsFactory getLineColor:DEEP]).CGColor  ;
//    self.input.layer.borderWidth = 1.0 ;
//    self.input.placeholder = ;
    self.input.font = [UIFont systemFontOfSize:14 ];
    self.input.clearButtonMode = UITextFieldViewModeWhileEditing;

    CUSLinnerData *data1 = [[CUSLinnerData alloc ] init ] ;
    data1.fill = true ;
    self.input.layoutData = data1 ;
    [container addSubview: self.input ] ;
    
    UIButton *button  = [DJControlsFactory createControlWithColor:COLOR_ORANGE text:@"绑定" ] ;
    CUSLinnerData *data2 = [[CUSLinnerData alloc ] init ] ;
    data2.width = 65 ;
    button.layoutData = data2 ;
    button.titleLabel.font = [UIFont systemFontOfSize:14 ];
    [button addTarget:self action:@selector(bindCoupon:) forControlEvents:UIControlEventTouchUpInside ] ;
    [ container addSubview: button ] ;
    
    CUSLinnerData *data3 = [[CUSLinnerData alloc ] init ] ;
    data3.height = 49 ;
    container.layoutData = data3 ;
    [largerContainer addSubview:container ];
    
    UIView *line = [[UIView alloc ] initWithFrame:CGRectMake(0, 49.5, [DJUIUtils getWindowWidth], 0.5) ];
    line.backgroundColor = [DJControlsFactory getLineColor:DEEP ] ;
    CUSLinnerData *data4 = [[CUSLinnerData alloc ] init ] ;
    data4.height = 0.5 ;
    line.layoutData = data4;
    [largerContainer addSubview:line ] ;
    
    return largerContainer ;
}

-(IBAction)bindCoupon:(id)sender{

    [self.input resignFirstResponder ] ;
    
    if ( self.input.text == nil ||  [self.input.text stringByTrimmingCharactersInSet:[ NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 ) {
        
        [DJControlsFactory showError:@"请输入正确优惠券号码"] ;
        return ;
    }
    
    NSString *couponId = self.input.text ;
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userid =  [userDefaults objectForKey:@"userId"];
    NSString *mobile = [userDefaults objectForKey:@"userPhone"]; //@"13521687778" ;
    
    if ( userid == nil || mobile == nil ) {
        return ;
    }
    
    NSMutableDictionary *dict=  [[NSMutableDictionary alloc ] init];
    [dict setObject:userid forKey:@"uid" ] ;
    [dict setObject:[NSString stringWithFormat:@"%u",arc4random()] forKey:@"r" ] ;
    [dict setObject:mobile forKey:@"mobile" ] ;
    [dict setObject: couponId forKey:@"couponid" ] ;
    
    NSString *url = [ BASE_URL stringByAppendingString : COUPON_URL  ] ;

    [ProgressHUD show:@"正在绑定，请稍候"] ;
    
    __weak DJPrevilageViewController *weakself = self ;
    [DJAFNetworkingUtil sendHttpRequest:url data:dict success:^(id JSON){
        DJRespAnalyser *analyser = [[DJRespAnalyser alloc ]init ] ;
        [analyser analysisResponse:JSON ] ;
        if (analyser.status == 0) {
            [DJControlsFactory showSuccess:@"绑定成功"] ;
            [weakself refreshData] ;
            [_header setState:MJRefreshStateRefreshing ] ;
        }
    } failed:^(NSError *error){
        [DJControlsFactory showError:@"网络错误，绑定失败，请稍候重试"] ;
    }] ;
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count] + 1 ;
}

-(GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( indexPath.row < [self.data count ] ) {
        return 72 ;
    }
    if ( [self.data count ] > 0) {  //规则说明文本
        return 187 ;
    }
    return tableView.frame.size.height ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    if ( row >= [self.data count ] ) { //使用说明或者错误页面
        static NSString *CellIdentifier = nil ;

        if (  [self.data count ] > 0 ) { //
            CellIdentifier = @"couponDes" ;
        }else
            CellIdentifier = @"couponEmpty" ;

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        cell.backgroundColor = [DJControlsFactory getBackgroundColor ] ;
        if (  [self.data count ] > 0 ) {
            [_desView removeFromSuperview ] ;
            [cell.contentView addSubview: [self buildDescriptionView] ] ;
        }else{
            if (_emptyView == nil ) {
                _emptyView = [DJControlsFactory createEmptyView:tableView.frame image:@"无优惠券" title:@"暂无优惠券" description:@"" ] ; //暂时没有相关数据
            }
            [cell.contentView addSubview: _emptyView ];

        }
        return  cell ;
    }
    
    //————————正常的一行————————————
    static NSString *CellIdentifier = @"cupoons";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ DJPrevilageCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    DJPrevilageCell *preCell = (DJPrevilageCell *)cell;
    NSDictionary * cupponDic = [self.data objectAtIndex:row];
    [self setCupponsWithDic:cupponDic];
//    [self setCellWithCuppon:self.cuppons cell:cell];
//    UILabel * price = (UILabel *)[cell viewWithTag:1];
//    price.text =  @"10";
//    price.textColor = [UIColor redColor];
    
    preCell.amount =  (self.cuppons.amount)  ;
    preCell.status = self.cuppons.state ;
    preCell.endTime = self.cuppons.expireTime ;
    preCell.useTime = self.cuppons.useTime ;
    return cell ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder ];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder ];
    return YES ;
}
- (void) setCellWithCuppon:(DJCupponsModel *) cuppon cell:(UITableViewCell *) cell
{
    
    UILabel * price = (UILabel *) [cell viewWithTag:1];
    price.text = [NSString stringWithFormat:@"%F",cuppon.amount];
    price.textColor = [UIColor redColor];
    UILabel * typeName = (UILabel *) [cell viewWithTag:2];
    typeName.text = cuppon.typeName;
    UILabel * timeDescLable = (UILabel *) [cell viewWithTag:3];
    timeDescLable.text = [DJEnumUtil cupponTimeDescByCuppon:cuppon];
    UILabel * stateDescLable = (UILabel *) [cell viewWithTag:4];
    stateDescLable.text = [DJEnumUtil cupponStateDescByState:cuppon.state];
    [timeDescLable sizeToFit];
    
}

- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.couponList;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        //向服务器发送请求下一页数据
        
        //        [self.data addObjectsFromArray:@[@"a",@"a",@"a",@"a",@"a"]];
        page++;
        [self loadMoreData:self.data page:page];
        //        [self.data addObjectsFromArray:moreData];
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}

- (void) setCupponsWithDic:(NSDictionary *) cupponDic
{
    if (cupponDic != nil) {
        self.cuppons.amount = [[cupponDic objectForKey:@"amount"] floatValue];
        self.cuppons.state = [[cupponDic objectForKey:@"state"] integerValue];
        if ([cupponDic objectForKey:@"usetime"] != [NSNull null]) {
            self.cuppons.useTime = [cupponDic objectForKey:@"usetime"];
        }
        if ([cupponDic objectForKey:@"endtime"] != [NSNull null]) {
            self.cuppons.expireTime = [cupponDic objectForKey:@"endtime"];
        }
        self.cuppons.typeName = [cupponDic objectForKey:@"typename"];
        self.cuppons.code = [cupponDic objectForKey:@"code"];
    }
}

- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.couponList;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        //清除所有数据，然后重新向服务器请求数据，填充数据
        [self refreshData ];
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
//    [header beginRefreshing ];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
//    [self.couponList reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

- (void) refreshData
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userid =  [userDefaults objectForKey:@"userId"];
    NSString *mobile = [userDefaults objectForKey:@"userPhone"]; //@"13521687778" ;
    NSString * url = [NSString stringWithFormat:@"%@?uid=%@&r=%d&mobile=%@",_baseUrl,userid,arc4random() , mobile];
    [self.data removeAllObjects ] ; //请求前先清空
    [DJAFNetworkingUtil sendJsonHttpRequest:url data:nil delegate:self];
}

- (NSMutableArray *) loadMoreData:(NSMutableArray *)data page:(int)page1
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * userid =  [userDefaults objectForKey:@"userId"];
    NSString *mobile = [userDefaults objectForKey:@"userPhone"]; //@"13521687778" ;

    NSMutableDictionary *dict=  [[NSMutableDictionary alloc ] init];
    [dict setObject:userid forKey:@"uid" ] ;
    [dict setObject:[NSString stringWithFormat:@"%u",arc4random()] forKey:@"r" ] ;
    if ( mobile != nil ) {
        [dict setObject:mobile forKey:@"mobile" ] ;
    }
    [dict setObject:[NSString stringWithFormat:@"%d", page1] forKey:@"page" ] ;

    __weak DJPrevilageViewController *weakself = self ;
    [DJAFNetworkingUtil sendHttpRequest:_baseUrl data:dict success:^(id JSON){
        DJRespAnalyser *analyser = [[DJRespAnalyser alloc ]init ] ;
        [analyser analysisResponse:JSON ] ;
        if (analyser.status != 0 ) {  //失败
            return ;
        }
        if ([analyser.data isKindOfClass:[NSArray class]]) {
            NSArray *ary = analyser.data ;
            [ weakself.data addObjectsFromArray:analyser.data];
            if ([NSThread isMainThread] == NO) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [weakself.couponList reloadData ];
                });
            }
            [_footer endRefreshing];

            if(ary.count < DJ_PAGE_SIZE ){ // 本次加载的条数小于一页应有的条数，不需要再上拉加载了
                [_footer removeFromSuperview ] ;
                UIEdgeInsets insets2  = weakself.couponList.contentInset ;
                insets2.bottom = 0 ;
                weakself.couponList.contentInset = insets2 ;
            }
        }
        page = page1 + 1 ; //分页索引加1
        [self.couponList reloadData ];
    }failed:^(NSError *error) {
        [DJControlsFactory showError:@"加载失败，请稍候重试"] ;
        [self.couponList reloadData ];
    }];
    NSLog(@"refresh data");
    return data;
//    [self refreshData:self.data ];
//    [_emptyView removeFromSuperview ] ;
//    if( ! self.couponList.superview )
//      [ self.contentView addSubview:self.couponList ] ;
//    return data;
}

#pragma mark - AFNProcessDelegate implementions
-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data
{
    NSDictionary * cuppons1 = (NSDictionary *) JSON;
    int code = [[cuppons1 objectForKey:@"code"] integerValue];

    if ( ![ self checkCode : code ] ) {
        return ;
    }

    NSArray * cupponsData = [cuppons1 objectForKey:@"data"];
    [self.data removeAllObjects ] ;
    if ([cupponsData isKindOfClass:[NSArray class]]) {
        [self.data addObjectsFromArray:cupponsData];
    }
    else{
        [self showError ] ;
        return ;
    }
    if( self.data.count == 0 || self.data.count % DJ_PAGE_SIZE !=0 ){ // 本次加载的条数小于一页应有的条数，不需要再上拉加载了
        [_footer removeFromSuperview ] ;
        UIEdgeInsets insets2  = self.couponList.contentInset ;
        insets2.bottom = 0 ;
        self.couponList.contentInset = insets2 ;
    }
    
    if ( self.data.count == 0 ) {
        [self showError ];
    }
//    NSLog(@"respose :%@",JSON);
    [self.couponList reloadData ];
}

-(BOOL) checkCode:(int) code {
    
    switch (code) {
        case 0:
            return YES ;
        case 13 :{
            
            DJTabController *root = [DJTabController shareInstance ] ;
            
            if ([NSThread isMainThread] == NO) {
                dispatch_sync(dispatch_get_main_queue(), ^{

                    [DJLoginUtil login:root tilte:@"我的优惠券" delegate:self ]; //.navigationController
                } );
            }else{
                [DJLoginUtil login:root tilte:@"我的优惠券" delegate:self]; //.navigationController

            }
            return NO ;
        }default:
            break;
    }
    return NO ;
}

-(void)  loginViewController:(DJLoginViewController *)vc didExitWithCode:(DJLoginState) state {
    
    if ( state == DJLOGINSTATESUCESS) {
        [_header setState: MJRefreshStateRefreshing ] ;
        return ;
    }else //if( state == dj )
        [self.navigationController popViewControllerAnimated:YES ] ;
}

-(void) showError {

//    [self.couponList removeFromSuperview ] ;
    //添加空白图片
       if ( ! _emptyView ) {
           CGRect frame = self.couponList.frame  ;

           _emptyView = [DJControlsFactory createEmptyView:frame image:@"无优惠券" title:@"暂无优惠券" description:@"" ] ;//暂时没有相关数据
    }
    
//    [self.contentView addSubview:_emptyView ];
    
}

-(void) processAFNErrorResult:(NSURLRequest *)request
                     response:(NSHTTPURLResponse *)response
                        error:(NSError *)error
                         json:(id) JSON
{
    [DJControlsFactory showError:ERROR_NETWORK ] ;
    [self.couponList reloadData ];
}

-(void) viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews ] ;
   
}

@end
