//
//  DJevaluationViewController.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJevaluationViewController.h"
#import "DJUIUtils.h"
#import "DJControlsFactory.h"
#import <HuangyeLib/PrettyDrawing.h>
#import "DJControlsFactory.h"
#import "JSONKit.h"
#import "DJRespAnalyser.h"
#import "DJEncryptUtil.h"

const static NSString *EVALUATE_URL = @"/guest/comment/creat" ;

@interface DJevaluationViewController ()

@end

@implementation DJevaluationViewController

-(id) initWithOrderId:(long long) orderId1 ;
{
    self = [super init ];
    if (self) {
        orderId =  orderId1 ;
        self.title = @"评价" ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentView.backgroundColor = [DJControlsFactory getBackgroundColor ] ;
    _lastIndex = 0 ;
    CUSLinnerLayout *layout = [[CUSLinnerLayout alloc ] init ] ;
    layout.marginTop = 30 ;
    layout.marginLeft = layout.marginRight = 20 ;
    layout.spacing = 10 ;
    layout.type = CUSLayoutTypeVertical ;
    self.contentView.layoutFrame = layout ;
    
    [self buildTopDescription ] ;
    
	self.scoreView = [[DJStarSlider alloc ] init ] ;
    CUSLinnerData *data = [[CUSLinnerData alloc ] init ] ;
    data.height = 80 ;
    data.width = [DJUIUtils getWindowWidth ] - 10  ;
    self.scoreView.layoutData = data ;
    self.scoreView.delegate = self ;
    [self.contentView addSubview:self.scoreView ] ;
    
    //评价界面
    UIView *textBack = [[UIView alloc ] init ] ;
    self.text = [[UITextView alloc ] init ] ;
    CUSLinnerData *data3 = [[CUSLinnerData alloc ] init ] ;
    data3.height = 122 ;
    textBack.layoutData = data3 ;
    textBack.layoutFrame = [[CUSFillLayout alloc ] init ] ;
    [textBack addSubview:self.text ] ;
//    textBack.layer.borderColor = 
    
    self.text = [[UITextView alloc ] init ] ;
    self.text.font = [UIFont systemFontOfSize:16 ];
    self.text.backgroundColor = [UIColor whiteColor ] ;
    self.text.layer.cornerRadius = 6.0 ;
    self.text.layer.borderColor = ([DJControlsFactory getLineColor:DEEP]).CGColor  ;
    self.text.layer.borderWidth = 1.0 ;
//    [textBack addSubview:self.text ] ;
    self.text.layoutData = data3 ;
    self.text.text = nil ;
    [self.contentView addSubview: self.text ] ;
    
    //按钮
    UIButton *button = [DJControlsFactory createControlWithColor:COLOR_ORANGE text:@"提交评价" ] ;
    CUSLinnerData *data4 = [[CUSLinnerData alloc ] init ] ;
    data4.height = 40 ;
    button.layoutData = data4;
    [button addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside ] ;
    [self.contentView addSubview:button ] ;
    
    keyboard = [[UIKeyboardViewController alloc ] initWithControllerDelegate:self ] ;
    keyboard.tabbarHeight = 44; 
    [keyboard addToolbarToKeyboard];

}


-(void) buildTopDescription{
    DJStarDescriptionView *uselessView = [[DJStarDescriptionView alloc ] init ] ;
    uselessView.title = @"点击星星即可点评" ;
    CUSLinnerData *data1 = [[CUSLinnerData alloc ] init ] ;
    data1.height = 12 ;
    uselessView.layoutData = data1 ;
    [self.contentView addSubview:uselessView ] ;
    
    
}


-(void) setScore:(int) score {
    
    [self.scoreView setScore:score ] ;
    
}

#pragma mark - 提交按钮
-(BOOL) checkInput {
    
    if ( self.scoreView.score < 1  ) {
        [DJControlsFactory showError:@"请选择星星打分" ];
        return  false ;
    }
    
    if ( self.text.text == nil || self.text.text.length <= 0 ) {
        [DJControlsFactory showError:@"请输入评价" ];
        return  false ;
    }
    if (self.text.text.length > 300 ) {
        [DJControlsFactory showError:@"评价内容过长，最多允许300个字" ];
        return  false ;
    }
    return true ;
    
}

-(IBAction)submit:(id)sender{
    /**
     r 必选 String 随机数，服务器不用处理，防止缓存
     
     content 必选 String 评论内容300字以内
     
     score 必选 int 1（乱收费），2（态度差），3（技术差），4（满意），5（推荐）；
     
     order_id 必选	long 订单号
     
     uid 必选 long 用户号
     
     mobile 必选 long 登陆验证
     
     pid 可选 long 针对哪个评价做的回复
     **/
    
    if ( ! [self checkInput ]) {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults ] ;

    if (!( [defaults objectForKey:@"userId" ] && [defaults objectForKey:@"userPhone" ] ) ) {
        [DJControlsFactory showError:@"您还没有登录，无法评价" ];
    }
    
    NSString *urlStr = [BASE_URL stringByAppendingFormat:@"%@",EVALUATE_URL ] ;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:self.text.text forKey:@"content" ] ;
    [params setObject:[ NSString stringWithFormat:@"%d",self.scoreView.score]  forKey:@"score" ] ;
    [params setObject:[ NSString stringWithFormat:@"%lld",orderId]  forKey:@"order_id" ] ;
    [params setObject:[defaults objectForKey:@"userId" ] forKey:@"uid" ] ;
    [params setObject:[defaults objectForKey:@"userPhone" ] forKey:@"mobile" ] ;
    [params setObject:[NSString stringWithFormat:@"%d",arc4random()] forKey:@"r" ] ;

    NSURL * url = [NSURL URLWithString:urlStr];
    AFHTTPClient * htppClient = [AFHTTPClient clientWithBaseURL:url];
    [htppClient setDefaultHeader:@"Accept" value:@"application/json"];
    //加密
    NSString * key = @"~!@#$%^&*";
    NSString *encode = [DJEncryptUtil encryptUrl:params key:key ];
    [htppClient setDefaultHeader:@"c" value:encode ];
    [htppClient setDefaultHeader:@"i" value:@"1" ];
    
    __weak typeof (self) weakself = self ;
    [htppClient postPath:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * reponseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [reponseStr objectFromJSONString];
        DJRespAnalyser *analyser = [[DJRespAnalyser alloc ] init ] ;
        [analyser analysisResponse:dic ] ;
        if (analyser.status == 0 ) {
            [DJControlsFactory showSuccess:@"评价成功" ] ;
            [weakself.navigationController popViewControllerAnimated:YES ];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [DJControlsFactory showError:ERROR_NETWORK ] ;
        NSLog(@"%@",[error localizedDescription]);
    }];
}

#pragma - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 选中星星的回调
-(void) slider:(DJStarSlider *)slider didSelectIndex:(NSInteger)index{
//    2.0需求，不需要星星连带评价了
//    if ( [self shouldAutoEvaluate ]) {
//        self.text.text = [self getEvaluateText:index ]   ;
//    }
    _lastIndex = index ;
}

-(BOOL) shouldAutoEvaluate {
    NSLog(@"%@ : %@ " ,self.text.text , [self getEvaluateText:_lastIndex] ) ;
    if ( ( self.text.text == nil || self.text.text.length <= 0) && _lastIndex == 0  ) { //初始
        return true;
    }
    return [self.text.text isEqualToString:[self getEvaluateText:_lastIndex] ];
    
}

-(NSString *) getEvaluateText:(NSInteger) index {
    switch (index) {
        case 1:
            return EVALUATION_1 ;
        case 2:
            return EVALUATION_2 ;
        case 3:
            return EVALUATION_3 ;
        case 4:
            return EVALUATION_4 ;
        case 5:
            return EVALUATION_5 ;
        default:
            break;
    }
    return nil;
}

@end
