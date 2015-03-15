//
//  HYSmartViewController.m
//  58HuangyeLib
//
//  Created by 周文杰 on 14-4-14.
//  Copyright (c) 2014年 周文杰. All rights reserved.
//

#import "HYSmartViewController.h"

//@interface HYSmartViewController ()
//
//@end

@implementation HYSmartViewController


- (id)initWithTitle:(NSString *) title1 ;
{
    return [self initWithTitle:title1 tabbed:NO ] ;
}

- (id)initWithTitle:(NSString *) title1  tabbed:(BOOL) tabbed1 {
    
    self = [super init  ];
    if (self) {
        self.title = title1 ;
        self.tabbed = tabbed1 ;
    }
    return self;
}


#pragma mark 导航栏覆盖/平铺
+(void) IOS7ToIOS6ofFrame:(UIViewController *)vc
{
    if (IsIOS7) {
        CGRect rect = vc.view.frame;
        GLfloat head = vc.topLayoutGuide.length ;//> 0 ? vc.topLayoutGuide.length : 64 ;
        vc.view.frame = CGRectMake((rect.origin.x), (rect.origin.y+(IsIOS7? head :0)), (CGRectGetWidth(rect)), (CGRectGetHeight(rect)-(IsIOS7? head :0)));
    }
}

+(void) IOS7ToIOS6ofBounds:(UIViewController *)vc
{
    if (IsIOS7) {
        CGRect rect = vc.view.bounds;
        NSLog(@"%f" , vc.topLayoutGuide.length ) ;
        if (rect.origin.y != -1*vc.topLayoutGuide.length) {
            vc.view.bounds = CGRectMake((rect.origin.x), (rect.origin.y+(IsIOS7?vc.topLayoutGuide.length*(-1):0)), (CGRectGetWidth(rect)), (CGRectGetHeight(rect)));
        }
    }
}
//
//-(void) viewDidLayoutSubviews{
//    
//    [HYSmartViewController IOS7ToIOS6ofFrame: self ] ;
//    
//    [super viewDidLayoutSubviews ] ;
//    
//}

-(void) viewDidLoad {
    [super viewDidLoad ] ;

    CGRect rect = self.view.bounds;
    CGRect rect2 = self.view.frame ;

    self.view.backgroundColor = [UIColor clearColor  ];
    if ( IsIOS7) {
        UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
        GLfloat head = self.topLayoutGuide.length > 0 ? self.topLayoutGuide.length : 64 ;

        CGRect frame = CGRectMake(0,  head  , keyWindow.bounds.size.width ,  CGRectGetHeight(rect) - head ) ;
        
        self.edgesForExtendedLayout = UIRectEdgeAll ;
        self.contentView = [[UIView alloc ] initWithFrame:frame ] ;
    }else{
        rect2.origin.y = 0 ;
        self.view.frame = rect2 ;
        rect.size.height -= 44 ;//导航栏
        if (self.tabbed ) {
            rect.size.height -= 48 ;
        }
        self.contentView = [[UIView alloc ] initWithFrame:rect ] ;
//        self.contentView.backgroundColor = [UIColor greenColor ];
    }
    [self.view addSubview:self.contentView ] ;
    
//    [HYSmartViewController IOS7ToIOS6ofFrame: self ] ;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = YES;
//    self.navigationController.navigationBar.translucent = NO;
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHex:0xff9200]];
}


@end
