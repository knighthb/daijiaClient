//
//  DJLoginViewController.m
//  58DaijiaClient
//  登录
//  Created by huangbin on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJLoginViewController.h"
#import "DJViewController.h"
#import "DJLoginUtil.h"
#import "DJControlsFactory.h"
#import "JSONKit.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"
#import <HuangyeLib/ProgressHUD.h>
#import "DJConst.h"
#import "DJOrderListBaseViewController.h"
#import "BaiduMobStat.h"

@interface DJLoginViewController ()
{
    UITextField * phoneNumText;
    UITextField * veriCodeText;
    int time;
    NSString * userId;
//    UIButton * _button;
}

@end

@implementation DJLoginViewController
@synthesize type;
@synthesize delegate;
-(id) initWithTitle:(NSString *) title1 type:(loginType) type
{
    if (self = [super init]) {
        self.type = type;
        self.title = title1;
    }
    return  self;
}

-(void) dealloc{
    
    keyboard = nil ;
}

-(id) initWithTitle:(NSString *)title type:(loginType)type delegate :(id) delegate
{
    if (self = [super init]) {
        self.type = type;
        self.title = title;
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    time = 0;
//    [self.view setBackgroundColor: [DJControlsFactory getBackgroundColor] ];
    [self.view setBackgroundColor: [UIColor whiteColor] ];

    //橙色高仿导航栏
    CGRect naviFrame = CGRectMake(0, 20, [DJUIUtils getWindowWidth ], 44) ;
    naviFrame.origin.y = 0 ;
    if (IsIOS7) {
        naviFrame.size.height += 20 ;
    }
    UIView *topNavi = [[UIView alloc ] initWithFrame: naviFrame ] ;
    topNavi.backgroundColor = COLOR_ORANGE ;
    CUSLinnerData *data222= [[CUSLinnerData alloc ] init ] ;
    data222.height = 44 ;
    data222.width = 320 ;
    topNavi.layoutData =data222 ;
    [self.view addSubview:topNavi ] ;
    //标题
    UILabel *titleLabel = [DJControlsFactory createLabel:H1 text:self.title ] ;
    titleLabel.frame = CGRectMake(0, naviFrame.size.height - 44 , [DJUIUtils getWindowWidth ], 44);
    titleLabel.textAlignment = UITextAlignmentCenter ;
    [topNavi addSubview:titleLabel ] ;
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom  ];
    [doneButton setTitle:@"取消" forState:UIControlStateNormal ] ;
    doneButton.titleLabel.font = [UIFont systemFontOfSize:18 ] ;
    doneButton.showsTouchWhenHighlighted = YES ;
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside ];
    doneButton.frame = CGRectMake( [DJUIUtils getWindowWidth ] -  50 - 5  , naviFrame.size.height - 44, 50,  44 ) ;
    [topNavi addSubview:doneButton ] ;

    [self buildContentView ];
    
    keyboard = [[UIKeyboardViewController alloc ] initWithControllerDelegate:self ] ;
    keyboard.tabbarHeight = 44;
    [keyboard addToolbarToKeyboard];
    
}

-(void) buildContentView {
    
    
    //内容区域
    CGRect frame = self.view.frame ;
    if ( IsIOS7 ) {
        frame.origin.y += 64 ;
        frame.size.height -= 64 ;
    }else{
        frame.origin.y += 44 ;
        frame.size.height -= 44 ;
    }
    
    UIView *mainContentView =  [[UIView alloc ] initWithFrame:frame ] ;
    CUSLinnerData *data111= [[CUSLinnerData alloc ] init ] ;
    data111.fill = true ;
    mainContentView.layoutData = data111 ;
    CUSLinnerLayout  * layout2 = [[CUSLinnerLayout alloc] init];
    layout2.type = CUSLayoutTypeVertical;
    layout2.marginLeft = layout2.marginRight = 40/2.0f;
    layout2.marginTop = 40/2.0f ;
    layout2.spacing = 40/2.0f;
    mainContentView.layoutFrame =layout2;
    [self.view addSubview:mainContentView ] ;
    
    UILabel * topLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:[DJEnumUtil tipsByLoginType:self.type]];
    topLabel.font = [UIFont systemFontOfSize:14.0f];
    //    topLabel.backgroundColor = [UIColor redColor];
    topLabel.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:14.f fill:NO];
    [mainContentView addSubview:topLabel];
    
    UIView *middleView = [self buildCenterView ] ;
    
    [mainContentView addSubview:middleView];
    
    [self addLoginButton: mainContentView ] ;
    
}


