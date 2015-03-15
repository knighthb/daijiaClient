//
//  DJWeiboDelegate.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-16.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface DJWeiboDelegate : NSObject<WeiboSDKDelegate>


/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request;

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response;


@end
