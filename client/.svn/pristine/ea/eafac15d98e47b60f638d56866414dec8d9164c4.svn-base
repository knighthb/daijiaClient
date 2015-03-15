//
//  DJPriceViewController.m
//  58DaijiaClient
//  价格表
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJPriceViewController.h"
#import "DJDriverMapViewController.h"
#import "DJEncryptUtil.h"
#import "DJControlsFactory.h"

@interface DJPriceViewController ()

@end

@implementation DJPriceViewController

-(id) init{
    return [self initWithUrl:@"/guest/price" ] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"价格表" ;
    [self.webView stopLoading ];
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    static NSString * key = @"~!@#$%^&*";
    DJConst *instance = [DJConst getDJConstInstance ] ;
    CLLocation *location = instance.location ;
    //CLLocation *location = [DJDriverMapViewController getCurrentLoction ] ;
    GLfloat lat = location.coordinate.latitude ;
    GLfloat lon = location.coordinate.longitude ;
    if(location.coordinate.longitude < 0.01 && location.coordinate.longitude >-0.01
        &&location.coordinate.latitude < 0.01 && location.coordinate.latitude >-0.01
        ){
//        [DJControlsFactory showError:@"无法获得您的位置信息，找不到对应的价格表"];
        lat = -1 ;
        lon = -1 ;
//        return ;
    }
    NSURL *url1 = [[NSURL alloc ] initWithString:[ BASE_URL stringByAppendingFormat:@"%@?lat=%f&lng=%f", url , lat , lon ] ];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ] initWithURL:url1 ] ;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc ] init ] ;
    [params setObject:[NSString stringWithFormat:@"%6f", location.coordinate.latitude ] forKey:@"lat" ] ; // , location.coordinate.latitude forKey:<#(id<NSCopying>)#>
    [params setObject:[NSString stringWithFormat:@"%6f" , location.coordinate.longitude ] forKey:@"lng" ] ; // , location.coordinate.latitude
    NSString *encode = [DJEncryptUtil encryptUrl:params key:key ];
    [request setValue:encode forHTTPHeaderField:@"c" ];
    [request setValue:@"1" forHTTPHeaderField:@"i" ];

    [self.webView loadRequest:request ] ;
    
    [self.view addSubview:self.webView ] ;
}

#pragma mark - TabedViewController
-(NSString *) getTitle
{
    return @"价格表";
}

-(UIImage *) getActiveBgImage
{
    return [UIImage imageNamedFrombundle:@"价格表"];
}

-(UIImage *) getDeactiveBgImage
{
    return [UIImage imageNamedFrombundle:@"价格表"];
}


@end
