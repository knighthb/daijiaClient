//
//  DJProtocolViewController.m
//  58DaijiaClient
//  委托协议
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJProtocolViewController.h"
#import <HuangyeLib/ProgressHUD.h>

@interface DJProtocolViewController ()

@end

@implementation DJProtocolViewController

-(id) init{
    return [self initWithUrl:nil ] ;
}

-(id) initWithUrl:(NSString *) url1 {
    
    self = [super init ] ;
    
    if ( self ) {
        if ( url1 ) {
             url = url1 ;
        }else
            url = [BASE_URL stringByAppendingString:  @"/guest/agreement" ];
        
        self.title = @"委托代驾协议" ;
    }
    return self ;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc ] init ] ;
    self.view.layoutFrame = [[CUSFillLayout alloc ] init ] ;
  
    self.webView.backgroundColor = [UIColor whiteColor ];
    self.webView.delegate = self ;
    
    NSURL *url1 = [[NSURL alloc ] initWithString:url ];
    NSURLRequest *request = [[NSURLRequest alloc ] initWithURL:url1 ] ;
    [self.webView loadRequest:request ] ;
    
    [self.view addSubview:self.webView ] ;
    
//    self.webView
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [ProgressHUD show:@"正在加载，请稍候"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [ProgressHUD showSuccess:@"加载成功"];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [ProgressHUD showSuccess:@"加载失败"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
