//
//  DJShareObject.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-15.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJShareObject : NSObject

@property (strong) NSString *title ;

@property (strong) NSString *description ;

@property (strong) NSString *image ;

@property (strong) NSString *url ;

-(void ) deserialize:(NSMutableDictionary *) dict ;

@end
