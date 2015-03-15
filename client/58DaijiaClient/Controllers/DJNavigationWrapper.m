//
//  DJDriverWrapperViewController.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-14.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJNavigationWrapper.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"

@interface DJNavigationWrapper ()

@end

@implementation DJNavigationWrapper

-(UIBarButtonItem *)createBackButton{
    
    CGFloat leftMargin = -6;
    CGFloat rightMargin = 0;
    CGRect frame= CGRectMake(leftMargin, 0, 65, 26);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width + leftMargin + rightMargin, frame.size.height)];
    view.backgroundColor = COLOR_ORANGE ;
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
//    backGesture = [[UIPanGestureRecognizer alloc ] initWithTarget:self action:@selector(backAnimation:) ] ;
//    [self.view addGestureRecognizer:backGesture ] ;
    
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
    [UIView setAnimationDuration:0.25];
    self.view.alpha = 1.0;
    [UIView commitAnimations];
    [_splashImageView removeFromSuperview];
}

-(void) backAnimation:(UIPanGestureRecognizer*)gestureRecognizer{
    if ( [self.viewControllers count ] <= 1 ) {
        return ;
    }
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    CGPoint curPoint = [gestureRecognizer locationInView:self.view ];
    CGPoint move = [gestureRecognizer translationInView:self.view ] ;

    if ( curPoint.x - move.x > self.view.frame.size.width /2 ) {
        return ;
    }
    if ( move.x < 0 ) {
        return ;
    }
//    move.x
    CGAffineTransform transform = CGAffineTransformMakeTranslation(move.x, 0);
//    //Scale
//    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//    //Rotate
//    transform = CGAffineTransformRotate(transform, radians(60));
    [self.topViewController.view setTransform:transform];
    
    if ([(UIPanGestureRecognizer *)gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        //划开后的下层view
        UIViewController *vc = [self.viewControllers objectAtIndex: [ self.viewControllers count] - 2 ] ;
        [self.view insertSubview:vc.view atIndex:0 ] ;
        
    }
    //手指离开
     if (([(UIPanGestureRecognizer *)gestureRecognizer state] == UIGestureRecognizerStateEnded) || ([(UIPanGestureRecognizer *)gestureRecognizer state] == UIGestureRecognizerStateCancelled)) {
         
         CATransition* animation = [CATransition animation];
         //动画时间
         animation.duration = 0.2f;
         animation.type = kCATransitionMoveIn ;//  @"unGenieEffect";
         //先慢后快
         animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear ] ;
         animation.fillMode = kCAFillModeForwards;
         
         typeof(self) __weak weakSelf = self;

         
         if ( move.x <= self.view.frame.size.width /2) {
             
             animation.subtype =  kCATransitionFromRight ;
             [UIView animateWithDuration:0.2 animations:^{
                 CGRect frame =  weakSelf.topViewController.view.frame ;
                 frame.origin.x =0 ;
                 self.topViewController.view.frame = frame;
             } completion:^(BOOL finished) {
                 
                 UIViewController *vc = [weakSelf.viewControllers objectAtIndex: [ weakSelf.viewControllers count] - 2 ] ;
                 [vc.view removeFromSuperview ] ;
             }];
            
             return ;
         }
         else {
             [UIView animateWithDuration:0.2 animations:^{
                 CGRect frame =  self.topViewController.view.frame ;
                 frame.origin.x = self.topViewController.view.frame.size.width ;
                 self.topViewController.view.frame = frame;
             } completion:^(BOOL finished) {
                 
                 [self popViewControllerAnimated:NO ] ;

             }];
             return ;
         }
             
     }
    
}


#pragma mark - TabedViewController
-(NSString *) getTitle
{
    id vc = self.rootViewController ;
    if( [ vc respondsToSelector:@selector(getTitle)] )
     return  [vc getTitle ] ;
    return  nil ;
}

-(UIImage *) getActiveBgImage
{
    id vc = self.rootViewController ;
    if( [vc respondsToSelector:@selector(getActiveBgImage)] )
       return [vc getActiveBgImage ] ;
    return  nil ;
}

-(UIImage *) getDeactiveBgImage
{
    id vc = self.rootViewController ;

    if( [vc respondsToSelector:@selector(getDeactiveBgImage)] )
       return [vc getDeactiveBgImage ] ;
    return  nil ;
}
//-(void) tabController:(UIViewController *)tab willLeaveTab:(id<TabedViewController>)vc ofIndex:(int) tabIndex  {
//    
//    if ( vc == self) {
//        id top = self.topViewController ;
//        if ( [top respondsToSelector:@selector(tabController:willLeaveTab:ofIndex:)] ) {
//            [top tabController:tab willLeaveTab:vc ofIndex:tabIndex  ];
//        }
//    }
//    
//}


-(void) enterForground{
    
    id top = self.topViewController ;
    if ( [top respondsToSelector:@selector(enterForground)] ) {
        [top enterForground ];
    }

}
-(void) enterBackground {
    id top = self.topViewController ;
    if ( [top respondsToSelector:@selector(enterBackground)] ) {
        [top enterBackground ];
    }

}

@end
