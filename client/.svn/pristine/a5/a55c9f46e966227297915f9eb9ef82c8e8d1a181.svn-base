//
//  LocationManagerUtil.h
//  58DaijiaClient
//
//  Created by huangbin on 14-5-20.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class LocationManagerUtil;
static LocationManagerUtil * sharedLocationManagerUtil;

@protocol DJLocationManagerUtilDelegate <NSObject>
//这个协议暂时没有用

-(void) didUpdateLocation;

-(void) didFailWithError:(NSError *) error;

@end

@interface LocationManagerUtil : NSObject<CLLocationManagerDelegate>

+(LocationManagerUtil *) sharedLocationManagerUtil;
-(void) relocation;
@property (nonatomic, strong) CLLocationManager * locationManager;
//@property (nonatomic, strong) CLLocation  * location;
@property (nonatomic) id<DJLocationManagerUtilDelegate> delegate;
@end
