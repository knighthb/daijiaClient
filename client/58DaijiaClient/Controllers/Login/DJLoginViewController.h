//
//  DJLoginViewController.h
//  58DaijiaClient
//  登录
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HuangyeLib/UIKeyboardViewController.h>
#import <HuangyeLib/HYSmartViewController.h>

typedef enum {
    DJLOGINSTATESUCESS,
    DJLOGINSTATEFAILED,
    DJLOGINSTATECANCEL
}DJLoginState;

@class DJLoginViewController ;


@protocol DJLoginViewControllerDelegate <NSObject>

-(void)  loginViewController:(DJLoginViewController *)vc didExitWithCode:(DJLoginState) state ;



@end



@interface DJLoginViewController : UIViewController<AFNProcessDelegate , UIKeyboardViewControllerDelegate>{
    UIKeyboardViewController *keyboard ;
}
@property (nonatomic) loginType type;
@property (nonatomic, assign) id<DJLoginViewControllerDelegate> delegate;
-(id) initWithTitle:(NSString *) title type:(loginType) type;
-(id) initWithTitle:(NSString *)title type:(loginType)type delegate :(id) delegate;
@end
