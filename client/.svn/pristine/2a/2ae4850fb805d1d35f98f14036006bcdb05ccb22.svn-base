//
//  DJLoginViewController2.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJLoginViewController2.h"
#import "DJControlsFactory.h"
#import "DJTableViewCellUtil.h"
#import <HuangyeLib/ProgressHUD.h>
#import "JSONKit.h"
#import "DJEncryptUtil.h"
#import "BaiduMobStat.h"

@interface DJLoginViewController2 ()

@end

@implementation DJLoginViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) addLoginButton:(UIView *) parent {
    
    UIButton * button = [DJControlsFactory createControlWithColor:COLOR_ORANGE text:@"登录" ];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside ] ;
    button.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:80/2.0f fill:NO];
    [parent addSubview:button];
}


-(BOOL) isRightPhoneNum:(NSString *) str
{
//    NSString * pattern = @"^1\\d$";
//    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//    return [predicate evaluateWithObject:str];
    return str!= nil && str.length > 0 ;
    
}

-(IBAction)login:(id)sender{
    
    
    [self.phoneText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    
    if ( ! [ self isRightPhoneNum:self.phoneText.text ]) {
        [ProgressHUD showError:@"请输入正确的手机号"];
        return ;
    }
    if ( self.passwordText.text == nil || self.phoneText.text.length <= 0 ) {
        [ProgressHUD showError:@"密码不能为空"];
        return ;
    }
    
    [ProgressHUD show:@"正在登录,请稍候"];

    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.phoneText.text,@"username", self.passwordText.text, @"password",nil];
    [params setValue:@"1" forKey:@"ctype" ];
    
    NSDate *now = [[NSDate alloc ] init ];
    
    long long time = [now timeIntervalSince1970 ] ;
    
    long random = fabs (  arc4random() ) ;
    
    NSString *str = [ NSString stringWithFormat:@"%lld%ld",time , random ];
    NSMutableString *strbuff = [[NSMutableString alloc ] init ] ;
    
    for ( int i = 0 ; i < str.length -2 ;  i += 2 ) {
        NSRange range ;
        range.location = i ;
        range.length = 2 ;
        NSString *towChar = [str substringWithRange:range ] ;
        [strbuff appendFormat:@"%@:", towChar ] ;
    }
    
    [params setValue:[strbuff substringToIndex:strbuff.length -1 ]  forKey:@"mid" ] ;

    NSString *vcode1 = [ NSString stringWithFormat:@"%@%@158V5",self.phoneText.text , [params objectForKey:@"mid"]  ] ;
    NSString *md5 = [DJEncryptUtil  md5:vcode1 ] ;
    
    NSRange range2 ;
    range2.location = 8 ;
    range2.length = 8 ;

    NSString *vcode = [md5 substringWithRange:range2 ]  ;//MD5(userName+mid+ctype+”58V5”).substring(8,16) ;
    [params setValue:vcode forKey:@"vcode" ] ;

    
    NSString * path = @"https://passport.58.com/pso/domclientlogin";
    NSURL * url = [NSURL URLWithString:path];
    AFHTTPClient * htppClient = [AFHTTPClient clientWithBaseURL:url];
    [htppClient setDefaultHeader:@"Accept" value:@"application/json"];
    
    [htppClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * reponseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [reponseStr objectFromJSONString];
        int code = [[dic objectForKey:@"code"] integerValue];
        if (code != 0) {//bu成功
            [DJControlsFactory showError:[dic objectForKey:@"errorMsg"]];
        }else{
            [DJControlsFactory showSuccess:@"登录成功" ];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userId = [dic objectForKey:@"userId"] ;
            if (userId != nil) {
                if ([userId integerValue] != 0) { //成功，取到userid
                    [userDefaults setObject:userId forKey:@"userId"];
                    [userDefaults setObject:self.phoneText.text forKey:@"userPhone"];
                    [userDefaults setBool:YES forKey:@"login"];
                    [userDefaults synchronize];
                }
            }
            [self dismissViewControllerAnimated:NO completion:^{
                [DJConst setCanRefresh:YES];
                if ([self.delegate respondsToSelector:@selector(loginViewController:didExitWithCode:)]) {
                    [self.delegate loginViewController:self didExitWithCode:DJLOGINSTATESUCESS ] ;
                }
                
            }];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DJControlsFactory showError:@"网络错误，请稍候重试"];
        [ProgressHUD dismiss];
        NSLog(@"operation:%@",operation);
        NSLog(@"error: %@",error);
    }];

    
}

