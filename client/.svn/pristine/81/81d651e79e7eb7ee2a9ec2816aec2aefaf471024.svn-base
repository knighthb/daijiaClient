//
//  DJPhoneUtil.h
//  58DaijiaClient
//
//  Created by huangbin on 14-4-15.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJOrderEntity.h"

static  UIView * _view;
@interface DJPhoneUtil : NSObject<AFNProcessDelegate>

+(UIView *) createRelocationView:(CGRect) frame delegate:(UIViewController *)delegate;

+(void) dailPhone:(UIView *) view
         phoneNum:(NSString *) phoneNum;

+(void) dailPhone:(UIView *) view
         phoneNum:(NSString *) phoneNum
            order:(DJOrderEntity *) order
   viewController:(UIViewController *) viewController;


+(UIButton *) createPhoneButton:(UIView *) view;

+(void) callPhone:(id)sender;

+(void) createOrder:(DJOrderEntity *) order
     viewController:(UIViewController *) viewController
;

+(UIView *) createNoDriverView:(CGRect) frame delegate:(UIViewController *)delegate;
@end

