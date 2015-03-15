//
//  DJOrderStatus.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderStatus.h"

@implementation DJOrderStatus

-(id) initWithStatusName:(NSString *) name1 time:(NSString *)time1 location:(NSString *)location1 {
    
    self = [super init ] ;
    if ( self ) {
        self.name = name1;
        self.time = time1 ;
        self.location = location1 ;
    }
    return self ;
}



-(void) deserialize:(NSDictionary *)map {
    
    
//    name =  ;
//    
//    time ;
//    
//    location ;
//    
//    userLocation ;
//    
//    driverLocation ;

    
    
}

@end
