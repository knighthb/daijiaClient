//
//  DJRootController.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJTabController.h"
#import "DJUIUtils.h"
#import <HuangyeLib/PrettyDrawing.h>
#import "DJControlsFactory.h"
#import "DJVersionChecker.h"
#import "libRDP.h"

@interface DJTabController (){

}
@end

@implementation DJTabController

@synthesize titledTabsView ; //, viewControllers

static DJTabController *_this;


+(DJTabController *) shareInstance{//单例的
    if (_this == nil ) {
        _this = [[DJTabController alloc ] init ] ;
    }
    return _this ;
}

- (id)init
{
    return [self initWithSubViews:nil ];
}

- (id)initWithSubViews:(NSMutableArray *)subviews
{
    if ( _this ) {  //单例的
//        _this.viewControllers = subviews ;
        for (UIViewController *iVC in subviews ) {
            [_this addChildViewController : iVC ] ;
        }
        return _this ;
    }
    self = [super init ];
    if (self) {
//        self.viewControllers = subviews ;
        for (UIViewController *iVC in subviews ) {
            [self addChildViewController : iVC ] ;
        }

        _currentIndex = -1 ;
        _lastIndex = -1 ;
        _this = self ;
    }
    return self;
}

#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ( _DJDEBUGGER ) {
        [RDP startServer];
    }


    CGFloat y = CGRectGetHeight(self.view.frame) - 48 ;
    CGRect frame =CGRectMake(0, y, [DJUIUtils getWindowWidth], 48);
    CGRect frame1 = self.view.bounds ;
    if ( ! IsIOS7 ) {
        frame.origin.y -= 44 ; //导航栏
        frame1.size.height -= 48 +44 ;
    }
    
    _contentView = [[UIView alloc ] initWithFrame: frame1 ] ;
    [self.view addSubview:_contentView ] ;
    CUSLinnerData *linnerFill  = [[CUSLinnerData alloc ] init ] ;
    linnerFill.fill = YES ;
    _contentView.layoutData = linnerFill ;
    _contentView.layoutFrame = [[CUSFillLayout alloc ] init ] ;
    _contentView.backgroundColor = [DJControlsFactory getBackgroundColor] ;
   
    
    titledTabsView = [[RKTabView alloc ] initWithFrame:frame ] ;
   
    NSMutableArray *tabItems = [[NSMutableArray alloc ] init ] ;
    
    for( NSInteger i = 0 ; i < self.childViewControllers.count ; i ++  ){
        id vc = [self.childViewControllers objectAtIndex:i ] ;
        UIImage *enabledImage = nil ;
        UIImage *disabledImage = nil;
        NSString *title1 = nil ;
        if( [vc respondsToSelector:@selector(getActiveBgImage)] )
            enabledImage = [vc getActiveBgImage ] ;
        if( [vc respondsToSelector:@selector(getDeactiveBgImage)] )
            disabledImage = [vc getDeactiveBgImage ] ;
        if( [vc respondsToSelector:@selector(getTitle)] )
            title1 = [vc getTitle ] ;
//        if ( [vc isKindOfClass:[UIViewController class] ]) {
//            UIViewController *con = vc ;
//            CGRect frame = con.view.frame ;
//            frame.size.height -= 48 ;
//            con.view.frame = frame ;
//        }
        
        RKTabItem *mastercardTabItem = [RKTabItem createUsualItemWithImageEnabled:enabledImage imageDisabled:disabledImage ];
        mastercardTabItem.titleString = title1;
        
        if( i == 0 )
            mastercardTabItem.tabState = TabStateEnabled;
        mastercardTabItem.fontColorDisabled = [UIColor colorWithHex:0x787878 ] ;
        mastercardTabItem.fontColorEnabled = COLOR_ORANGE ;
        mastercardTabItem.badgeValue = 1 ;
        [tabItems addObject:mastercardTabItem ] ;
    }
    
    //mastercardTabItem.tabState = TabStateEnabled;
    titledTabsView.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.98 alpha:0.95 ] ;
    self.titledTabsView.delegate = self;
    titledTabsView.drawTopBorder = YES ;
    titledTabsView.topBorderColor =  [UIColor  grayColor ] ;
    titledTabsView.titlesFont = [UIFont systemFontOfSize:10 ];
