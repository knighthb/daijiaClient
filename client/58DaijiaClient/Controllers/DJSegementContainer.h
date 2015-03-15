//
//  DJSegementContainer.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-30.
//  Copyright (c) 2014年 58. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <HuangyeLib/PPiFlatSegmentedControl.h>

@interface DJSegementContainer : UIViewController

@property(nonatomic,strong) PPiFlatSegmentedControl *segmentedControl;
@property(nonatomic,assign) UIViewController * selectedController;
@property(assign,nonatomic) NSInteger selectedIndex;


-(void)setChildViewControllers:(NSArray *) viewControllers;

@end
