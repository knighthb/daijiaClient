//
//  DJDriverModel.h
//  58DaijiaClient
//  司机model
//  Created by huangbin on 14-4-3.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJDriverModel : NSObject
{
    float latitude;
    float longitude;
}
@property (nonatomic,strong) NSString *  driverId;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * homeCity;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,strong) NSString * phoneNum;
@property (nonatomic,strong) NSString * source;
@property (nonatomic,strong) UIImage * pic;
@property (nonatomic,strong) NSString * distance;
@property (nonatomic,strong) NSString * picUrl;
-(float) latitude;
-(void) setLatitude:(float) lat;
-(float) longitude;
-(void) setLongitude : (float) lon;

-(void) deserialize:(NSDictionary *) dic ;

@end
