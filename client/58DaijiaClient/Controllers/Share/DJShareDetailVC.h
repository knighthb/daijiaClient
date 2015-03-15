//
//  DJShareDetailVC.h
//  58DaijiaClient
//  一个webView，webView中点击分享按钮，外面可以弹出分享列表的actionSheet
//  Created by 周文杰 on 14-4-14.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <HuangyeLib/HYSmartViewController.h>
#import <UIKit/UIKit.h>
#define SHARE_CLICK @"share"
#import "DJProtocolViewController.h"

//@protocol ChartDelegate <NSObject>
//
//-(void) chartView : (JMB_ChartView *) chartView onClickPart:(int) part title:(NSString*) title value:(NSString*) value ;
//-(void) chartViewDidFinishLoad : (JMB_ChartView *) chartView ;
//
//@end

@class DJShareSheetController;
@interface DJShareDetailVC : DJProtocolViewController<UIWebViewDelegate>{
    UIView *actionView ;
    DJShareSheetController *shareSheet;
}

@property (nonatomic, strong ) UIWebView *webView ;

@property (nonatomic, strong ) NSString *url ;

@property (nonatomic, strong ) NSString *shareContent;

@property ( atomic  ) BOOL isLoading ;

- (id)initWithUrl :(NSString*) severURL1 ;

-(void) choose2share ;

@end