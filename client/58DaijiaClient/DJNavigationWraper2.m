//
//  DJNavigationWraper2.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-4.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJNavigationWraper2.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"

@interface UINavigationItem (margin)

@end

@implementation UINavigationItem (margin)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        
        if (_leftBarButtonItem)
        {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        }
        else
        {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -15;
        
        if (_rightBarButtonItem)
        {
            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
    }
    else
    {
        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}

#endif
@end

@implementation DJNavigationWraper2


-(id)initWithRootViewController:(UIViewController *)rootViewController1
{
    self = [super initWithRootViewController:rootViewController1];
    if (self) {
        bottomViewController = rootViewController1 ;
    }
    return self;
}

-(UIBarButtonItem *)createBackButton{
    
    UIImage *image = [UIImage imageNamed:@"color"];
    
    CGFloat leftMargin = -10;
    CGFloat rightMargin = 0;
    CGRect frame= CGRectMake(leftMargin, 0, 65, 26);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width + leftMargin + rightMargin, frame.size.height)];
    view.backgroundColor = [UIColor colorWithPatternImage:image ] ;
    view.tag = 990011;
    UIButton *someButton= [[UIButton alloc] initWithFrame:frame];
    UIImage *arrow = [UIImage imageNamedFrombundle:@"返回" ] ;
    someButton.titleLabel.font = [UIFont systemFontOfSize:18 ];
    someButton.titleLabel.textColor = [UIColor whiteColor ] ;
    [someButton setTitle:@"返回" forState:UIControlStateNormal ] ;
    [someButton setImage:arrow forState:UIControlStateNormal ] ;
    [someButton setShowsTouchWhenHighlighted:YES];
    UIEdgeInsets insets = UIEdgeInsetsMake(3, -5, 0, 0) ;
    [someButton setTitleEdgeInsets:insets ] ;
    
    [someButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    //    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(functionButtonClick:)];
    //    [view addGestureRecognizer:recognizer];
    [view addSubview:someButton];
    UIBarButtonItem *someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:view];
    return someBarButtonItem;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad ] ;
    if (  [self.navigationBar respondsToSelector: @selector(setBarTintColor:) ] ) {
//        [self.navigationBar setBarTintColor:COLOR_ORANGE ] ;
//        self.navigationBar.translucent = YES ;
        //直接设置导航栏颜色，并设置半透明的话，颜色失真非常严重，所以这里设置有透明度的图片
        self.navigationBar.barStyle = UIBarStyleBlack ;
        [self.navigationBar setBackgroundImage:[UIImage imageNamedFrombundle:@"navibar"] forBarMetrics:UIBarMetricsDefault ] ;
    }
//    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
//    {
//        [[UINavigationBar appearance] setShadowImage:nil ]; //[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]
//    }
    
    if ( [DJUIUtils getWindowHeight] >= 568  ) {
        _splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"Default-568h"]];
    }else if( [DJUIUtils getWindowHeight] <= 480  ) {
        _splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"Default"]];
    }

    _splashImageView.frame = CGRectMake(0, 0, [DJUIUtils getWindowWidth], [DJUIUtils getWindowHeight]);
    [self.view addSubview:_splashImageView];
    self.view.alpha = 0.0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.25 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
    

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}
-(void)popSelf {
    [self popViewControllerAnimated:YES];
}

- (void)fadeScreen{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedFading)];
    self.view.alpha = 0.0;
    [UIView commitAnimations];
}

- (void) finishedFading{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.view.alpha = 1.0;
    [UIView commitAnimations];
    [_splashImageView removeFromSuperview];
}

#pragma mark - TabedViewController
-(NSString *) getTitle
{
    id vc = bottomViewController ;//.rootViewController ;
    if( [ vc respondsToSelector:@selector(getTitle)] )
        return  [vc getTitle ] ;
    return  nil ;
}

-(UIImage *) getActiveBgImage
{
    id vc = bottomViewController ;
    if( [vc respondsToSelector:@selector(getActiveBgImage)] )
        return [vc getActiveBgImage ] ;
    return  nil ;
}

-(UIImage *) getDeactiveBgImage
{
    id vc = bottomViewController ;
    
    if( [vc respondsToSelector:@selector(getDeactiveBgImage)] )
        return [vc getDeactiveBgImage ] ;
    return  nil ;
}

-(void) tabController:(UIViewController *)tab willLeaveTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  {
    
    if ( vc == self) {
        id top = self.topViewController ;
        if ( [top respondsToSelector:@selector(tabController:willLeaveTab:ofIndex:)] ) {
            [top tabController:tab willLeaveTab:vc ofIndex:tabIndex  ];
        }
    }
    
}

-(void) enterBackground {
  
    id top = self.topViewController ;
    if ( [top respondsToSelector:@selector(enterBackground)] ) {
        [top enterBackground  ];
    }
   
}

@end
