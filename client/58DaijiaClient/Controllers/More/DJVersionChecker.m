//
//  DJVersionChecker.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-14.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJVersionChecker.h"
#import <HuangyeLib/ProgressHUD.h>
#import "DJControlsFactory.h"

static const NSString *VERSION_URL = @"/guest/version/check" ;


@implementation DJVersionChecker


-(id) init {
    self = [super init ] ;
    if (self) {
        self.notifyNoUpdate = YES ;
    }
    return self ;
}

-(void) checkVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    NSString *url = [BASE_URL stringByAppendingString:VERSION_URL ] ;
    NSMutableDictionary *param = [[NSMutableDictionary alloc ] init ] ;
    [param setObject:nowVersion forKey:@"curver" ];
    if ( self.notifyNoUpdate ) //启动时不需要
        [ProgressHUD show:@"" ];
    
    __weak DJVersionChecker * weakSelf = self ;
    
    [DJAFNetworkingUtil sendHttpRequest:url data:param success:^(id resp) {
        if ( self.notifyNoUpdate ) //启动时不需要
            [ProgressHUD  dismiss ] ;
        
        NSDictionary *resMap = resp ;
        NSLog(@"%@",[resMap objectForKey:@"code" ] ) ;
        if ( [[resMap objectForKey:@"code" ] integerValue]  != 0 ) {
            [ProgressHUD  showError:[resMap objectForKey:@"codeMsg" ] ] ;
            return ;
        }
        NSDictionary *data  = [resMap objectForKey:@"data" ] ;
        NSString *type = [data objectForKey:@"type" ] ;
        if ( type == nil || [type integerValue ] == 0 ){
            if ( ! self.notifyNoUpdate ) {
                return ;
            }
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"客户端已经是最新版本" delegate:nil
                                                 cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
            [alert show];
            
            return ;
        }
        if ([type integerValue] == 1 ) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"版本有更新" delegate:weakSelf cancelButtonTitle:@"更新" otherButtonTitles:@"取消", nil];
            [alert show];
            return ;
        }
        if ([type integerValue] == 2 ) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"版本有重要更新，不更新将无法使用" delegate:weakSelf  cancelButtonTitle:@"更新" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        }
        
    } failed:^(NSError *error) {
        if ( ! self.notifyNoUpdate ) {
            return ;
        }
        [ProgressHUD  showError:ERROR_NETWORK ] ;
        
    } ] ;
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0 )
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/58dai-jia-tong/id875776815?l=zh&ls=1&mt=8"]; //itms-apps
        [[UIApplication sharedApplication]openURL:url];
    }
}



@end
