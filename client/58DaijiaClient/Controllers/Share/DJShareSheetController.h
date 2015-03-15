//
//  DJShareSheetController.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-13.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJShare.h"



static const int  SHARE_TAG_SINA = 1 ;
static const int  SHARE_TAG_QQ = 2 ;
static const int  SHARE_TAG_WEIXIN = 3 ;
static const int  SHARE_TAG_TIMELINE = 4 ;

@class DJShareSheetController ;

@protocol DJShareSheetDelegate <NSObject>

-(void) shareSheet:(DJShareSheetController *)sheet didClickButton:(int) buttonTag ;

@end

@interface DJShareSheetController : UIViewController{
    int _shareTag ;
}
@property (strong) DJShare *model ;

@property ( weak , nonatomic ) id<DJShareSheetDelegate> delegate ;

-(void) shareSuccess:(int) tag;


@end
