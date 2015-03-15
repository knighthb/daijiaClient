//
//  DJDriverMainViewController.h
//  58DaijiaClient
//  司机地图视图控制器
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJTabController.h"
#import "DJSegementContainer.h"

@class DJDriverMapViewController;
@protocol DJDriverViewControllerDelegate <NSObject>
-(void) setMapviewController:(DJDriverMapViewController *) mapViewController;
-(void) setSegmentedControl:(UISegmentedControl *) control;
@end

@interface DJDriverMainViewController : DJSegementContainer<TabedViewController>

@property(assign,nonatomic) id<DJDriverViewControllerDelegate> delegate;


@end
