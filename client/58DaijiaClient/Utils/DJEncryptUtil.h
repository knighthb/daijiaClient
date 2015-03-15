//
//  DJEncryptUtil.h
//  58DaijiaClient
//
//  Created by huangbin on 14-4-25.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJEncryptUtil : NSObject
+(NSString *) encryptUrl:(NSDictionary *) params key:(NSString *) key;


+(NSString *) md5:(NSString *) plainText ;

@end
