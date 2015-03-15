//
//  DJEncryptUtil.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-25.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJEncryptUtil.h"
@implementation DJEncryptUtil


+(NSString *) md5:(NSString *) plainText
{
    if (plainText == nil) {
        return nil;
    }
    const char * cStr = [plainText UTF8String];
    unsigned char code[16];
    CC_MD5(cStr,strlen(cStr),code);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            code[0],code[1],code[2],code[3],
            code[4],code[5],code[6],code[7],
            code[8],code[9],code[10],code[11],
            code[12],code[13],code[14],code[15]];
//        return [NSString stringWithFormat:@"%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",
//                (char)code[0],(char)code[1],(char)code[2],(char)code[3],
//                (char)code[4],(char)code[5],(char)code[6],(char)code[7],
//                (char)code[8],(char)code[9],(char)code[10],(char)code[11],
//                (char)code[12],(char)code[13],(char)code[14],(char)code[15]];
}

+(NSString *) encryptUrl:(NSDictionary *) params key:(NSString *) key
{//在http头里面加两个东西 i＝1，c＝返回的东西
    NSComparator md5Compare = ^(NSString * Str1, NSString * Str2){
        return  [ [self md5:Str1 ] caseInsensitiveCompare:[self md5:Str2]];
    };
    NSMutableArray * paramNames = [[NSMutableArray alloc] init];
    for (NSString * param in [params allKeys]) {
        NSMutableString * paramName = [NSMutableString stringWithString:param];
        while ([paramName length]< 5) {
            [paramName appendString:@"`"];
        }
        [paramNames addObject:paramName];
    }
    NSMutableArray * sortedParamNames = (NSMutableArray *)[paramNames sortedArrayUsingComparator:md5Compare];
    NSMutableString * newParam = [NSMutableString stringWithString:@""];
    for (NSString * param in sortedParamNames) {
        NSString * paramName;
      NSRange  range =  NSMakeRange(0 , [param length]);
        NSLog(@"%d",range.length);
        paramName = [param stringByReplacingOccurrencesOfString:@"`" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [param length])];
        if ([newParam isEqualToString:@""]) {
            [newParam appendString:paramName];
            [newParam appendString:@"="];
            [newParam appendString:[params objectForKey:paramName]];
        }else{
            [newParam appendString:@"&"];
            [newParam appendString:paramName];
            [newParam appendString:@"="];
            [newParam appendString:[params objectForKey:paramName]];
        }
    }
    NSLog(@"newParam = %@",newParam);
    [newParam appendString:key];
    NSLog(@"newParam = %@",newParam);
   return [self md5:newParam];
//    NSMusicDirectory * md5
}
@end
