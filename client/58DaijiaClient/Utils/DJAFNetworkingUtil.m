//
//  DJAFNetworkingUtil.m
//  58DaijiaClient
//  AFNetworking封装
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJAFNetworkingUtil.h"
#import "DJEncryptUtil.h"
#import "ImageBuffer.h"

@implementation DJAFNetworkingUtil
@synthesize delegate;
+(AFJSONRequestOperation *) sendJsonHttpRequest:(NSString *)urlStr
                       data:(NSMutableArray *)data
                    delegate:(id)delegate
{
    static NSString * key = @"~!@#$%^&*";
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    NSMutableDictionary * paramsDic = [[NSMutableDictionary alloc] init];
    NSArray * urlParts=[(NSMutableString *)urlStr componentsSeparatedByString:@"?"];
    if ([urlParts count]>1) {
        NSMutableString * params = [urlParts objectAtIndex:1];
      NSArray * paramsArray = [params componentsSeparatedByString:@"&"];
        for (NSMutableString * param in paramsArray) {
           NSArray * parts = [param componentsSeparatedByString:@"="];
            NSMutableString * name = [parts objectAtIndex:0];
            NSMutableString * value = [NSMutableString stringWithString:@""];
            if ([parts count]>1) {
                value  = [parts objectAtIndex:1];
            }
            [paramsDic setObject:value forKey:name];
        }
    }
    NSString * code = [DJEncryptUtil encryptUrl:paramsDic key:key];
    NSLog(@"code = %@",code);
    [request addValue:code forHTTPHeaderField:@"c"];
    [request addValue:@"1" forHTTPHeaderField:@"i"];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json", @"text/javascript",@"application/json",@"text/html",@"text/plain", nil]];
    AFJSONRequestOperation * operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([delegate respondsToSelector:@selector(processAFNJsonResult:response:json:dataArray:)]) {
            [delegate processAFNJsonResult:request response:response json:JSON dataArray:data];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [delegate processAFNErrorResult:request response:response error:error json:JSON];
        if ([delegate respondsToSelector:@selector(processAFNErrorResult:response:error:json:)]) {
            [delegate processAFNErrorResult:request response:response error:error json:JSON];
        }
    }];
    [operation start];
    return operation;
}


+(void) sendHttpRequest:(NSString *) urlstr
                   data:(NSMutableDictionary *) params
                success:(void (^)(id resp))successblock failed:(void (^)(NSError *error)) errorblock {
    static NSString * key = @"~!@#$%^&*";
    
    NSMutableString *urlStrWithParam = [[NSMutableString alloc ] init ];
    [urlStrWithParam appendString:urlstr ];
    int i = 0 ;
    for ( NSString *key in  params.keyEnumerator  ) {
        if ( i == 0 ) {
            [urlStrWithParam appendString:@"?" ];
        }else
            [urlStrWithParam appendString:@"&" ];
        id value = [params objectForKey:key ] ;
        [urlStrWithParam appendFormat:@"%@=%@",key , value ];
        i++ ;
    }
    NSString *urlstr2 = [ urlStrWithParam stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ] ;
    NSURL * url = [NSURL URLWithString:urlstr2];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];

    NSString * code = [DJEncryptUtil encryptUrl:params key:key];
    [request addValue:code forHTTPHeaderField:@"c"];
    [request addValue:@"1" forHTTPHeaderField:@"i"];

    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json", @"text/javascript",@"application/json",@"text/html",@"text/plain", nil]];
    AFJSONRequestOperation * operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        successblock( JSON ) ;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        errorblock( error ) ;
        
    }];

    [operation start];
}


+(void) loadPicWihtURL:(NSString *) url name:(NSString *) name observer:(id) observer forKey:(NSString *)key
{
    
    UIImage * imageFromImageBuffer = [[ImageBuffer sharedImageBuffer] readFromBufferWithKey:name path:key];
    if (imageFromImageBuffer == nil) {
        NSURL * nsUrl = [NSURL URLWithString:url];
        NSURLRequest * request = [NSURLRequest requestWithURL:nsUrl];
        AFImageRequestOperation * operrations = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [observer setValue:image forKey:key];
            [[ImageBuffer sharedImageBuffer] addToBufferWithKey:key value:image immediatelyWrite:NO];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            //如果异步加载失败则同步加载图片，貌似不太好
            NSData * picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            [observer setValue:[UIImage imageWithData:picdata] forKey:key];
        }];
        [operrations start];
    }else{
        [observer setValue:imageFromImageBuffer forKey:key];
    }
    
}

@end
