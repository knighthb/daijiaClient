//
//  DJAdObject.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-15.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJAdObject : NSObject

@property  int location ;
@property  int status ;
@property ( strong )  NSString *title ;
@property ( strong )  NSString *clazz ;
@property ( strong )  NSString *url ;
@property ( strong )  NSString *createTime ;
@property ( strong )  NSString *startTime ;
@property ( strong )  NSString *endTime ;
@property int showOrder ;
@property ( strong ) NSString *pic ;


-(void ) deserialize:(NSMutableDictionary *) dict ;

@end
