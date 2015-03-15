//
//  DJOrderStatus.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJOrderStatus : NSObject

@property (nonatomic , strong ) NSString *name ;

@property (nonatomic , strong ) NSString *time ;

@property (nonatomic , strong ) NSString *location ;

@property  CLLocationCoordinate2D userLocation ;

@property  CLLocationCoordinate2D driverLocation ;


-(id) initWithStatusName:(NSString *) name time:(NSString *)time location:(NSString *)location ;

@end
