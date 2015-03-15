//
//  DJAFNetworkingUtil.h
//  58DaijiaClient
//  AFNetworking封装
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"



@protocol AFNProcessDelegate <NSObject>

/**
 *  Method : processAFNJsonResult
 *  Description : 处理AFNetworking中JSONRequestOperationWithRequest成功后的回调函数
 *  Params
 *      request : http请求
 *      response : http请求返回的响应
 *      Json : 以Json结构返回的请求数据
 *      data : 要保存的数据
 *  return : void
 */
@required
-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data;

/**
 *  Method : processAFNErrorResult
 *  Description : 处理AFNetworking中JSONRequestOperationWithRequest失败后的回调函数
 *  Params
 *      request : http请求
 *      response : http请求返回的响应
 *      error : 请求失败后的错误信息
 *      Json : 以Json结构返回的请求数据
 *  return : void
 */
@required
-(void) processAFNErrorResult:(NSURLRequest *)request
                     response:(NSHTTPURLResponse *)response
                        error:(NSError *)error
                         json:(id) JSON;

@end

@interface DJAFNetworkingUtil : NSObject

@property (nonatomic, assign) id<AFNProcessDelegate> delegate;

/**
 *  Method : sendJsonHttpRequest
 *  Description : 封装JSONRequestOperationWithRequest
 *  Params
 *      url : 需要请求的url地址
 *      data : 要保存的数据
 *  return : void
 */
+(AFJSONRequestOperation *) sendJsonHttpRequest:(NSString *) url
                       data:(NSMutableArray *) data
                   delegate:delegate;

+(void) sendHttpRequest:(NSString *) url
                       data:(NSMutableDictionary *) params
                success:(void (^)(id resp))successblock failed:(void (^)(NSError *error)) errorblock ;

+(void) loadPicWihtURL:(NSString *) url name:(NSString *) name observer:(id) observer forKey:(NSString *)key;

@end
