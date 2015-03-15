//
//  DJShareSheetController.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-13.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJShareSheetController.h"
#import "DJUIUtils.h"
#import "DJControlsFactory.h"
#import "DJCheckUtil.h"
#import "DJLoginUtil.h"
#import "DJLoginViewController.h"
#import "DJTabController.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "DJQQDelegate.h"
#import "WXApi.h"
#import <HuangyeLib/ProgressHUD.h>
#import "DJShareManager.h"

static const NSString *SHARE_SUCCESS  = @"/share/success" ;


@implementation DJShareSheetController


-(id) init {
    self = [super init ] ;
    if (self) {
        
        DJShareManager *manager = [DJShareManager sharedManager ];
         [manager addInstance:self ] ;
    }
    return self ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor ] ;
    
    NSMutableArray *colums = [NSMutableArray array];
    for (int i = 0 ; i < 4; i++) {
        [colums addObject:[CUSValue valueWithPercent:0.25]];
    }
    NSMutableArray *rows = [NSMutableArray array];
    if ( self.title ) {
        [rows addObject:[CUSValue valueWithPercent:0.25]]; //文本
    }
    [rows addObject:[CUSValue valueWithPercent:0.75]]; //按钮
    
    CUSTableLayout *gridLayout = [[CUSTableLayout alloc ]initWithcolumns:colums rows:rows ] ;
    gridLayout.marginTop = gridLayout.marginLeft = gridLayout.marginRight = 12 ;
    self.view.layoutFrame = gridLayout ;
    
    if (self.title ) {
        [gridLayout merge:0 row:0 colspan:4 rowspan:1];
        UILabel *titleLabel = [DJControlsFactory createLabel:H2 text:  self.title ] ;
        [self.view addSubview:titleLabel ] ;
    }
    
    UIButton *button1 = [DJControlsFactory createControl: @"新浪微博" text:@"新浪微博"];
    button1.tag = SHARE_TAG_SINA ;
    [button1 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside ] ;
    
    UIButton *button2 = [DJControlsFactory createControl: @"微信好友" text:@"微信好友"];
    button2.tag = SHARE_TAG_WEIXIN ;
    [button2 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside ] ;
    
    UIButton *button3 = [DJControlsFactory createControl: @"QQ好友" text:@"QQ好友"];
    button3.tag = SHARE_TAG_QQ ;
    [button3 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside ];
    
    UIButton *button4 = [DJControlsFactory createControl: @"朋友圈" text:@"朋友圈"];
    button4.tag = SHARE_TAG_TIMELINE ;
    [button4 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside ] ;
    
    if (! [WXApi isWXAppInstalled] ) {
        [button2 setEnabled:false ] ;
        [button4 setEnabled:false ] ;
    }
    
    [self.view addSubview:button1 ] ;
    [self.view addSubview:button4 ] ;
    
    [self.view addSubview:button2 ] ;
    
    [self.view addSubview:button3 ] ;
}


-(BOOL) checkLogin{
    if ( ! self.model.check_login ) {
        return true ;
    }
    
    if ( isLogin() ) {
        return true ;
    }
    
    //
    return false ;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self share2QQ: buttonIndex ] ;
}

-(IBAction)share:(id)sender{
    UIButton *button = sender ;
    _shareTag = button.tag ;
    
    if ([self checkLogin ]) {
        [self shareTo: _shareTag ] ;
    }else {
        [DJLoginUtil login:[DJTabController shareInstance]  tilte:@"分享登录" delegate:self ];
    }
    
}

-(void)  loginViewController:(DJLoginViewController *)vc didExitWithCode:(DJLoginState) state {
    
    if ( state == DJLOGINSTATESUCESS) {
        [self shareTo:_shareTag] ;
        return ;
    }//else //if( state == dj )
    // [self.navigationController popViewControllerAnimated:YES ] ;
}


-(void) shareTo:(int) tag {
    
    switch (tag) {
        case SHARE_TAG_SINA:
            [self sinaWeibo] ;
            break;
        case SHARE_TAG_WEIXIN:
            [self weixin ];
            break;
        case SHARE_TAG_QQ:
            [self qqShareAcition];
            break;
        case SHARE_TAG_TIMELINE:
            [self timeline ];
            break;
        default:
            break;
    }

    if ( self.delegate ) {
        [self.delegate shareSheet:self didClickButton:tag ] ;
    }
    
}

-(void) share2QQ : (int) buttonIndex {
    NSString *utf8String = self.model.qqShare.url ;
    NSString *title = self.model.qqShare.title ;
    NSString *description = self.model.qqShare.description  ;
    
    NSURL *imageURL =  self.model.qqShare.image ? [NSURL URLWithString:self.model.qqShare.image  ] : nil ;
    
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL: imageURL ];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    QQApiSendResultCode sent = 0 ;
    
    if (0 == buttonIndex)
    {
        //分享到QZone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    else
    {
        //分享到QQ
        sent = [QQApiInterface sendReq:req];
    }
    [DJQQDelegate handleSendResult:sent];
}

