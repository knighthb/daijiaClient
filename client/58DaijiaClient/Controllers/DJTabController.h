//
//  DJRootController.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HuangyeLib/RKTabView.h>

@protocol TabedViewController <NSObject>

-(NSString *) getTitle ;

-(UIImage *) getActiveBgImage ;

-(UIImage *) getDeactiveBgImage ;

-(void) tabController:(UIViewController *)tab willLeaveTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  ;

-(void) tabController:(UIViewController *)tab didEnterTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  ;

-(UIView *) getTitleView ;

-(UIBarButtonItem *) getRightBarbuttonItem ;

@end


@interface DJTabController : UIViewController<RKTabViewDelegate>{
    int _currentIndex ;
    int _lastIndex ;
    UIView *_contentView ;
}

@property (retain , readwrite) RKTabView *titledTabsView;
//@property (retain , readwrite) NSMutableArray *viewControllers ;


+(DJTabController *) shareInstance;

- (id)initWithSubViews:(NSMutableArray *)subviews ;

-(void) showTab:(int) index ;
-(void) showPrevious ;

-(void) enterForground;
-(void) enterBackground;

@end
