//
//  DJWeiboDelegate.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-16.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJWeiboDelegate.h"
#import "WeiboSDK.h"
#import "DJControlsFactory.h"
#import "DJShareManager.h"

@implementation DJWeiboDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
//        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
//        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
//        NSString *title = @"发送结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
        int code = (int)response.statusCode ;
        if ( code == WeiboSDKResponseStatusCodeSuccess ) {
            //返回到服务端
            DJShareManager *manager = [DJShareManager sharedManager ];
            DJShareSheetController *vc = [manager getActive ] ;
            [vc shareSuccess:SHARE_TAG_QQ ] ;
            return ;
        }

        switch ( code ) {
            case WeiboSDKResponseStatusCodeUserCancel:
                [DJControlsFactory showError:@"微博分享失败,用户取消发送" ] ;
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                [DJControlsFactory showError:@"微博分享失败,发送失败" ] ;
                break;
            case WeiboSDKResponseStatusCodeAuthDeny:
                [DJControlsFactory showError:@"微博分享失败,授权失败" ] ;
                break;
            case WeiboSDKResponseStatusCodeUserCancelInstall:
                [DJControlsFactory showError:@"微博分享失败,用户取消安装微博客户端" ] ;
                break;
            case WeiboSDKResponseStatusCodeUnsupport:
                [DJControlsFactory showError:@"微博分享失败,不支持的请求" ] ;
                break;
            default:
                break;
        }
        
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
//        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


@end
