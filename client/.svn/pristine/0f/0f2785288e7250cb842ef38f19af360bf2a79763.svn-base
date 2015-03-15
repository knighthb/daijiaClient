//
//  DJDriverAnnotation.m
//  58DaijiaClient
//  附近司机标注
//  Created by 58 on 14-4-3.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverAnnotation.h"
#import "DJDriverModel.h"

@implementation DJDriverAnnotation
//@synthesize coordinate;

- (id) initWithDriver:(DJDriverModel *)driver
{
    if (self = [super init]) {
        _coordinate = CLLocationCoordinate2DMake(driver.latitude, driver.longitude);
        self.driver = driver;
    }
    return  self;
}

- (NSString *)title
{
    return self.driver.name;
}

// optional
- (NSString *)subtitle
{
    NSString * sub = [NSString stringWithFormat:@"驾龄:%d年   籍贯:%@\r\n距离:%fkm",self.driver.year,self.driver.homeCity,self.driver.distance];
    NSLog(@"subtitle:%@",sub);
    return [NSString stringWithFormat:@"驾龄:%d年   籍贯:%@\r\n距离:%.2fkm",self.driver.year,self.driver.homeCity,self.driver.distance];
}
@end
