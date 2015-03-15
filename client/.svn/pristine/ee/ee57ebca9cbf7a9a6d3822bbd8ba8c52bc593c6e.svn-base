//
//  DJRespAnalysisUtil.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-17.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJRespAnalyser.h"
#import "DJControlsFactory.h"

@implementation DJRespAnalyser

@synthesize message , status , data  ;

-(void) analysisResponse:(id) response{
    
    
    [self checkStatus : response ] ;
        
    data = [response objectForKey:@"data" ] ;
 
    
}

-(void) checkStatus : (NSDictionary *) map {
    
    status = [[map objectForKey:@"code" ] integerValue ] ;
    message = [map objectForKey:@"codeMsg" ] ;
    /**
     success( 0, "成功"),
     error( 1, "系统异常"),
     sign_error( 2, "非法数据"),
     parameter_error(3, "参数校验失败"),
     db_error(4, "数据库异常"),//包括数据异常和查不到数据等
     state_error(5, "业务状态异常"),
     login_error(6, "登陆异常"),//比如passport没有返回
     driver_error(7, "非法司机"),
     bind_user_error(8, "创建快捷用户失败"),
     bind_error(9, "此用户未绑定代驾业务"),
     order_add_user_error(10, "补单，用户不存在"),
     order_end_error(11, "状态异常，结算代驾失败"),
     noneed_updategps(12, "和上一次的距离太近无需更新gps"),
     mobilecheck_error(13, "手机验证异常")
     **/
//    switch (status) {
//        case 0:
//            
//            break;
//            
//        default:
//            break;
//    }
    if ( status != 0 ) {
        [DJControlsFactory showError:message ] ;
    }
    
}

-(void) handleError : (NSError *) error {
    
    
}


@end
