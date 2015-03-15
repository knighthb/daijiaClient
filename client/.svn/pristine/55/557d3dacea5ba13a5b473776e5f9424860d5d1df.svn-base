//
//  DJMoreViewController.m
//  58DaijiaClient
//  更多
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJMoreViewController.h"
#import "DJTableViewCellUtil.h"
#import "DJProtocolViewController.h"
#import "DJPrevilageViewController.h"
#import "DJCheckUtil.h"
#import "DJPhoneUtil.h"
#import "DJMoreCell.h"
#import "DJControlsFactory.h"
#import "DJLoginViewController.h"
#import <HuangyeLib/PrettyDrawing.h>
#import "DJUIUtils.h"
#import "DJConst.h"
#import "DJLoginUtil.h"
#import <HuangyeLib/ProgressHUD.h>
#import "DJVersionChecker.h"


@interface DJMoreViewController ()

@end

@implementation DJMoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"查看更多" ;
    self.view.backgroundColor = [DJControlsFactory getBackgroundColor ] ;

    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.tableView.scrollEnabled = NO ;
    if(IsIOS7){
//        self.automaticallyAdjustsScrollViewInsets =  YES ;
//        self.edgesForExtendedLayout = UIRectEdgeNone ;

        UIEdgeInsets inset = self.tableView.contentInset ;
        inset.top = 64 ;
        self.tableView.contentInset = inset ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //登录时要显示最后一行的登录按钮，未登录则不显示
    if (isLogin()) {
        return 3;
    }else
        return 2;
}

-(GLfloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( indexPath.section <2  ) {
        return 46 ;
    }
    return 42 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (!isLogin()) {
        //未登录，则最后一行不显示
        if (section == 3) {
            return 0;
        }
    }
    
    if ( section == 0 ) {
        return 3 ;
    }else if( section == 1 ){
        return 2 ;
    }else if( section == 2 )
        return 1 ;
    
    return  0 ;
}

-(void) buildSection1Cell:(UITableViewCell*) cell row:(int) row{
    DJMoreCell *moreCell = (DJMoreCell *)cell ;
    //防止拿到的是复用cell，先reset
    moreCell.hasArrow = YES ;
    moreCell.description.text = nil ;
    switch (row ) {
        case 0:
            if (  !isLogin() ) {
                moreCell.caption.text = @"请登录";
                moreCell.description.text = nil ;
            }else
                moreCell.caption.text = @"我的账号";
            moreCell.hintIcon.image = [UIImage imageNamedFrombundle:@"我的帐号"] ;
            if (isLogin()) {
                NSString *  userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
               moreCell.description.text = userID;
                moreCell.hasArrow = NO ;
            }
            break;
        case 1:
            moreCell.caption.text = @"委托代驾协议" ;
            moreCell.hintIcon.image = [UIImage imageNamedFrombundle:@"协议"] ;

            break;
        case 2:
            moreCell.caption.text = @"我的优惠券" ;
            moreCell.hintIcon.image = [UIImage imageNamedFrombundle:@"优惠券"] ;
            break;
        default:
            break;
    }
}