-(void) addLoginButton:(UIView *) parent {
    
    UIButton * button = [DJControlsFactory createControlWithColor:COLOR_ORANGE text:[DJEnumUtil buttonTextByLoginType:self.type] ];
    button = [DJEnumUtil enventByLoginType:LOGIN target:self button:button];
    button.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:80/2.0f fill:NO];
    [parent addSubview:button];
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
    
    phoneNumText = [DJControlsFactory createTextFiled:@"请输入手机号码" delegate:self];
    phoneNumText.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:80/2.0f fill:NO];
    [middleView addSubview:phoneNumText];
    
    UIView * innerMiddleView = [[UIView alloc] init];
    innerMiddleView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    
    CUSLinnerLayout * innerMidlleViewLayout = [[CUSLinnerLayout alloc] init];
    innerMidlleViewLayout.type = CUSLayoutTypeHorizontal;
    innerMidlleViewLayout.spacing = 20/2.f;
    innerMidlleViewLayout.marginBottom = innerMidlleViewLayout.marginTop = 0.0f;
    innerMidlleViewLayout.marginLeft = innerMidlleViewLayout.marginRight = 0.0f;
    innerMiddleView.layoutFrame = innerMidlleViewLayout;
    veriCodeText = [DJControlsFactory createTextFiled:@"请输入验证码" delegate:self];
    veriCodeText.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    [innerMiddleView addSubview:veriCodeText];
    UIButton * veriButton = [DJControlsFactory createButton:HexToUIColorRGB(0xf9b056) text:@"获取验证码" radius:10/2.0f fontSize:16];
    [veriButton setTitleColor:HexToUIColorRGB(0xf9b056) forState:UIControlStateNormal];
    [veriButton setTitleColor:HexToUIColorRGB(0xf9b056) forState:UIControlStateHighlighted];
    
    veriButton.backgroundColor = HexToUIColorRGB(0xfff3e4);
    veriButton.layer.borderColor = [HexToUIColorRGB(0xfad09b) CGColor];;
    veriButton.layer.borderWidth = 1/2.0f;
    [veriButton addTarget:self action:@selector(getVeriCode:) forControlEvents:UIControlEventTouchUpInside];
    veriButton.layoutData = [DJTableViewCellUtil linnerDatawithWidth:98.0f height:80.f fill:NO];
    [innerMiddleView addSubview:veriButton];
    [middleView addSubview:innerMiddleView];
    
    return middleView ;
}

-(IBAction)done:(id)sender {
    CGRect frame = self.view.frame ;
    if ([delegate isKindOfClass:[DJOrderListBaseViewController class]]) {
        [DJConst setCanRefresh:NO];
    }
    else
        [DJConst setCanRefresh:YES];
    time = 0;
//    [ UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionTransitionNone animations:^(void){
//        self.view.frame = CGRectMake(0, [DJUIUtils getWindowHeight ] , frame.size.width, 0 ) ;
//    } completion:^(BOOL finished){
//        [self dismissViewControllerAnimated:NO   completion:^{
//            if ([self.delegate respondsToSelector:@selector(loginViewController:didExitWithCode:)]) {
//                [self.delegate loginViewController:self didExitWithCode:DJLOGINSTATECANCEL ] ;
//            }
//        }];
//    } ] ;

    [self dismissViewControllerAnimated:YES   completion:^{
       
        if ([self.delegate respondsToSelector:@selector(loginViewController:didExitWithCode:)]) {
            [self.delegate loginViewController:self didExitWithCode:DJLOGINSTATECANCEL ] ;
        }
    }];


}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ( ![phoneNumText isExclusiveTouch] ) {
        [phoneNumText resignFirstResponder];
    }
    if ( ![veriCodeText isExclusiveTouch] ) {
        [veriCodeText resignFirstResponder];
    }
}

-(void) changeButtonStyle :(NSTimer *) theTimer
{
    time++;
    UIButton * button;
    if ([theTimer.userInfo isKindOfClass:[UIButton class]]) {
        button = (UIButton *)theTimer.userInfo;
       
        [button setTitle:[ NSString stringWithFormat:@"%d秒重发",RESEND_INTERVAL-time ] forState:UIControlStateDisabled];
    }
    if (time >= RESEND_INTERVAL) {
        time = 0;
        [theTimer invalidate];
        button.enabled = YES;
        //该变字体颜色和背景颜色
        button.backgroundColor = HexToUIColorRGB(0xfff3e4);
        [button setTitleColor:HexToUIColorRGB(0xf9b056) forState:UIControlStateNormal];
        NSLog(@"timer stoped");
        
    }
   
    
}


-(BOOL) isRightPhoneNum:(NSString *) str
{
    NSString * pattern = @"^1[3|5|8]\\d{9}$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [predicate evaluateWithObject:str];
}

