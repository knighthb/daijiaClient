//
//  DJDriveListViewController.m
//  58DaijiaClient
//  司机列表视图控制器
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriveListViewController.h"
#import "MJRefresh.h"
#import "DJTableViewCellUtil.h"
#import "DJControlsFactory.h"
#import "DJPhoneUtil.h"
#import "DJDriverMapViewController.h"
#import "BaiduMobStat.h"
#import "DJDriverCell.h"
#import "ImageBuffer.h"
#import <HuangyeLib/ProgressHUD.h>
#import "DJDriverMainViewController.h"
#import "DJRespAnalyser.h"

static const NSTimeInterval CACHE_INTERVAL = 180 ;//缓存时间间隔，3分钟

@interface DJDriveListViewController ()
{
//    NSMutableArray * drivers;
//    int _58Num;
//    int otherNum;
//    NSMutableArray * _58Drivers;
//    NSMutableArray * otherDrivers;
    MJRefreshHeaderView *_header;
    CLLocation * location;
    BOOL refreshMapView;
    BOOL locationSuccess;
    NSMutableArray * kvoArray;
    DJDriverModel * testKVO;
    MJRefreshBaseView * _refreshView;
    
    BOOL initialized ;

}

@end

@implementation DJDriveListViewController
@synthesize  driverList58 , driverListOther ; //data
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        initialized = false;
        self.title = @"列表" ;
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"司机列表"];
//    //每次进入司机类别时定位一次
//    NSTimeInterval timeInterval = [location.timestamp timeIntervalSinceNow];
//    if ( fabs(timeInterval) > CACHE_INTERVAL  ) { //三分钟前的坐标，属于缓存，需重新定位
//        [self.locationManager startUpdatingLocation];
//    }else
    [self.tableView reloadData ]; //防止地图界面已经定位，

    refreshMapView = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [DJControlsFactory getBackgroundColor ];
//    _58Num = 0;
//    otherNum = 0;
    driverList58 = [[NSMutableArray alloc] init];
    driverListOther = [[NSMutableArray alloc] init];
    
    if ( _DJDEBUGGER ) {
        NSLog(@"进入列表页!");
    }
    
    self.locationManager = [[LocationManagerUtil sharedLocationManagerUtil] locationManager];
    self.locationManager.delegate = self;

    [self addHeader];
    [DJTableViewCellUtil setViewController:self.navigationController];
//    self.data = [[NSMutableArray alloc] init];
    locationSuccess = YES;
    if( IsIOS7 ){
        self.edgesForExtendedLayout = UIRectEdgeAll ;
        UIEdgeInsets inset =self.tableView.contentInset;
        inset.bottom = 48 ;
        self.tableView.contentInset  = inset ;
    }
    
    kvoArray = [[NSMutableArray alloc] init];
    
    [self startLoadingAnimation ] ; //视图第一次加载时要呈现加载等待界面
    
}

-(void) startLoadingAnimation {
    
    [ProgressHUD show:@"正在加载，请稍候" ] ;
    
}

