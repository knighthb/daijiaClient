//
//  DJConst.m
//  58DaijiaClient
//
//  Created by 58 on 14-4-3.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJConst.h"

@implementation DJConst
@synthesize  location;

-(id) init
{
    if (self = [super init]) {
        instance = nil;
    }
    return self;
}


+(DJConst *) getDJConstInstance{
    if (instance == nil){
        instance = [[DJConst alloc] init];
    }
    return instance;

}

+(BOOL) canRefresh
{
    return canRefresh;
}
+(void) setCanRefresh:(BOOL) flag
{
    canRefresh = flag;
}

+(BOOL) canReturn
{
    return canReturn;
}

+(void) setCanreturn:(BOOL) flag
{
    canReturn = flag;
}


@end
