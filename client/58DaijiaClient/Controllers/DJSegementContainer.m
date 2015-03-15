//
//  DJSegementContainer.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-30.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJSegementContainer.h"
#import "DJControlsFactory.h"


@interface DJSegementContainer ()

@end

@implementation DJSegementContainer

-(id) init
{
    if (self = [super init]) {
        
    }
    return  self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self getTitleView ] ;  //改变结构后，在tabVC中调用此方法
    self.view.layoutFrame =  [[CUSFillLayout alloc] init ] ;
    [_segmentedControl sizeToFit];
//    [_segmentedControl setEnabled:YES forSegmentAtIndex:0];
    self.selectedIndex = 0;

}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    if ([_selectedController isEqual:self.childViewControllers[selectedIndex]]) {
        return;
    }
    if (!_selectedController) {
        _selectedController = self.childViewControllers[selectedIndex];
        
        [self.view addSubview:_selectedController.view];
        [_selectedController didMoveToParentViewController:self];
    }else{
        UIView *vc=  self.childViewControllers[selectedIndex];
        __weak typeof (self) weakSelf = self ;
        [self transitionFromViewController:_selectedController toViewController:self.childViewControllers[selectedIndex] duration:(1.0f) options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:nil completion:^(BOOL finished) {
            _selectedController = weakSelf.childViewControllers[selectedIndex];
            _selectedIndex = selectedIndex;
        }];
    }
}

-(void) setChildViewControllers:(NSArray *)viewControllers
{
    for (int i=0; i<[viewControllers count]; i++) {
        [self addChildViewController:viewControllers[i]];
    }
}

-(void) refreshLocation:(id) sender
{
    NSException *exception = [NSException exceptionWithName:@"NoSuchFunctionException" reason:@"function \"refreshLocation\" is not defined for Inteface \"DJSegementContainer\" " userInfo:nil];
    @throw exception;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *) getTitleView {
    if (!_segmentedControl) {
        NSMutableArray * segmentedControlItems = [[NSMutableArray alloc ]init ] ;
        //获得segement的两个标题
        NSString *title1 , *title2 ;
        if ( [self.childViewControllers count ] == 2 ) {
            UIViewController *con1 = [self.childViewControllers objectAtIndex:0 ] ;
            title1 = con1.title ;
            UIViewController *con2 = [self.childViewControllers objectAtIndex:1 ] ;
            title2 = con2.title ;
        }
        NSDictionary *dict1 =  [[NSDictionary alloc]initWithObjectsAndKeys:title1,@"text", nil ] ;
        NSDictionary *dict2 =  [[NSDictionary alloc]initWithObjectsAndKeys:title2,@"text", nil ] ;
        [segmentedControlItems addObject:dict1 ] ;
        [segmentedControlItems addObject:dict2 ];
        __weak typeof (self) weakself = self ;
        _segmentedControl = (PPiFlatSegmentedControl *)[DJControlsFactory createFlatSegment:segmentedControlItems selectionBlock:^(NSUInteger segmentIndex) {
            weakself.selectedIndex = segmentIndex  ;
        } ];
        self.navigationItem.titleView = _segmentedControl;
    }
    return _segmentedControl ;
}


@end
