//
//  DJShareViewController.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HuangyeLib/HYSmartViewController.h>
#import "DJShare.h"
#import "DJShareSheetController.h"
#import "DJTabController.h"

@interface DJShareViewController : HYSmartViewController<TabedViewController , UITableViewDataSource , UITableViewDelegate>{
    UITableView *_adsView ;
    @private
    NSMutableDictionary *_imageMap ;
}

@property (strong) DJShare *model ;
@property (strong) DJShareSheetController *shareSheet ;
@property (strong) UITableViewController *adsList ;

-(NSString *) getTitle ;

-(UIImage *) getActiveBgImage ;

-(UIImage *) getDeactiveBgImage ;

@end
