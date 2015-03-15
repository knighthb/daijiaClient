//
//  DJPriceItem.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-21.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJPriceItem.h"

@implementation DJPriceItem

-(id) initWithType:(int ) type  {
    
    self = [super init ] ;
    if ( self ) {
        switch ( type ) {
            case 0:
                self.time = @"07:00 -- 21:59" ;
                self.money = @"38元" ;
                self.time = @"/10公里" ;
//                self.time = @"07:00 -- 21:59" ;
                break;
            case 1:
                self.time = @"07:00 -- 21:59" ;

                break;
            case 2:
                self.time = @"07:00 -- 21:59" ;

                break;
            case 3:
                self.time = @"07:00 -- 21:59" ;

                break;
            default:
                break;
        }
        
    }
    return self ;
    
}

-(id) init  {
    
    self = [super init ] ;
    if ( self ) {
        
        
    }
    return self ;
    
}

@end
