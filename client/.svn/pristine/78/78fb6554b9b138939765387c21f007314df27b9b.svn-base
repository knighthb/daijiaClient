//
//  DJShareManager.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-13.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJShareSheetController.h"


@interface DJShareManager : NSObject{
     DJShareSheetController *_active;
}

+(DJShareManager *) sharedManager ;

@property (strong , atomic) NSMutableArray *instances  ;

@property (strong , atomic ,setter = setActivie:,getter = getActive ) DJShareSheetController *active;

-(void) addInstance:(DJShareSheetController *) ins ;

-(void) setActivie :(DJShareSheetController *) ins ;

-(void) setDeactivie :(DJShareSheetController *) ins ;


-(DJShareSheetController *) getActive ;


@end
