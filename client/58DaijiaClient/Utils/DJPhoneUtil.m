//
//  DJPhoneUtil.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-15.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJPhoneUtil.h"
#import "DJCheckUtil.h"
#import "DJLoginUtil.h"
#import "DJDriveListViewController.h"
#import "DJControlsFactory.h"
#import "DJTabController.h"
@implementation DJPhoneUtil

+(void) call400:(id) sender
{
    [DJPhoneUtil dailPhone:_view phoneNum:@"tel://4001551033"];
}


+(void) dailPhone:(UIView *)view phoneNum:(NSString *)phoneNum
{
    UIWebView * phoneView = [[UIWebView alloc] init];
    phoneView.backgroundColor = [UIColor redColor];
    NSURL * telUrl = [NSURL URLWithString:phoneNum];
    NSLog(@"拨打%@的电话",phoneNum);
    [phoneView loadRequest:[NSURLRequest requestWithURL:telUrl]];
    [view addSubview:phoneView];
}

+(void) dailPhone:(UIView *)view phoneNum:(NSString *)phoneNum order:(DJOrderEntity *) order viewController:(UIViewController *) viewController
{
    //下订单之前先登录
    NSString * userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
    if (isLogin()) {
        if (userPhone == nil) {
            //没绑定手机
            [DJLoginUtil gotoLogin:[DJTabController shareInstance] title:@"附近司机" type:REGIST];
        }
        else{
            //登录且绑定了手机，则拨打电话
            [self dailPhone:view phoneNum:phoneNum];
//            拨打电话成功后才会下单
//            [DJPhoneUtil createOrder:order viewController:viewController];
        }
    }else{
        //没登录，去登录，如果要在登录之后打电话则在发送登录请求成功之后拨打电话
        [DJLoginUtil gotoLogin:[DJTabController shareInstance] title:@"附近司机" type:LOGIN];
    }
}

+(void) createOrder:(DJOrderEntity *) order viewController:(UIViewController *) viewController
{
    
    NSLog(@"create order..");
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * url = [NSString stringWithFormat:@"%@/guest/order/create?sor=3&sid=%@&bmobile=%@&smobile=%@&lat=%f&lng=%f&r=%d&mobile=%@",BASE_URL,order.driverID,[userDefaults objectForKey:@"userPhone"],order.driverPhone,order.coordinate.latitude,order.coordinate.longitude,arc4random(),[userDefaults objectForKey:@"userPhone"]];
    NSLog(@"订单url=%@",url);
    [DJAFNetworkingUtil sendJsonHttpRequest:url data:nil delegate:[DJPhoneUtil class]];
}

+(UIButton *) createPhoneButton:(UIView *) view{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect ] ;
    [button setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"phone_selected"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    _view = view;
    return  button;
}


+(void) callPhone:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString * phone = [NSString stringWithFormat:@"tel://%@",button.titleLabel.text] ;
    [DJPhoneUtil dailPhone:_view phoneNum:phone];
}

+(void) processAFNJsonResult:(NSURLRequest *)request response:(NSHTTPURLResponse *)response json:(id)JSON dataArray:(NSMutableArray *)data
{
    NSLog(@"response = %@",response);
    NSLog(@"json=%@",JSON);
}
+(void) processAFNErrorResult:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error json:(id)JSON
{
    NSLog(@"Error = %@",error);
}

