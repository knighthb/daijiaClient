//
//  DJAdObject.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-15.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJAdObject.h"

@implementation DJAdObject
@synthesize location , status , title , clazz , url , createTime ,startTime ,endTime , showOrder , pic ;

-(void ) deserialize:(NSMutableDictionary *) dict {
    location = [[dict objectForKey:@"location" ] integerValue ] ;
    status = [[dict objectForKey:@"status" ] integerValue ] ;
    title = [dict objectForKey:@"title" ] ;
    clazz = [dict objectForKey:@"clazz" ] ;
    url = [dict objectForKey:@"url" ] ;
    if ( [url isKindOfClass: [NSNull class] ] ) {
        url = nil ;
    }
    createTime = [dict objectForKey:@"createTime" ] ;
    startTime = [dict objectForKey:@"startTime" ] ;
    endTime = [dict objectForKey:@"endTime" ] ;
    showOrder = [[dict objectForKey:@"showOrder" ] integerValue ]  ;
    pic = [dict objectForKey:@"pic" ] ;
    
}


@end