-(void) stopLoadingAnimation {
    
    [ProgressHUD dismiss ] ;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[ImageBuffer sharedImageBuffer] clearBuffer];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ( [driverListOther count ] == 0) {
        return 1;
    }
    else
        return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if ([self.data count] == 0) {
//        return  1;
//    }
//    if (otherNum == 0) {
//       int count = [self.data count];
//            return count;
//    }
//    else{
//        if (section == 0) {
//           return _58Num;
//        }
//        else
//        {
//            return otherNum;
//        }
//    }
    if ( [driverList58 count ] + [driverListOther count ] == 0 ) {
        return 1 ;
    }
    switch ( section ) {
        case 0:
           return [driverList58 count ] ;
        case 1:
           return  [driverListOther count ] ;
        default:
            break;
    }
    return 0 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!locationSuccess) {//定位失败，则显示定位失败页面
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationFailed"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"locationFailed"];
            [cell.contentView addSubview:[DJPhoneUtil createRelocationView:self.view.frame delegate:self]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
    if ( (! initialized ) && [self.driverListOther count] + [self.driverList58 count ] ==0 ) {
        //cell为nil说明这是第一次进来，
        //此时应该展示加载界面
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loading"];
        cell.backgroundColor = [ DJControlsFactory getBackgroundColor ] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        initialized = YES ;
        return cell ;
    }
    
    if ( [self.driverListOther count] + [self.driverList58 count ] == 0 ) { //附近司机没数据，则显示没有司机页面
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noDrivers"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noDrivers"];
            [cell.contentView addSubview:[DJPhoneUtil createNoDriverView:self.view.frame delegate:self]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
    return  [self buildNormalDriveCell:tableView indexPath:indexPath ];
}

-(UITableViewCell *) buildNormalDriveCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = HexToUIColorRGB(0xdddddd);
    
    NSString *CellIdentifier = @"cell";
    DJDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DJDriverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.photoView.image = nil;
    DJDriverModel * driverTemp ;
    if (indexPath.section == 0) {
        driverTemp = [driverList58 objectAtIndex:indexPath.row];
    }
    else
    {
        driverTemp = [driverListOther objectAtIndex:indexPath.row];
    }
    [driverTemp addObserver:self forKeyPath:@"pic" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void *)(cell)];
    [kvoArray addObject:driverTemp];
    
    
    NSArray * splits = [driverTemp.picUrl componentsSeparatedByString:@"/"];
    NSString * picName = [splits objectAtIndex:[splits count]-1];
    [self loadPicWihtURL:driverTemp.picUrl name:picName observer:driverTemp forKey:@"pic"];
    cell.nameLabel.text = driverTemp.name;
    cell.driverYearLabel.text = [NSString stringWithFormat:@"驾龄:%d年",driverTemp.year];
    cell.homeCityLabel.text = [NSString stringWithFormat:@"籍贯:%@",driverTemp.homeCity];
    cell.distanceLabel.text = [NSString stringWithFormat:@"距离:%@",driverTemp.distance];
    if (driverTemp.phoneNum != [NSNull null]) {
        cell.phoneButton.titleLabel.text = [ NSString stringWithFormat:@"%@_%@",driverTemp.phoneNum,driverTemp.driverId ];
        [cell.phoneButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) callPhone:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString * driverId = [[button.titleLabel.text componentsSeparatedByString:@"_"] objectAtIndex:1];
    NSString * phone = [[button.titleLabel.text componentsSeparatedByString:@"_"] objectAtIndex:0];
   
    NSString * phoneNum = [NSString stringWithFormat:@"tel:%@",phone];
    [DJPhoneUtil dailPhone:self.view phoneNum:phoneNum order:_order4commit viewController:viewController];
    
    _order4commit = [[DJOrderEntity alloc] initWithDriverID:driverId userPhone:[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"] driverPhone:phone coordinate:_location.coordinate];
    _order4commit.timestamp = [[NSDate alloc ] init ] ;
}




- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSTimeInterval timeInterval = [location.timestamp timeIntervalSinceNow];
    CLLocation * loc = [locations lastObject];
//   用户在错误页面停留时，如果位置没发生改变，则会一直停留在错误页面
    NSTimeInterval timeInterval2 = [loc.timestamp timeIntervalSinceNow]; //判断当前定位坐标是不是缓存
    if ( fabs(timeInterval2) > CACHE_INTERVAL  ) { //三分钟前的坐标，属于缓存
        return ;
    }

    locationSuccess = YES;
//    [_locationManager stopUpdatingLocation];
    if (fabs(timeInterval) < 1 && fabs(timeInterval)>0) {//防止用户经常刷新，30s以下的定位直接抛弃，不发请求,interval为0时，是第一次，需要发送请求
        return;
    }
    location = loc;
    _location = loc ;
    [self refreshData];
    NSLog(@"latitude = %f,lontitude = %f",loc.coordinate.latitude,loc.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    locationSuccess = NO;
    location =  nil;
    [self.positionDelegate setPosition:location DriverList:nil delegate:self];
//    if (refreshMapView) {
        [self.positionDelegate  refreshMapview];
//    }
    [self.driverList58 removeAllObjects ] ;
    [self.driverListOther removeAllObjects ] ; //定位失败，清空所有司机，并显示定位失败页
    [_refreshView endRefreshing];
    [self.tableView reloadData];

    [self stopLoadingAnimation ] ; //定位失败，停止加载等待界面

}
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    
    NSTimeInterval timeInterval = [location.timestamp timeIntervalSinceNow];
    CLLocation * loc = newLocation ;
    //   用户在错误页面停留时，如果位置没发生改变，则会一直停留在错误页面
    NSTimeInterval timeInterval2 = [loc.timestamp timeIntervalSinceNow]; //判断当前定位坐标是不是缓存
    if ( fabs(timeInterval2) > CACHE_INTERVAL  ) { //三分钟前的坐标，属于缓存
        return ;
    }
    
    locationSuccess = YES;
    //    [_locationManager stopUpdatingLocation];
    if (fabs(timeInterval) < 1 && fabs(timeInterval)>0) {//防止用户经常刷新，30s以下的定位直接抛弃，不发请求,interval为0时，是第一次，需要发送请求
        return;
    }
    location = loc;
    _location = loc ;
    [self refreshData];
    if ( _DJDEBUGGER ) {
        NSLog(@"<ios6 latitude = %f,lontitude = %f",loc.coordinate.latitude,loc.coordinate.longitude);
    }
}

#pragma mark - 根据经纬度获得地理位置描述
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark NS_DEPRECATED_IOS(3_0,5_0){
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error NS_DEPRECATED_IOS(3_0,5_0){
    
}

- (void)dealloc
{
    _locationManager = nil;
    for (id object in kvoArray) {
        [object removeObserver:self forKeyPath:@"pic"];
    }
    kvoArray = nil;
    
}
- (void)viewWillDisappear:(BOOL)animated{
//    [self.locationManager stopUpdatingLocation];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"司机列表"];
}



- (void)setMapviewController:(DJDriverMapViewController *) mapViewController
{
    self.positionDelegate = (id<DJMapviewPositionDelegate>)mapViewController;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.driverListOther count] + [self.driverList58 count ] == 0 ) {
        return self.tableView.frame.size.height+30;
    }
    return DRIVER_CELL_HEIGHT;
}

#pragma mark - AFNProcessDelegate 网络请求回调
-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data
{
    NSDictionary * dic = (NSDictionary *) JSON;

    DJRespAnalyser *analyser = [[DJRespAnalyser alloc ] init ] ;
    [analyser checkStatus:dic ];
    if ( analyser.status != 0 ) {
        return ;
    }
    [analyser analysisResponse:dic ] ;
    
    [driverList58 removeAllObjects];
    [driverListOther removeAllObjects];

    if ([analyser.data isKindOfClass:[NSArray class]]) {
        if ( _DJDEBUGGER ) {
            NSLog(@"司机列表respose :%@",JSON);
        }
        for (int i=0; i<[analyser.data count]; i++) {
            DJDriverModel * driver = [[DJDriverModel alloc] init ] ;
            [driver deserialize:[analyser.data objectAtIndex:i]];
            if ( [driver.source isEqualToString:@"58"]  ) {
                [self.driverList58 addObject:driver ];
            }else
                [self.driverListOther addObject:driver ];
        }
        NSMutableArray *totalDrivers = [self mergeDrivers:driverList58 with:driverListOther ];
        [self.positionDelegate setPosition:location DriverList:totalDrivers delegate:self];
//        if (!refreshMapView) {
            //重新定位的时候的不加载
//        [self.tableView reloadData];
//        }
    }
    else{
        [self.positionDelegate setPosition:location DriverList:nil delegate:self];
        if ( initialized ) {  //初始化完成之前，一直显示等待动画，
            [DJControlsFactory showError:@"加载出错啦"];
        }
    }
//    if (refreshMapView) {
    //同步一下
        [self.positionDelegate refreshMapview];
//    }

    [_refreshView endRefreshing];
    
    [self stopLoadingAnimation ] ; //请求司机列表成功，停止加载等待界面
    
    if(! (self.isViewLoaded && self.view.window)){
        return ;
    }
    [self showLocationDes ]; //显示地理位置描述
    
    [self.tableView reloadData];

}

-(void) showLocationDes{
    if (location != nil) {
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error==nil && [placemarks count] > 0) {
                CLPlacemark * placeMark = [placemarks objectAtIndex:0];
                NSString * address = @"";
                NSArray * array = [placeMark.addressDictionary objectForKey:@"FormattedAddressLines"];
                for (NSString * string in array) {
                    address = [address stringByAppendingString:string];
                }
                address = [address stringByAppendingString:@"附近"];
                [ProgressHUD showSuccess:address];
                NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dissMissProcessHUD) userInfo:nil repeats:NO];
                
            }else if(error==nil && [placemarks count]==0){
                NSLog(@"没有找到返回结果！");
            }else if(error!=nil){
                NSLog(@"error = %@",error);
            }
        }];
    }
}

