//
//  DJCheckUtil.h
//  58DaijiaClient
//  检查工具
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DJCheckUtil : NSObject

/**
 *  Method : checkVersion
 *  Description : 检查版本是否需要更新，如果要更新则定位到appstore下载
 *  Params  void
 *  return : void
 */void checkVersion();


bool isLogin();

@end
