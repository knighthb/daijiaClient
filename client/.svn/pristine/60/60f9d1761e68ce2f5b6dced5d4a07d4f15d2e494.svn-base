//
//  DJDriveListViewController.h
//  58DaijiaClient
//  司机列表视图控制器
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapKit/MapKit.h"
#import "DJDriverModel.h"
#import <HuangyeLib/HYSmartTableViewController.h>
#import "LocationManagerUtil.h"


@class DJOrderEntity;
@protocol DJDriverViewControllerDelegate;

@protocol DJMapviewPositionDelegate <NSObject>
-(void) setPosition:(CLLocation *) location
             DriverList:(NSArray *) drivers
           delegate:(id) delegate;
;
-(void) refreshMapview;
@end
@interface DJDriveListViewController : UITableViewController <CLLocationManagerDelegate , MKReverseGeocoderDelegate ,DJDriverViewControllerDelegate,AFNProcessDelegate ,DJLocationManagerUtilDelegate>
{
    @private
    DJOrderEntity * _order4commit ;
}
@property(strong,nonatomic) CLLocationManager * locationManager;
@property(assign,nonatomic) id<DJMapviewPositionDelegate> positionDelegate;
//@property (strong ,nonatomic) NSMutableArray * data;
@property (strong ,nonatomic) NSMutableArray * driverList58 ;
@property (strong ,nonatomic) NSMutableArray * driverListOther ;
-(void) refreshLocation:(id) sender;
- (void) refreshData;

-(void) becomeUntabed;

-(void) enterBackground ;
@end
