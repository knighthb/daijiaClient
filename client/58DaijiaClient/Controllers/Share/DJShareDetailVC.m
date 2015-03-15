//
//  DJShareDetailVC.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-14.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJShareDetailVC.h"
#import "DJUIUtils.h"
#import "DJControlsFactory.h"
#import "WXApi.h"
#import "DJRespAnalyser.h"
#import "DJConst.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "DJQQDelegate.h"
#import "DJUIUtils.h"
#import "DJShareSheetController.h"
#import "DJAFNetworkingUtil.h"
#import <HuangyeLib/ProgressHUD.h>

@interface DJShareDetailVC ()

@end

@implementation DJShareDetailVC

//@synthesize url , webView ;

//- (id)initWithUrl:(NSString *)severURL1
//{
//    self = [super init ];
//    if (self) {
//        self.url = severURL1 ;
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"分享" ;

    if ( IsIOS7) {
        self.webView.frame = self.view.bounds ;
    }else{
        self.webView.frame = CGRectMake(0, 0, [DJUIUtils getWindowWidth], [DJUIUtils getWindowHeight] - 64 ) ;
    }
    self.view.layoutFrame = nil ;    
    shareSheet = [[DJShareSheetController alloc ] init ] ;
    shareSheet.title = nil ; //@"分享到" ;
    shareSheet.delegate = self ;
    actionView = [[UIView alloc ] initWithFrame: self.view.frame ] ;

    UITapGestureRecognizer *tapListener =  [[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(resumeInteract:) ];
    tapListener.cancelsTouchesInView = NO;
    tapListener.delegate = self ;
    [actionView addGestureRecognizer:tapListener ];
    
}

#pragma mark - 点击空白收回sharesheet
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 过滤掉UIButton，也可以是其他类型
    if ( [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    
    return YES;
}

-(void)resumeInteract:(UITapGestureRecognizer *)sender{
    
//     CGPoint point = [sender locationInView:actionView ] ;
//    
//    if ( point.y > CGRectGetHeight(actionView.frame) - CGRectGetHeight(shareSheet.view.frame) ) { //点到actionsheet上了
//        return ;
//    }
    
    if ( !self.isLoading ) {
        __weak DJShareSheetController *sheet = shareSheet ;
        __weak UIView *action = actionView ;

        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame2 = sheet.view.frame ;
            frame2.origin.y += frame2.size.height ;
            sheet.view.frame = frame2 ;
        } completion:^(BOOL finished) {
            [action removeFromSuperview ] ;
        } ] ;
        
    }
}

-(void) choose2share:(NSString *) shareContent{

    //请求服务器
    [DJAFNetworkingUtil sendJsonHttpRequest:shareContent data:nil delegate:self ] ;
    //禁止交互
    [shareSheet.view removeFromSuperview ];
    [self.view addSubview:actionView ];
    [ProgressHUD show:@"正在加载，请稍候" ];
    self.isLoading = true ;
}

-(void) showSharesheet {
    
    actionView.frame = self.view.bounds ;
    CGRect frame =  self.view.bounds ;
    frame.origin.y = frame.size.height  ;
    const GLfloat y = CGRectGetHeight(self.webView.bounds) - 127 ;
    frame.size.height = 127 ;
    shareSheet.view.frame =frame ;
    [actionView addSubview:shareSheet.view ];
    
    __weak DJShareSheetController *sheet = shareSheet ;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame2 = frame ;
        frame2.origin.y = y ;
        sheet.view.frame = frame2 ;
    } ] ;
    
}

-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data{
    //显示分享按钮
    [ProgressHUD dismiss ];
    self.isLoading = false ;

    [self showSharesheet ];
    
    NSMutableDictionary *map = JSON ;
    if( shareSheet.model == nil )
        shareSheet.model = [[DJShare alloc ] init ] ;
    
    DJRespAnalyser *analyser = [[DJRespAnalyser alloc ] init ] ;
    [analyser analysisResponse:map ] ;
    [shareSheet.model deserialize:analyser.data ] ;
}


-(void) processAFNErrorResult:(NSURLRequest *)request
                     response:(NSHTTPURLResponse *)response
                        error:(NSError *)error
                         json:(id) JSON{
    NSLog(@"%@",error.localizedDescription);
    [DJControlsFactory showError:@"网络异常" ];
    self.isLoading = false ;

}

-(void) shareSheet:(DJShareSheetController *)sheet didClickButton:(int) buttonTag {
    
    [actionView removeFromSuperview ] ;
}


#pragma mark - UIWebView的代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request1 navigationType:(UIWebViewNavigationType)navigationType{
    
   
    if( [[[request1 URL] scheme] isEqual: SHARE_CLICK ]  ){
        NSString *urlStr = [[request1 URL] absoluteString] ;
        NSString *urlStr2 = [DJShareDetailVC DisEncodeUTF8ToChina:urlStr ];
        
        NSString* param = [ urlStr2 substringFromIndex: SHARE_CLICK.length + 7 ] ;// ":///api" = 7
        NSString *shareURL = [BASE_URL stringByAppendingString:param ] ;
        [self choose2share:shareURL ] ;
        
        return false;
    }else{ // http
        
        return YES ;
    }
    return YES  ;
}

+( NSString *)DisEncodeUTF8ToChina:(NSString *)encodeStr
{
    return [encodeStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+( NSString *)EncodeChinaToUTF8:(NSString *)encodeStr
{
    return [[NSString stringWithFormat:@"%@",encodeStr]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
