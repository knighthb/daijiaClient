//
//  DJPrevilageViewController.h
//  58DaijiaClient
//  优惠券
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJCupponsModel.h"
#import <HuangyeLib/HYSmartViewController.h>
#import <HuangyeLib/UIKeyboardViewController.h>
#import "DJLoginViewController.h"

@interface DJPrevilageViewController : HYSmartViewController<UITableViewDataSource,UITableViewDelegate,AFNProcessDelegate , UITextFieldDelegate , UIKeyboardViewControllerDelegate , DJLoginViewControllerDelegate>
{
    int page;
    UIView *_emptyView ;
    UIView *_desView;
    UIKeyboardViewController *keyboard ;
}

@property (strong ,atomic) NSMutableArray * data;  //刷新和加载更多可能会同时操作
@property (strong, nonatomic) DJCupponsModel * cuppons;
@property (strong, nonatomic) UITableView *couponList;
@property (strong, nonatomic) NSString * baseUrl;
@property (strong, nonatomic) UITextField * input;

- (void)alttextFieldDidEndEditing:(UITextField *)textField;
- (void)alttextViewDidEndEditing:(UITextView *)textView;


- (NSMutableArray *) refreshData:(NSMutableArray *)data;

@end
