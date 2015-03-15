//
//  HYSmartViewController.h
//  58HuangyeLib
//
//  Created by 周文杰 on 14-4-14.
//  Copyright (c) 2014年 周文杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define IsIOS6 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6)


@interface HYSmartViewController : UIViewController{

}
@property (nonatomic , strong ) UIView *contentView ;

@property BOOL tabbed;

+(void) IOS7ToIOS6ofFrame:(UIViewController *) vc;

+(void) IOS7ToIOS6ofBounds:(UIViewController *) vc;

- (id)initWithTitle:(NSString *) title1 ;

- (id)initWithTitle:(NSString *) title1  tabbed:(BOOL) tabbed ;
@end