#pragma mark -- 分享按钮的监听
-(void) qqShareAcition {
    [self share2QQ: 1 ] ;
}

-(void) weixin {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title =  self.model.friendsShare.title ;
    message.description = self.model.friendsShare.description ;
    if( self.model.friendsShare.image){
        
        NSData * picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.friendsShare.image]];
        if ( picdata ) {
            UIImage *image = [[UIImage alloc ] initWithData:picdata ] ;
            [message setThumbImage:image];
        }else{
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x" ]];
        }
    }else{
        [message setThumbImage:[UIImage imageNamed:@"Icon@2x" ]];
    }
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl =  self.model.friendsShare.url ;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [ [SendMessageToWXReq alloc] init] ;
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession ; //微信会话
    
    [WXApi sendReq:req];
}

-(void) timeline {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.model.timelineShare.title;
    message.description = self.model.timelineShare.description ;
    if( self.model.timelineShare.image){
        
        NSData * picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.timelineShare.image]];
        if ( picdata ) {
            UIImage *image = [[UIImage alloc ] initWithData:picdata ] ;
            [message setThumbImage:image];
        }else{
            [message setThumbImage:[UIImage imageNamed:@"Icon@2x" ]];
        }
    }else{
        [message setThumbImage:[UIImage imageNamed:@"Icon@2x" ]];
    }

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl =  self.model.timelineShare.url ;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [ [SendMessageToWXReq alloc] init] ;
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline ; //微信朋友圈
    
    [WXApi sendReq:req];
}

-(void)sinaWeibo {
    
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self weiboMessageToShare]];
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
    
    
    
}


- (WBMessageObject *) weiboMessageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = [self.model.sinaShare.description stringByReplacingOccurrencesOfString:@"[URL]" withString:self.model.sinaShare.url ] ;
    
    
    //    if (self.model.url) //媒体
    //    {
    //        WBWebpageObject *webpage = [WBWebpageObject object];
    //        webpage.objectID = @"identifier1";
    //        webpage.title =  self.model.weixinShare.title ;
    //        webpage.description = self.model.sinaShare;
    //        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share_Icon" ofType:@"png"]];
    //        webpage.webpageUrl = self.model.url ;
    //        message.mediaObject = webpage;
    //    }else
    if( self.model.sinaShare.image){
        
        NSData * picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.sinaShare.image]];
        WBImageObject *image = [WBImageObject object];
        if ( picdata ) {
            image.imageData = picdata ;
        }else
            image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"]];
        
        message.imageObject = image;
        
    }else{
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"]];
        message.imageObject = image;
    }
    
    return message;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//
////    self.scrollView.contentSize = CGSizeMake(320 * 2, 44);
//}

-(void) shareSuccess:(int) tag  {
    
    if ( tag == SHARE_TAG_WEIXIN || tag == SHARE_TAG_TIMELINE) { //微信好友和微信分享接口调用上基本没区别，返回值也无法区分
        tag = _shareTag ;
    }
    
    NSString *url = [BASE_URL stringByAppendingString:SHARE_SUCCESS ] ;
    NSMutableDictionary *param = [[NSMutableDictionary alloc ] init ] ;
    [param setObject:[NSString stringWithFormat:@"%d",arc4random()] forKey:@"r" ];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults ] ;
    NSString *mobile = [defaults objectForKey:@"userPhone" ] ;
    [param setObject:mobile forKey:@"mobile" ];
    NSString *uid = [defaults objectForKey:@"userId" ] ;
    [param setObject:uid forKey:@"uid" ];
    //    url 可选
    [param setObject:[NSString stringWithFormat:@"%d",tag] forKey:@"share_type" ]; //分享类型1、微博2、QQ好友/3、weixin好友/4、朋友圈
    if ( self.model.activty_id ) {
        [param setObject:self.model.activty_id  forKey:@"activity" ];
    }
    
    //    [param setObject:thirdparty_id  forKey:@"thirdparty_id" ];
    
    
    [ProgressHUD show:@"" ];
    
    [DJAFNetworkingUtil sendHttpRequest:url data:param success:^(id resp) {
        
        NSDictionary *resMap = resp ;
        NSLog([resMap objectForKey:@"codeMsg" ] );
        if ( [[resMap objectForKey:@"code" ] integerValue]  == 0 )
            [DJControlsFactory showSuccess:@"分享成功" ] ;
        else
            [DJControlsFactory  showError:[resMap objectForKey:@"codeMsg" ] ] ;
    } failed:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [ProgressHUD  showError:ERROR_NETWORK ] ;
        
    } ] ;
 
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated ] ;
    DJShareManager *manager = [DJShareManager sharedManager ];

    [manager setActivie:self ] ;
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated ] ;
    DJShareManager *manager = [DJShareManager sharedManager ];
    
    [manager setDeactivie:self ] ;
}

-(void) viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews ] ;
    
}

@end
