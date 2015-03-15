//
//  DJShareManager.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-13.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJShareManager.h"


@implementation DJShareManager

static DJShareManager *_this ;

+(DJShareManager *) sharedManager {
    
    if (! _this ) {
        _this = [[DJShareManager alloc ] init ] ;
    }
    return  _this ;
}

-(void) addInstance:(DJShareSheetController *) ins {
    
    if ( ! self.instances ) {
        self.instances = [[NSMutableArray alloc ] init ] ;
    }else{
        for (int i = 0 ; i < self.instances.count ; i ++ ) { //清空已经不存在的ins
            
            DJShareSheetController *iVC = [self.instances objectAtIndex:i ] ;
            
            if ( iVC.view == nil ) {
                [self.instances removeObjectAtIndex:i ] ;
            }
        }
    }
    [self.instances addObject:ins ] ;
}

-(void) setActivie :(DJShareSheetController *) ins {
    _active = ins ;
}

-(void) setDeactivie :(DJShareSheetController *) ins {
    [self setActivie:nil ] ;
}


-(DJShareSheetController *) getActive{
    
    return _active;
    
}

@end
