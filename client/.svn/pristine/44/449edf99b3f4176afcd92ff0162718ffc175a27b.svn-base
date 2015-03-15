//
//  DJLoginUtil.h
//  58DaijiaClient
//
//  Created by huangbin on 14-4-21.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJTableViewCellUtil.h"
static  NSString * phoneNum;
@interface DJLoginUtil : NSObject<UITextFieldDelegate>

+(void) setPhoneNum:(NSString *) phone;

+(void) customLoginView:(UIView *) view
      phoneNumTextFiled:phoneNumText
      veriCodeTextField:veriCode
                   type:(loginType) type;

+(void) getVeriCode:(id) sender;

+(void) bindAndLogin:(id) sender;

+(void) gotoLogin:(UIViewController *) viewController
            title:(NSString *) title
             type:(loginType) type;

+(void) login:(UIViewController *) Controller tilte:(NSString *) title
;

+(void) login:(UIViewController *) Controller tilte:(NSString *) title delegate:(id)delegate;

+(void) gotoLogin:(UIViewController *) viewController title:(NSString *) title type:(loginType) type delegate:(id) delegate;
@end
