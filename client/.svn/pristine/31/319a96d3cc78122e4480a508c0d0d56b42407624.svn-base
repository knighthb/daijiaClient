//
//  DJOrderMainViewController.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderMainViewController.h"
#import "DJControlsFactory.h"
#import "DJCurrentOrderListViewController.h"
#import "DJAllOrderListViewController.h"
@interface DJOrderMainViewController ()

@end

@implementation DJOrderMainViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        NSArray * viewControllers = @[[[DJCurrentOrderListViewController alloc] init],
                                      [[DJAllOrderListViewController alloc] init]];
        [self setChildViewControllers:viewControllers];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabedViewController
-(NSString *) getTitle
{
    return @"订单";
}

-(UIImage *) getActiveBgImage
{
    return [UIImage imageNamedFrombundle:@"订单选中"];
}

-(UIImage *) getDeactiveBgImage
{
    return [UIImage imageNamedFrombundle:@"订单"];
}

-(void) tabController:(UIViewController *)tab didEnterTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  {
    
//    [self initNavigation ] ;
    
}

@end