-(UIView *)  createPhoneView{
    UIView *phoneNumView = [[UIView alloc ] init ] ;
    phoneNumView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:80/2.0f fill:NO];
    phoneNumView.layer.borderColor = [DJControlsFactory getLineColor:DEEP ].CGColor ;
    phoneNumView.layer.borderWidth = 1 ;
    phoneNumView.layer.cornerRadius =  5.0f  ;
    phoneNumView.backgroundColor = [UIColor whiteColor ];
    
    phoneNumView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    CUSLinnerLayout * innerMidlleViewLayout = [[CUSLinnerLayout alloc] init];
    innerMidlleViewLayout.type = CUSLayoutTypeHorizontal;
    innerMidlleViewLayout.spacing = 20/2.f;
    innerMidlleViewLayout.marginBottom = innerMidlleViewLayout.marginTop = 0.0f;
    innerMidlleViewLayout.marginLeft = innerMidlleViewLayout.marginRight = 0.0f;
    phoneNumView.layoutFrame = innerMidlleViewLayout;
    
    return phoneNumView ;
}

-(UIView *) buildCenterView {
    UIView * middleView = [[UIView alloc] init];
    middleView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:180/2.0f fill:NO];
    
    CUSLinnerLayout * middleLayout = [[CUSLinnerLayout alloc] init];
    middleLayout.spacing = 20/2.0f;
    middleLayout.type = CUSLayoutTypeVertical;
    middleLayout.marginBottom = middleLayout.marginTop = 0.0f;
    middleLayout.marginLeft = middleLayout.marginRight = 0.0f;
    middleView.layoutFrame = middleLayout;
    
    UIView *phoneNumView = [self createPhoneView ];
    [middleView addSubview:phoneNumView];

    UILabel *phoneLabel = [DJControlsFactory createLabel:H2 text:@"手机号:"] ;
    phoneLabel.textAlignment = UITextAlignmentRight ;
    phoneLabel.layoutData = [DJTableViewCellUtil linnerDatawithWidth:60 height:-1 fill:NO];
    [phoneNumView addSubview:phoneLabel ];
    
    self.phoneText = [[UITextField alloc ] init ];
    self.phoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter  ;
    self.phoneText.placeholder = @"请输入手机号" ;
    self.phoneText.layoutData =[DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    self.phoneText.keyboardType = UIKeyboardTypeDecimalPad ;
    [phoneNumView addSubview:self.phoneText ];
    //密码
    UIView * innerMiddleView = [self createPhoneView ];

    UILabel *passwordLabel = [DJControlsFactory createLabel:H2 text:@"密码:"] ;
    passwordLabel.textAlignment = UITextAlignmentRight ;
    passwordLabel.layoutData =  phoneLabel.layoutData ;
    [innerMiddleView addSubview:passwordLabel ];

    self.passwordText = [[UITextField alloc ] init ] ;
    self.passwordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter  ;
    self.passwordText.placeholder = @"请输入密码" ;
    [self.passwordText setSecureTextEntry:YES ] ;
    self.passwordText.layoutData =  self.phoneText.layoutData ;
    [innerMiddleView addSubview:self.passwordText];
    [middleView addSubview:innerMiddleView];
    
    return middleView ;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"用户名密码登录界面"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"用户名密码登录界面"];
}

@end