-(void) buildSection2Cell:(UITableViewCell*) cell row:(int) row{
    DJMoreCell *moreCell = (DJMoreCell *)cell ;

    switch (row ) {
        case 0:
            //TODO:400电话暂时先写上，后面改成配置
            moreCell.caption.text = @"客服热线" ;
            moreCell.hintIcon.image = [UIImage imageNamedFrombundle:@"客服热线"] ;
            moreCell.description.text = @"400-105-1033" ;
            moreCell.hasTopLine = YES ;

            break;
        case 1 :
//            [DJTableViewCellUtil setTableViewCell:cell Text:@"检查新版本" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
            moreCell.caption.text = @"检查新版本" ;
            moreCell.hintIcon.image = [UIImage imageNamedFrombundle:@"检测新版本"] ;
            break ;
        default:
            break;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int section = indexPath.section;
    UITableViewCell *cell = nil ;
    if ( section < 2 ) {
        static NSString *CellIdentifier = @"more";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[DJMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.contentView.backgroundColor = [UIColor whiteColor ] ;
        }
        ((DJMoreCell *)cell).hasTopLine = NO ;
        CGFloat height = [self tableView:tableView heightForRowAtIndexPath:indexPath ];
        if ( section == 0 && row == 3 ) {
            ((DJMoreCell *)cell).line.frame = CGRectMake( 0, height - 0.5  , cell.frame.size.width , 0.5 ) ;
            ((DJMoreCell *)cell).line.backgroundColor = [DJControlsFactory getLineColor:DEEP ];
        }else if ( section == 1 && row == 1 ) {
            ((DJMoreCell *)cell).line.frame = CGRectMake( 0, height - 0.5  , cell.frame.size.width , 0.5 ) ;
            ((DJMoreCell *)cell).line.backgroundColor = [DJControlsFactory getLineColor:DEEP ];
        }else {
            ((DJMoreCell *)cell).line.backgroundColor = [DJControlsFactory getLineColor:LIGHT ];
            ((DJMoreCell *)cell).line.frame = CGRectMake(20, height -0.5  , cell.frame.size.width - 20, 0.5 ) ;

        }


    }else{
        static NSString *CellIdentifier = @"button";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    if (section == 0) {
        [self buildSection1Cell:cell row:row ];
            }else if( section ==1 ){
        [self buildSection2Cell:cell row:row ];
    }else if (section == 2 ) {
        cell.backgroundColor = [DJControlsFactory getBackgroundColor ] ;
        if (isLogin()) {
            UIButton * logOutButton = [DJControlsFactory createControlWithColor:COLOR_RED2 text:@"退出当前账号" frame:CGRectMake(20, 1, 280, 40) ] ;
            [logOutButton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];

            [cell.contentView addSubview:logOutButton];
        }

    }
    // Configure the cell...
    
    return cell;
}

-(void)  loginViewController:(DJLoginViewController *)vc didExitWithCode:(DJLoginState) state {
    
    if ( state == DJLOGINSTATESUCESS) {
        [self showPrevilage];
        return ;
    }else{ //if( state == dj )
        //do nothing
    }
}

-(void) showPrevilage{
    DJPrevilageViewController * previlageViewController = [[DJPrevilageViewController alloc] init ] ;
    [self.navigationController pushViewController:previlageViewController animated:YES];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ] ;
    int row = indexPath.row;
    int section = indexPath.section;
    if ( section == 0 ) {
        switch (row){
            case 0:{
                if ( ! isLogin() )  {
                    [self login] ;
                }
                break;
            }case 1:{
                DJProtocolViewController * protocolViewController1 = [[DJProtocolViewController alloc] init ];
                [self.navigationController pushViewController:protocolViewController1 animated:YES];
                break;
            }case 2:{
                if ( isLogin() ) {
                    [self showPrevilage ] ;
                }else{
                    DJTabController *rootVC = [DJTabController shareInstance ] ;
                    [DJLoginUtil login:rootVC tilte:@"我的优惠券" delegate:self ];
                }
                
                break;
            }default:
                break;
        }
    }else if( section == 1 )
     switch (row) {
        case 0:{
                NSLog(@"selected %d section %d row",section,row);
                [DJPhoneUtil dailPhone:self.view phoneNum:@"tel://4001050133"];
        }
            break;
        case 1:{
            DJVersionChecker *checker = [[DJVersionChecker alloc ] init ] ;
            [ checker  checkVersion ] ;
        }
            break;
        default:
            break;
    }
}



-(GLfloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ( section < 2 ) {
        return 20 ;
    }
    return  0 ;
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [ [UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)]  ;
    footerView.backgroundColor = [DJControlsFactory getBackgroundColor ];
    return footerView;
}
#warning 登录和退出这个要抽出去公用
-(void) login
{
    NSLog(@"登录按钮clicked！");
    //    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated:YES];
    DJTabController *root = [DJTabController shareInstance ] ;
    [DJLoginUtil login:root tilte:@"登录" ];
    NSLog(@"login: %hhd",[[NSUserDefaults standardUserDefaults] boolForKey:@"login"]);
}

-(void) logOut
{//这个地方待实现
    NSLog(@"注销用户！");
    [DJConst setCanRefresh:YES];
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData ] ;
}

#pragma mark - TabedViewController
-(NSString *) getTitle
{
    return @"查看更多";
}

-(UIImage *) getActiveBgImage
{
    return [UIImage imageNamedFrombundle:@"更多选中"];
}

-(UIImage *) getDeactiveBgImage
{
    return [UIImage imageNamedFrombundle:@"更多"];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    [self.tableView reloadData ] ;

}

@end
