//
//  DJDriverMapViewController.h
//  58DaijiaClient
//  司机地图视图控制器
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DJDriveListViewController.h"
#import "DJDriverModel.h"
#import <HuangyeLib/HYSmartViewController.h>
static CLLocation * currentLocation;
@class DJDriveListViewController;
@interface DJDriverMapViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapview;
@property (strong, nonatomic) CLLocation * location;
@property (strong, nonatomic) NSMutableArray * drivers;
-(void) refreshLocation:(id) sender;
+(CLLocation *) getCurrentLoction;

@end