-(NSMutableArray *) mergeDrivers:(NSMutableArray *) drivers1 with:(NSMutableArray *) drivers2{
    NSMutableArray *total = [[NSMutableArray alloc ] initWithArray:drivers1 ] ;
    
    for ( id element in drivers2 ) {
        [total addObject:element ] ;
    }
    return total ;
}

-(void) processAFNErrorResult:(NSURLRequest *)request
                     response:(NSHTTPURLResponse *)response
                        error:(NSError *)error
                         json:(id) JSON
{
    [self.positionDelegate setPosition:location DriverList:nil delegate:self];
    [self.positionDelegate  refreshMapview];
    [self.driverList58 removeAllObjects];
    [self.driverListOther removeAllObjects];

    [self.tableView reloadData];
    [_refreshView endRefreshing];
    
    [self stopLoadingAnimation ] ; //请求司机列表失败，停止加载等待界面

    if ( _DJDEBUGGER ) {
        NSLog(@"司机列表请求失败:%@",error);
    }
}

-(void) dissMissProcessHUD{
    [ProgressHUD dismiss];
}


- (void) refreshData
{
    NSString* const BaseURLString = [NSString stringWithFormat:@"%@/guest/findDrivers?",BASE_URL];
    NSString * driverUrl = [NSString stringWithFormat:@"%@lat=%f&lng=%f&r=%d",BaseURLString,location.coordinate.latitude,location.coordinate.longitude,arc4random()];
//    [self.data removeAllObjects]; //请求前将data数组清空
    [DJAFNetworkingUtil sendJsonHttpRequest:driverUrl data:nil delegate:self];
    NSLog(@"lontitude = %f",location.coordinate.longitude);
}

- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        [[LocationManagerUtil sharedLocationManagerUtil] relocation];
        // 这里的refreshView其实就是header
        _refreshView = refreshView;
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
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}
-(void) refreshLocation:(id) sender
{
    refreshMapView = NO;
    NSLog(@"driverList refreshLocation ");
    if (self.locationManager == nil) {
        self.locationManager = [[LocationManagerUtil sharedLocationManagerUtil] locationManager];
    }
    [[LocationManagerUtil sharedLocationManagerUtil] relocation];
//    if(self.positionDelegate)
//       [self.positionDelegate setPosition:location DriverList:drivers delegate:self];
    if ([sender isKindOfClass:[DJDriverMapViewController class]]) {
        refreshMapView = YES;
        self.positionDelegate = sender;

    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    DJDriverCell * cell = (__bridge DJDriverCell *) context;
    cell.photoView.image = [object valueForKey:@"pic"];
    
}

-(void) loadPicWihtURL:(NSString *) url name:(NSString *) name observer:(id) observer forKey:(NSString *)key
{
    
    UIImage * imageFromImageBuffer = [[ImageBuffer sharedImageBuffer] readFromBufferWithKey:name path:key];
    if (imageFromImageBuffer == nil) {
         NSURL * nsUrl = [NSURL URLWithString:url];
        NSURLRequest * request = [NSURLRequest requestWithURL:nsUrl];
        AFImageRequestOperation * operrations = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [observer setValue:image forKey:key];
            [[ImageBuffer sharedImageBuffer] addToBufferWithKey:key value:image immediatelyWrite:NO];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            //如果异步加载失败则同步加载图片
//            这块不要了，如果没有图片 app应该就死在这了
//            NSData * picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            [observer setValue:[UIImage imageWithData:picdata] forKey:key];
        }];
        [operrations start];
    }else{
        [observer setValue:imageFromImageBuffer forKey:key];
    }
    
}

-(void) becomeUntabed {
    
    [ProgressHUD dismiss ];
    
}

-(void) enterBackground {
    NSDate *now = [[NSDate alloc ] init ] ;
    NSTimeInterval seconds = [now timeIntervalSinceDate: _order4commit.timestamp  ] ;
    if ( seconds <= 10 ) {  //10s之前拨号创建的订单已经失效，
        [DJPhoneUtil createOrder:_order4commit viewController:viewController];
    }
}


@end
