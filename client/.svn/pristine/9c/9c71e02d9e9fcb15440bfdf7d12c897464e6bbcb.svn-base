//
//  DJQQDelegate.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-17.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJQQDelegate.h"
#import "DJControlsFactory.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "DJShareManager.h"

@implementation DJQQDelegate


- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message{
    
    if( EQQAPISENDSUCESS == response.retCode ){ // 成功
        
    }else{
        
    }
    
    
}

#pragma mark - QQApiInterfaceDelegate
+ (void)onReq:(QQBaseReq *)req
{
    switch (req.type)
    {
        case EGETMESSAGEFROMQQREQTYPE:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

+ (void)onResp:(QQBaseResp *)resp
{
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
      
            NSString* code = sendResp.result ;
            if ( [code isEqualToString:@"0" ] ) { //成功
               DJShareManager *manager = [DJShareManager sharedManager ];
               DJShareSheetController *vc = [manager getActive ] ;
                [vc shareSuccess:SHARE_TAG_QQ ] ;
            }else{ // error
                [DJControlsFactory showError:sendResp.errorDescription ] ;
            }
                
            break;
        }
        default:
        {
            break;
        }
    }
}

+(void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [DJControlsFactory showError:@"App未注册"   ] ;
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            [DJControlsFactory showError: @"发送参数错误" ];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [DJControlsFactory showError: @"未安装手Q"];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [DJControlsFactory showError: @"API接口不支持"];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [DJControlsFactory showError: @"发送失败"];
            break;
        }
        case EQQAPIQZONENOTSUPPORTTEXT:
        {
            [DJControlsFactory showError: @"空间分享不支持纯文本分享，请使用图文分享" ];
            break;
        }
        case EQQAPIQZONENOTSUPPORTIMAGE:
        {
            [DJControlsFactory showError: @"空间分享不支持纯图片分享，请使用图文分享" ];
            break;
        }
        default:
        {
            break;
        }
    }
}

@end

