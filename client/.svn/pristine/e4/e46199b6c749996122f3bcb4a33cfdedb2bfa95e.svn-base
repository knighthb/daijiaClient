//
//  LocationManagerUtil.m
//  58DaijiaClient
//
//  Created by huangbin on 14-5-20.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "LocationManagerUtil.h"

@implementation LocationManagerUtil
@synthesize locationManager;
//@synthesize location;

+(LocationManagerUtil*) sharedLocationManagerUtil{
    @synchronized(self){
        if (sharedLocationManagerUtil==nil) {
            sharedLocationManagerUtil = [[self alloc] init];
        }
    }
    return sharedLocationManagerUtil;
}

-(void) relocation{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager startUpdatingLocation];
}

-(id) init{
    if (self = [super init]) {
        if (self.locationManager==nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.distanceFilter = kCLLocationAccuracyKilometer;
            //locationManager的delegate放到客户端去设置
        }
    }
    return self;
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    self.location = [locations lastObject];
//    [self.delegate didUpdateLocation];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    [self.delegate didFailWithError:error];
//    
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//	didUpdateToLocation:(CLLocation *)newLocation
//		   fromLocation:(CLLocation *)oldLocation
//{
//    self.location = newLocation;
//    [self.delegate didUpdateLocation];
//    
//}




@end
