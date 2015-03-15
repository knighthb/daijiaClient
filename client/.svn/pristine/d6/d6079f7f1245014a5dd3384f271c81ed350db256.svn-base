//
//  DJLoginUtil.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-21.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJLoginUtil.h"
#import "DJControlsFactory.h"
#import "DJLoginViewController.h"
#import "DJLoginFactory.h"


@implementation DJLoginUtil
+(void) setPhoneNum:(NSString *) phone
{
    phoneNum = phone;
}

+(void) getVeriCode:(id) sender
{
    NSLog(@"getVeriCode clicked");
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton * button = sender;
        button.backgroundColor = HexToUIColorRGB(0xffe1bc);
    }
    
}

+(void) bindAndLogin:(id) sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton * button = sender;
        button.backgroundColor = HexToUIColorRGB(0xd67b00);
    }
}

+(void) gotoLogin:(UIViewController *) viewController title:(NSString *) title type:(loginType) type
{
//    UIViewController * loginViewController = [DJLoginFactory newLoginViewControllerWithTitle:title type:type delegate:Nil ]  ;
//    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//
//    if ([viewController isKindOfClass:[UINavigationController class]]) {
//        [(UINavigationController *)viewController pushViewController:loginViewController animated:NO];
//    }
//    else{
//        CGRect frame = loginViewController.view.frame ;
//        loginViewController.view.frame = CGRectMake(0, frame.size.height, frame.size.width, 0) ;
//
//      [ UIView transitionWithView:loginViewController.view duration:0.5 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionFlipFromBottom animations:^(void){
//           [viewController presentViewController:loginViewController animated:NO completion:nil];
//          loginViewController.view.frame = frame ;
//        } completion:^(BOOL finished){
//        } ] ;
//
//    }
    
    [ DJLoginUtil gotoLogin:viewController title:title type:type delegate: nil ] ;
    
}
+(void) gotoLogin:(UIViewController *) viewController title:(NSString *) title type:(loginType) type delegate:(id) delegate
{
    UIViewController * loginViewController = [DJLoginFactory newLoginViewControllerWithTitle:title type:type delegate:delegate ]  ;

    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController pushViewController:loginViewController animated:NO];
    }
    else{
//        CGRect frame = loginViewController.view.frame ;
//        loginViewController.view.frame = CGRectMake(0, frame.size.height, frame.size.width, 0) ;
//        [ UIView transitionWithView:loginViewController.view duration:0.3 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionFlipFromBottom animations:^(void){
//            [viewController presentViewController:loginViewController animated:NO completion:nil];
//            loginViewController.view.frame = frame ;
//        } completion:^(BOOL finished){
//        } ] ;
        loginViewController.modalTransitionStyle =UIModalTransitionStyleCoverVertical ;
        [viewController presentViewController:loginViewController animated:YES completion:nil];

    }
}



+(void) login:(UIViewController *) Controller tilte:(NSString *) title
{
    NSString * userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    if (isLogin()) {
        if (userPhone == nil) {
            //没绑定手机
            [DJLoginUtil gotoLogin:Controller title:title type:REGIST];
        }
    }else{
        //没登录，去登录，如果要在登录之后打电话则在发送登录请求成功之后拨打电话
        [DJLoginUtil gotoLogin:Controller title:title type:LOGIN];
    }
}

+(void) login:(UIViewController *) Controller tilte:(NSString *) title delegate:(id)delegate
{
    NSString * userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    if (isLogin()) {
        if (userPhone == nil) {
            //没绑定手机
            [DJLoginUtil gotoLogin:Controller title:title type:REGIST delegate:delegate];
        }
    }else{
        //没登录，去登录，如果要在登录之后打电话则在发送登录请求成功之后拨打电话
        [DJLoginUtil gotoLogin:Controller title:title type:LOGIN delegate:delegate];
    }
}

@end
