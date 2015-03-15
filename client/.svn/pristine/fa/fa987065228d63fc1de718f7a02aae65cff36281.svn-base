//
//  DJDriverMainViewController.m
//  58DaijiaClient
//  司机主视图控制器
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverMainViewController.h"
#import "DJControlsFactory.h"
#import "DJDriveListViewController.h"
#import "DJDriverMapViewController.h"
#import "LocationManagerUtil.h"

@interface DJDriverMainViewController ()

@end

@implementation DJDriverMainViewController

-(id) init
{
    if (self = [super init]) {
        NSArray * childViewControllers = @[[[DJDriveListViewController alloc] init],
                                           [[DJDriverMapViewController alloc] init]];
        [self setChildViewControllers:childViewControllers];

    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view.
    for (int i=0; i<[self.childViewControllers count]; i++) {
        if ([self.childViewControllers[i] isKindOfClass:[DJDriveListViewController class]]) {
            self.delegate = self.childViewControllers[i];
        }else if([self.childViewControllers[i] isKindOfClass:[DJDriverMapViewController class]] && self.delegate!=nil){
            [self.delegate setMapviewController:self.childViewControllers[i]];
            
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TabedViewController
-(NSString *) getTitle
{
    return @"附近司机";
}

-(UIImage *) getActiveBgImage
{
    return [UIImage imageNamedFrombundle:@"附近选中"];
}

-(UIImage *) getDeactiveBgImage
{
    return [UIImage imageNamedFrombundle:@"附近"];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self enterForground ] ;
    
}

-(void) enterForground{
    
    //每次进入司机类别时定位一次
    [[LocationManagerUtil sharedLocationManagerUtil] relocation ] ;
}


-(UIBarButtonItem *) getRightBarbuttonItem {
    UIBarButtonItem * rightBarButtonItem = [DJControlsFactory createNavigationItemImage:[UIImage imageNamedFrombundle:@"刷新"]   target:self action:@selector(refreshLocation:)];
    rightBarButtonItem.tintColor = [UIColor whiteColor];
    return rightBarButtonItem ;
}


-(void) refreshLocation:(id) sender
{
    NSLog(@"refreshLocation");
    if ([self.selectedController isKindOfClass:[DJDriveListViewController class]]) {
        [((DJDriveListViewController *) self.selectedController) refreshLocation:sender];
        return;
    }
    if ([self.selectedController isKindOfClass:[DJDriverMapViewController class]]) {
        [((DJDriverMapViewController *) self.selectedController) refreshLocation:sender];
        return;
    }
}

-(void) tabController:(UIViewController *)tab willLeaveTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  {
    
    DJDriveListViewController *driveList = [self.childViewControllers objectAtIndex:0 ] ;
    [driveList becomeUntabed ];
}

-(void) tabController:(UIViewController *)tab didEnterTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  {
    
}

-(void) enterBackground {
    
    DJDriveListViewController *driveList = [self.childViewControllers objectAtIndex:0 ] ;
    [driveList enterBackground ];
}


@end