//    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.titledTabsView.titlesFontColor = [UIColor blackColor];
    
    self.titledTabsView.tabItems = tabItems;
    [self.view addSubview:titledTabsView ] ;
   
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showdefault) userInfo:nil repeats:NO] ;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated ];
    
    DJVersionChecker *checker = [[DJVersionChecker alloc ] init ] ;
    checker.notifyNoUpdate = NO ;
    [ checker  checkVersion ] ;
    
}

-(void) enterBackground{
    
    for ( id con in self.childViewControllers ) {
        if ( [con respondsToSelector:@selector(enterBackground)] ) {
            [con enterBackground ];
        }
    }
    
}

-(void) enterForground{
    
    for ( id con in self.childViewControllers ) {
        if ( [con respondsToSelector:@selector(enterForground)] ) {
            [con enterForground ];
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 切换与动画



-(void) showdefault {
    
    //默认
    [self showTab: 0 ];
}

-(void) showTab:(int) index {
    
    if (index ==_currentIndex) {
        return;
    }
    //willLeaveTab事件
    if ( _currentIndex >= 0 ) {
        for ( id con in self.childViewControllers ) {
            if ( [con respondsToSelector:@selector(tabController:willLeaveTab:ofIndex:)] ) {
                UIViewController *vc = [self.childViewControllers objectAtIndex:_currentIndex ] ;
                [con tabController:self willLeaveTab:vc ofIndex:_currentIndex  ];
            }
        }
    }
    CGRect frame = self.view.frame ;
//    frame.origin.y = 0 ;
//    frame.size.height -= 44 ;

    UIViewController *con = self.childViewControllers[index] ;
    if ( _currentIndex < 0 ) { //第一次显示childViewController
        _lastIndex = _currentIndex ;
        _currentIndex = index ;
        [self changeNavigation2VC:con ] ;
        
        con.view.frame = frame ;
        [_contentView addSubview:con.view];
        [con didMoveToParentViewController:self];
    }else{
        UIViewController *lastcon = self.childViewControllers[_currentIndex] ;
        con.view.frame = frame ;
        
        __weak typeof (self) weakself = self;
        __weak typeof (_contentView) weakView=  _contentView ;
        [self transitionFromViewController:lastcon toViewController:con duration:(0.0f) options:(UIViewAnimationOptionTransitionNone) animations:^(void){
            CATransition *transition = [CATransition animation];
            
            transition.duration = 0.3f;
            
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            transition.type = kCATransitionPush;
            
            if ( _currentIndex < index ) {
                transition.subtype = kCATransitionFromRight;
            }else
                transition.subtype = kCATransitionFromLeft;
            
            transition.delegate = self;
            
            [ weakView.layer addAnimation:transition forKey:nil];
        }completion:^(BOOL finished) {
            _lastIndex = _currentIndex ;
            _currentIndex = index ;

            [weakself changeNavigation2VC:con ] ;
        }];
    }

}

-(void) showPrevious{
    
   RKTabItem *tabItem = [self.titledTabsView.tabItems objectAtIndex:_lastIndex ] ;
    [self.titledTabsView swtichTab:tabItem ] ;
}

-(void) changeNavigation2VC:(UIViewController *)con{
    
    if ( [con respondsToSelector:@selector(getTitle) ]) {
        self.title = [(id)con getTitle ] ;
    }else{
        self.title = nil ;
    }
    
    if ( [con respondsToSelector:@selector( getTitleView )] ) {
        self.navigationItem.titleView = [(id)con getTitleView] ;
    }else
        self.navigationItem.titleView = nil ;
    if ( [con respondsToSelector:@selector( getRightBarbuttonItem) ]) {
        self.navigationItem.rightBarButtonItem = [(id)con getRightBarbuttonItem] ;
    }else
        self.navigationItem.rightBarButtonItem = nil ;
}

#pragma mark - RKTabViewDelegate

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {

    if (index == _currentIndex) {
        return ;
    }
    [self showTab:index ];
//去掉动画，效果太差了    [self changeUIView2:index ] ;
}
- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    
    NSLog(@"%@", self.navigationController) ;
    
    //    UIViewController *vc = [self.childViewControllers objectAtIndex:index ] ;
    //    [vc.view removeFromSuperview ] ;
    
}

#pragma mark - 动画，未使用
- (void)changeUIView2:(int )index {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3f;
//    transition.type = @"cube" ; // kCATransitionPush;
////    if ( [direction isEqualToString: @"left" ] ) {
////        transition.subtype = kCATransitionFromLeft ;
////    }else if ( [direction isEqualToString: @"right" ] ) {
////        transition.subtype = kCATransitionFromRight ;
////    }
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn ] ;
////    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [_contentView.layer addAnimation:transition forKey:@"animation"];

    [self prepareToAnimate:index ] ;
    GLfloat duration = ( index - _currentIndex ) * 0.2 ;
    duration = duration > 0 ? duration : duration * -1 ;
    duration = 0.5 ;
    [UIView animateWithDuration:duration animations:^{
       
        
        [self doAnimate:index ] ;
        
    } completion:^(BOOL finished) {
        [self showTab:index ];
    } ] ;
}

-(void) doAnimate:(int) toIndex {
     if (  toIndex > _currentIndex ) {  //初始在右测
         for ( int i = _currentIndex;  i<= toIndex;  i += (toIndex - _currentIndex) ) {
             UIViewController *progressVC =  [self.childViewControllers objectAtIndex:i ] ;
             CGRect rect = progressVC.view.frame ;
             rect.origin.x = -1 * (toIndex - i )/(toIndex - _currentIndex) * _contentView.frame.size.width  ;
             progressVC.view.frame = rect ;
         }
     }else { //向左，其实代码可以合并，分开是为了易读性
         for ( int i = toIndex ;  i<= _currentIndex;  i += _currentIndex - toIndex ) {
             UIViewController *progressVC =  [self.childViewControllers objectAtIndex:i ] ;
             CGRect rect = progressVC.view.frame ;
             rect.origin.x = -1*(toIndex - i )/(_currentIndex - toIndex) * _contentView.frame.size.width  ;
             progressVC.view.frame = rect ;
         }
     }
}
//先将view移到动画起始处
-(void) prepareToAnimate:(int) toIndex {
    
    CGRect frame = self.view.frame ;
    frame.origin.y = 0 ;
    frame.size.height -= 44 ;
    
    if (  toIndex > _currentIndex ) {  //初始在右测
        for ( int i = _currentIndex;  i<= toIndex;  i += toIndex - _currentIndex ) {
            
            UIViewController *progressVC =  [self.childViewControllers objectAtIndex:i ] ;
            CGRect frame =  progressVC.view.frame ;
            frame.origin.x = (i - _currentIndex )/(toIndex - _currentIndex) * _contentView.frame.size.width ;
            progressVC.view.frame = frame ;
            [_contentView addSubview:progressVC.view ] ;

        }
    }else { ///初始在左测，其实代码可以合并，分开是为了易读性
        for ( int i = toIndex ;  i<= _currentIndex ;  i += _currentIndex - toIndex  ) {
            
            UIViewController *progressVC =  [self.childViewControllers objectAtIndex:i ] ;
            CGRect frame =  progressVC.view.frame ;
            frame.origin.x = ( i - _currentIndex )/(_currentIndex - toIndex) * _contentView.frame.size.width ;
            
            progressVC.view.frame = frame ;
//            [_contentView addSubview:progressVC.view ] ;
            
        }
    }
    
}

@end
