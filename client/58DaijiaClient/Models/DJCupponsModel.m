//
//  DJCupponsModel.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-11.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJCupponsModel.h"

@implementation DJCupponsModel
@synthesize expireTime;
@synthesize typeName;
@synthesize useTime;
@synthesize code;
-(void) setState:(int)cupponState
{
    state = cupponState;
}

-(void) setAmount:(float)cupponAmount
{
    amount = cupponAmount;
}

-(int) state
{
    return state;
}

-(float) amount
{
    return amount;
}

@end
