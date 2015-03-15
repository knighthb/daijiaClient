//
//  DJDriverCalloutAnnotation.h
//  58DaijiaClient
//
//  Created by huangbin on 14-4-17.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DJDriverModel.h"
@interface DJDriverCalloutAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) DJDriverModel * driver;
-(id) initWithDriver:(DJDriverModel *) driver;
@end
