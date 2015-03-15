//
//  DJDriverCalloutAnnotation.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-17.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverCalloutAnnotation.h"

@implementation DJDriverCalloutAnnotation
- (id) initWithDriver:(DJDriverModel *)driver
{
    if (self = [super init]) {
        _coordinate = CLLocationCoordinate2DMake(driver.latitude, driver.longitude);
        self.driver = driver;
    }
    return  self;
}

@end
