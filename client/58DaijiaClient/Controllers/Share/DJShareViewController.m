//
//  DJShareViewController.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJShareViewController.h"
#import <HuangyeLib/CUSLayout.h>
#import "DJControlsFactory.h"
#import "DJShareDetailVC.h"
#import "DJAFNetworkingUtil.h"
#import "DJRespAnalyser.h"
#import "DJConst.h"
#import "DJUIUtils.h"
#import "DJAdCell.h"
#import "DJControlsFactory.h"
#import "DJevaluationViewController.h"
#import <HuangyeLib/ProgressHUD.h>

#import "DJShareManager.h"


@interface DJShareViewController (){
}

@end
static DJShareViewController *_this ;

@implementation DJShareViewController



- (id)init
{
    self = [super initWithTitle:@"告诉好友" tabbed:true ];
    if (self) {
//        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //上面
    CUSLinnerLayout *layout = [[CUSLinnerLayout alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor ] ;
    layout.spacing=0;
    layout.marginLeft = layout.marginRight = layout.marginTop = layout.marginBottom = 0 ;
    layout.type = CUSLayoutTypeVertical ;
    self.contentView.layoutFrame = layout;
    
    UIView *topContainer = [[UIView alloc ] init ] ;
    CUSLinnerData *layoutData = [[CUSLinnerData alloc]init];
//    layoutData.fill = YES;
    layoutData.width = [DJUIUtils getWindowWidth] ;
    layoutData.height = 128 ;
    topContainer.layoutData = layoutData;
    
    _shareSheet = [[DJShareSheetController alloc] init ] ;
    _shareSheet.title = @"分享" ;
    _shareSheet.view.frame = CGRectMake(0, 0, [DJUIUtils getWindowWidth], 127) ;
//    [topContainer addSubview:_shareSheet.view ] ;

    UIView *holderView =  [[UIView alloc ] initWithFrame:CGRectMake(0, 0, [DJUIUtils getWindowWidth], 127) ] ;
    [holderView addSubview:_shareSheet.view ] ;
    [topContainer addSubview:holderView ] ;
    
    UIView *line = [[UIView alloc ] initWithFrame:CGRectMake(0, 127.5, [DJUIUtils getWindowWidth], 0.5)] ;
    line.backgroundColor = [ DJControlsFactory getLineColor:DEEP ] ;
    [topContainer addSubview:line ] ;

    
    [self.contentView addSubview:topContainer ] ;
 


    UIView *bottomArea = [[UIView alloc ] init] ;
    bottomArea.backgroundColor = [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1 ];
    CUSLinnerData *layoutData2 = [[CUSLinnerData alloc]init];
//    layoutData2.width = 320 ;
    layoutData2.fill = YES;
    bottomArea.layoutData = layoutData2;
    
    [self.contentView addSubview:bottomArea ] ;

    //下面 列表
    bottomArea.layoutFrame = [[CUSFillLayout alloc ]init ] ;
    _adsView = [[UITableView alloc ] init ] ;
    [bottomArea addSubview:_adsView ] ;
    _adsView.delegate = self ;
    _adsView.dataSource = self ;
    _adsView.backgroundColor = [UIColor clearColor ];
    _adsView.separatorColor = [UIColor clearColor ] ;
    if (IsIOS7) {
        UIEdgeInsets inset =_adsView.contentInset; //页签栏透明处理，
        inset.bottom = 48 ;
        _adsView.contentInset  = inset ;
    }
}

#pragma mark - 服务端通信
-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated ] ;
    
    //请求服务器
    NSString * url = [BASE_URL stringByAppendingString:@"/share" ] ;
    [DJAFNetworkingUtil sendJsonHttpRequest:url data:nil delegate:self ] ;
    
    [ProgressHUD show:@"正在加载,请稍候" ];
}

-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data{
    NSMutableDictionary *map = JSON ;
    
    if( self.model == nil )
        self.model = [[DJShare alloc ] init ] ;
    
    DJRespAnalyser *analyser = [[DJRespAnalyser alloc ] init ] ;
    [analyser checkStatus:map ];
    if ( analyser.status != 0 ) {
        return ;
    }
    [analyser analysisResponse:map ] ;
    [self.model deserialize:analyser.data ] ;
    _shareSheet.model = self.model ;

    [_adsView reloadData ];
    
    [ProgressHUD showSuccess:@"加载成功" ];

}


-(void) processAFNErrorResult:(NSURLRequest *)request
                     response:(NSHTTPURLResponse *)response
                        error:(NSError *)error
                         json:(id) JSON{
//TODO: - 分享失败
    NSLog(@"%@",error.localizedDescription);
    [ProgressHUD showError:@"网络异常" ];

}



#pragma mark - 页签回调
-(NSString *) getTitle {
    return @"告诉好友" ;
}

-(UIImage *) getActiveBgImage {
    
    return [UIImage imageNamedFrombundle:@"分享选中" ] ;
}

-(UIImage *) getDeactiveBgImage {
    return [UIImage imageNamedFrombundle:@"分享" ] ;
}

#pragma mark - tableView 的datasource和delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = self.model.ads.count ;
    return count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ads"];
    if (cell == nil) {
        cell = [[DJAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ads"];
        cell.backgroundColor = [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1 ];
    }
    DJAdCell *adCell  = (DJAdCell *)cell ;
    adCell.marginLeft = 12;
    int row = indexPath.row ;
    DJAdObject *ad =[self.model.ads objectAtIndex:row ] ;
    adCell.adTitle.text = ad.title ;
   
//    UIImage *image = [DJUIUtils getImageFromURL:ad.pic ] ;
//    
//    adCell.adImage.image = image ;
    
    // 设置默认占位图片
    adCell.adImage.placeholderImage = [UIImage imageNamed: @"placeholder.png"];
    // 告诉它图片的url地址, done
    adCell.adImage.imageURL = [NSURL URLWithString:ad.pic];
    
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 193 ;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row ;
    DJAdObject *ad =[self.model.ads objectAtIndex:row ] ;
    if ( ad.url == nil ) {
        NSLog(@"1234") ;
    }
    if ( ad.url == nil || ad.url.length <= 0) {
        return ;
    }
    DJShareDetailVC *detail = [[DJShareDetailVC alloc ]initWithUrl:ad.url ] ; //@"http://daijia.test.58v5.cn/sjz_share.html"
    [self.navigationController pushViewController:detail animated:YES ] ;
    
}

-(void) viewDidLayoutSubviews{

    [super viewDidLayoutSubviews ] ;
    CGRect frame = self.view.frame ;
    CGRect frame2 = _adsView.frame;

}


@end
