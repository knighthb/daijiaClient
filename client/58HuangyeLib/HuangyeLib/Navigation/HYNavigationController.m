//
//  JMB_NavigationViewController.m
//  JMBFramework
//
//  Created by zhangyu on 13-9-25.
//  Copyright (c) 2013年 jion-cheer. All rights reserved.
//

#import "HYNavigationController.h"
#import "PrettyNavigationBar.h"
#import "PrettyToolbar.h"
#import "PrettyDrawing.h"

@interface HYNavigationController ()

@end

@implementation HYNavigationController
@synthesize rootViewController;

-(id)initWithRootViewController:(UIViewController *)rootViewController1
{
    self = [super initWithNavigationBarClass:[PrettyNavigationBar class] toolbarClass:[PrettyToolbar class]];
    if (self) {
        self.rootViewController = rootViewController1 ;
        [self pushViewController:rootViewController animated:NO];
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [UIColor whiteColor], UITextAttributeTextColor,                                                                         nil]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad ] ;
//    PrettyNavigationBar *bar = (PrettyNavigationBar *)self.toolbar ;
//    bar.contentMode = UIViewContentModeRedraw;
    //        bar.shadowOpacity = ;
//    bar.gradientStartColor = [UIColor colorWithHex:0xffff00] ;
//    bar.gradientEndColor = [UIColor colorWithHex:0xffff00] ;
//    bar.topLineColor = [UIColor colorWithHex:0xffff00] ;
//    bar.bottomLineColor = [UIColor colorWithHex:0xffff00] ;
//    bar.tintColor = [UIColor orangeColor] ;
    //        self.toolbar.roundedCornerColor = default_roundedcorner_color;
    //        bar.roundedCornerRadius = 0.0;
    

}


-(UIBarButtonItem *)createBackButton{
   
    UIImage *image = [UIImage imageNamed:@"navi_back"];
        
    UIBarButtonItem* item = [HYNavigationController createNavItemWithImage:image target:self action:@selector(popSelf) type:1];
    return  item ;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
//    viewController 
}

+(UIBarButtonItem*)createNavItemWithImage:(UIImage *)image target:(id)target action:(SEL)action type:(NSInteger)type{
    CGFloat leftMargin = 15;
    CGFloat rightMargin = 15;
    if (type == 1) {
        //居左
        leftMargin = 5;
        rightMargin = 10;
    }else if (type == 2) {
        //居右
        leftMargin = 20;
        rightMargin = 10;
    }else{
        //居中
        leftMargin = 15;
        rightMargin = 15;
    }
    
    CGRect frame= CGRectMake(leftMargin, 0, image.size.width, image.size.height);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width + leftMargin + rightMargin, frame.size.height)];
    view.tag = 990011;
    UIButton *someButton= [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setShowsTouchWhenHighlighted:YES];
    [someButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(functionButtonClick:)];
//    [view addGestureRecognizer:recognizer];
    [view addSubview:someButton];
    UIBarButtonItem *someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:view];
    return someBarButtonItem;
}

-(void)popSelf {
    [self popViewControllerAnimated:YES];
}

@end
