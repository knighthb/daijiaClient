//
//  DJOrderEntity.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderEntity.h"

@implementation DJOrderEntity
@synthesize coordinate;
@synthesize driverID;
@synthesize driverPhone;
@synthesize userPhone;
@synthesize timestamp;

-(id) initWithDriverID:(NSString *) driverid
             userPhone:(NSString *) userphone
           driverPhone:(NSString *) driverphone
            coordinate:(CLLocationCoordinate2D) coord
{
    if (self = [super init]) {
        self.driverID = driverid;
        self.userPhone = userphone;
        self.driverPhone = driverphone;
        self.coordinate = coord;
    }
    return self;
}
@end