-(void) getVeriCode:(id) sender
{
    //2分钟不能用
    //发送获取验证码请求
    NSLog(@"getVeriCode clicked");
    [phoneNumText resignFirstResponder];
    [veriCodeText resignFirstResponder];
    [sender becomeFirstResponder];
    if (![self isRightPhoneNum:phoneNumText.text]) {
        [DJControlsFactory showError:@"请填写正确的手机号码"];
        return ;
    }
    
    time = 0;
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton * button = sender;
        button.backgroundColor = HexToUIColorRGB(0xffe1bc);
        button.enabled = NO;
        //NSTimer2分钟不能用
        NSTimeInterval interVal = 1;
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:interVal target:self selector:@selector(changeButtonStyle:) userInfo:button repeats:YES];
    }
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:phoneNumText.text,@"mobile", nil];
    NSString * path = @"https://passport.58.com/mclientmobileregloginsendmobilecode";
    NSURL * url = [NSURL URLWithString:path];
    AFHTTPClient * htppClient = [AFHTTPClient clientWithBaseURL:url];
    [htppClient setDefaultHeader:@"Accept" value:@"application/json"];
    [htppClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * reponseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [reponseStr objectFromJSONString];
        int code = [[dic objectForKey:@"code"] integerValue];
        if (code != 0) {//bu成功
            [DJControlsFactory showError:[dic objectForKey:@"errorMsg"]];
        }
        NSLog(@"responseObject: %@",responseObject);
        NSLog(@"operation: %@",operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DJControlsFactory showError:@"请求失败"];
        NSLog(@"operation:%@",operation);
        NSLog(@"error: %@",error);
    }];
}

-(void) bind:(id) sender
{
    [self bindAndLogin:sender];
    
    
}

-(void) bindAndLogin:(id) sender
{
    [ProgressHUD show:@"正在验证,请稍候"];
    UIButton * button;
    [phoneNumText resignFirstResponder];
    [veriCodeText resignFirstResponder];
    [sender becomeFirstResponder];

    if ([sender isKindOfClass:[UIButton class]]) {
        button = sender;
//        button.enabled = NO;
//        _button = button;
//        button.backgroundColor = HexToUIColorRGB(0xd67b00);
    }
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:phoneNumText.text,@"mobile", veriCodeText.text, @"mobilecode",nil];
    NSString * path = @"https://passport.58.com/mclientmobilereglogincheckmobilecode";
    NSURL * url = [NSURL URLWithString:path];
    AFHTTPClient * htppClient = [AFHTTPClient clientWithBaseURL:url];
    [htppClient setDefaultHeader:@"Accept" value:@"application/json"];
    [htppClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * reponseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [reponseStr objectFromJSONString];
        int code = [[dic objectForKey:@"code"] integerValue];
        if (code != 0) {//bu成功
            [DJControlsFactory showError:[dic objectForKey:@"codeMsg"]];
        }else{
            NSString * url = [NSString stringWithFormat:@"%@/guest/mobile/bind?mobile=%@&type=1",BASE_URL,phoneNumText.text];
            NSLog(@"##########%@",url);
            
            [DJAFNetworkingUtil sendJsonHttpRequest:url data:nil delegate:self];
            userId = [dic objectForKey:@"userId"];
        }
        NSLog(@"responseObject: %@",responseObject);
        NSLog(@"operation: %@",operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DJControlsFactory showError:@"请求失败"];
        [ProgressHUD dismiss];
        NSLog(@"operation:%@",operation);
        NSLog(@"error: %@",error);
    }];
}

-(void) processAFNJsonResult:(NSURLRequest *)request
                    response:(NSHTTPURLResponse *)response
                        json:(id) JSON
                   dataArray:(NSMutableArray *) data
{
//    _button.enabled = YES;
    NSLog(@"error = %@",JSON);
    NSDictionary * dic = (NSDictionary *) JSON;
    if ([[dic objectForKey:@"code"] integerValue] == 0 ) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        if (userId != nil) {
            if ([userId integerValue] != 0) { //成功，取到userid
                [userDefaults setObject:userId forKey:@"userId"];
                [userDefaults setObject:phoneNumText.text forKey:@"userPhone"];
                [userDefaults setBool:YES forKey:@"login"];
                [userDefaults synchronize];
                [ProgressHUD dismiss];
                [DJConst setCanRefresh:YES];
                [self dismissViewControllerAnimated:NO completion:^{
                    if ([self.delegate respondsToSelector:@selector(loginViewController:didExitWithCode:)]) {
                        [self.delegate loginViewController:self didExitWithCode:DJLOGINSTATESUCESS ] ;
                    }

                }];

            }
//            else { //失败，未取到userid
//                if ([self.delegate respondsToSelector:@selector(loginViewController:didExitWithCode:)]) {
//                    [self.delegate loginViewController:self didExitWithCode:DJLOGINSTATEFAILED ] ;
//                }
//            }
        }
    }
    else{//失败
        [DJControlsFactory showError:[dic objectForKey:@"codeMsg"]];
    }
}

-(void) processAFNErrorResult:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error json:(id)JSON
{
//    _button.enabled = YES;
    time = 0;
    NSLog(@"error = %@",error);
    [DJControlsFactory showError:@"登录失败"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alttextFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (void)alttextViewDidEndEditing:(UITextView *)textView{
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"验证码登录界面"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [[BaiduMobStat defaultStat] pageviewEndWithName:@"验证码登录界面"];
}

@end
