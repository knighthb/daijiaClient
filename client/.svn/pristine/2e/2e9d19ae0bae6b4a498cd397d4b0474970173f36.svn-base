//
//  DJevaluationViewController.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <HuangyeLib/HYSmartViewController.h>
#import "DJStarSlider.h"
#import <HuangyeLib/UIKeyboardViewController.h>

static const NSString *EVALUATION_1 = @"乱收费" ;
static const NSString *EVALUATION_2 = @"态度差" ;
static const NSString *EVALUATION_3 = @"技术差" ;
static const NSString *EVALUATION_4 = @"满意" ;
static const NSString *EVALUATION_5 = @"推荐" ;


@interface DJevaluationViewController : HYSmartViewController<UIKeyboardViewControllerDelegate , DJSliderDelegate>{
//    UIView *textBack ;
    UIKeyboardViewController *keyboard;
    long long orderId ;
    int _lastIndex ;
}

@property (strong , nonatomic ) DJStarSlider *scoreView ;

@property (strong , nonatomic ) UITextView *text ;

-(id) initWithOrderId:(long long) orderId ;

-(void) setScore:(int) score ;

@end
