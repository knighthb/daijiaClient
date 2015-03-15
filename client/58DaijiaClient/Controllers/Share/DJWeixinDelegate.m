//
//  DJWeixinDelegate.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-16.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJWeixinDelegate.h"
#import "DJControlsFactory.h"

#import "DJShareManager.h"

@implementation DJWeixinDelegate


//onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void) onReq:(BaseReq*)req{
    
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
    }
    
    
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        switch ( resp.errCode ) {
            case WXSuccess :{
                //返回到服务端
                DJShareManager *manager = [DJShareManager sharedManager ];
                DJShareSheetController *vc = [manager getActive ] ;
                [vc shareSuccess:SHARE_TAG_QQ ] ;
                break ;
            }
            case WXErrCodeCommon:
                [DJControlsFactory showError: @"微信分享失败,普通错误类型" ] ;
                break;
            case WXErrCodeUserCancel:
                [DJControlsFactory showError: @"微信分享失败,用户点击取消发送" ] ;
                break;
            case WXErrCodeSentFail:
                [DJControlsFactory showError: @"微信分享失败,发送失败" ] ;
                break;
            case WXErrCodeAuthDeny:
                [DJControlsFactory showError: @"微信分享失败,授权失败" ] ;
                break;
            case WXErrCodeUnsupport:
                [DJControlsFactory showError: @"微信分享失败,微信不支持" ] ;
                break;
            default:
                break;
        }
        
    }
}


@end