+(UIView *) createRelocationView:(CGRect) frame delegate:(UIViewController *)delegate{
//    _view = view;
    UIView *_emptyView = [[UIView alloc ] init ] ;
    _view = _emptyView;
    _emptyView.backgroundColor = [UIColor clearColor];
    _emptyView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIImage *image = [UIImage imageNamedFrombundle:@"定位失败" ] ;
    UIImageView *imageView = [[UIImageView alloc ] initWithImage:image ] ;
    imageView.frame = CGRectMake(   (frame.size.width - 100)/2 ,   40 , 100, 100) ;
    [_emptyView addSubview:imageView ] ;
    
    UILabel *title1 = [DJControlsFactory createLabel:H2 text:@"抱歉，无法获取您当前的位置" ] ;
    title1.frame = CGRectMake(0, 40+100 +15 , frame.size.width, 18) ;
    title1.textAlignment = UITextAlignmentCenter ;
    title1.textColor = [UIColor colorWithHex:0x8d8d8d ] ;
    [_emptyView addSubview:title1 ] ;
    
    UILabel *title2 = [DJControlsFactory createLabel:H2 text:@"请确保网络通畅后重新定位，或拨打400电话联系" ] ;
    title2.frame = CGRectMake(30, 40+100+15+18 +15 , frame.size.width-60, 13) ;
    title2.font = [UIFont systemFontOfSize:12 ] ;
    title2.textAlignment = UITextAlignmentLeft ;
    title2.textColor = [UIColor colorWithHex:0xc3c3c3 ] ;
    title2.lineBreakMode = UILineBreakModeCharacterWrap ;
    [_emptyView addSubview:title2];
    
    UILabel *title3 = [DJControlsFactory createLabel:H2 text:@"客服找代驾" ] ;
    title3.frame = CGRectMake(30, 40+100+15+18+15+13 + 7 , frame.size.width-60, 13) ;
    title3.font = [UIFont systemFontOfSize:12 ] ;
    title3.textAlignment = UITextAlignmentLeft ;
    title3.textColor = [UIColor colorWithHex:0xc3c3c3 ] ;
    title3.lineBreakMode = UILineBreakModeCharacterWrap ;
    [_emptyView addSubview:title3];
    
    UIButton * relocationButton = [DJControlsFactory createControlWithColor:COLOR_ORANGE text:@"重新定位"];
    relocationButton.frame = CGRectMake(30, 40+100+15+18+15+13+7+13 + 30, frame.size.width-60, 40);
    [relocationButton addTarget:delegate action:@selector(refreshLocation:) forControlEvents:UIControlEventTouchUpInside];
    relocationButton.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:80/2.0f fill:NO];
    [_emptyView addSubview:relocationButton];
    
    UIButton * phoneButton = [DJControlsFactory createControlWithColor:COLOR_WHITE2 text:@"400-155-1033"];
    [phoneButton setTitleColor:HexToUIColorRGB(0x8d8d8d) forState:UIControlStateNormal];
    [phoneButton setTitleColor:HexToUIColorRGB(0x8d8d8d) forState:UIControlStateHighlighted];

    phoneButton.frame = CGRectMake(30, 40+100+15+18+15+13+7+13+30+40 +10, frame.size.width-60, 40);
    [phoneButton addTarget:[DJPhoneUtil class] action:@selector(call400:) forControlEvents:UIControlEventTouchUpInside];
    phoneButton.layoutData = [DJTableViewCellUtil linnerDatawithWidth:560/2.0f height:80/2.0f fill:NO];
    [_emptyView addSubview:phoneButton];
    
    return  _emptyView ;
}


+(UIView *) createNoDriverView:(CGRect) frame delegate:(UIViewController *)delegate{
    UIView *_emptyView = [[UIView alloc ] init ] ;
    _view = _emptyView;
    _emptyView.frame = CGRectMake(0, 100, frame.size.width, 250);
    _emptyView.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamedFrombundle:@"没司机" ] ;
    UIImageView *imageView = [[UIImageView alloc ] initWithImage:image ] ;
    imageView.frame = CGRectMake(   (frame.size.width - 110/2)/2 , 0 , 110/2, 108/2) ;
    [_emptyView addSubview:imageView ] ;
    
    UILabel *title1 = [DJControlsFactory createLabel:H2 text:@"可提供代驾服务的司机距离您都有点远哦" ] ;
    title1.frame = CGRectMake(0, 108/2 +20 , frame.size.width, 18) ;
    title1.textAlignment = UITextAlignmentCenter ;
    title1.textColor = [UIColor colorWithHex:0x8d8d8d ] ;
    [_emptyView addSubview:title1 ] ;

    UILabel *title2 = [DJControlsFactory createLabel:H2 text:@"您可以拨打24小时服务热线找代驾" ] ;
    title2.frame = CGRectMake(0, 108/2+20+18+6 , frame.size.width, 18) ;
    title2.textAlignment = UITextAlignmentCenter ;
    title2.textColor = [UIColor colorWithHex:0x8d8d8d ] ;
    [_emptyView addSubview:title2 ] ;
    
    UIButton * phoneButton = [DJControlsFactory createControlWithColor:COLOR_WHITE2 text:@"400-155-1033"];
    [phoneButton setTitleColor:HexToUIColorRGB(0x8d8d8d) forState:UIControlStateNormal];
    [phoneButton setTitleColor:HexToUIColorRGB(0x8d8d8d) forState:UIControlStateHighlighted];
    phoneButton.frame = CGRectMake(30,108/2+20+18+6+18+40 , frame.size.width-60, 40);
    [phoneButton addTarget:[DJPhoneUtil class] action:@selector(call400:) forControlEvents:UIControlEventTouchUpInside];
    [_emptyView addSubview:phoneButton];

    return  _emptyView ;
}
@end
