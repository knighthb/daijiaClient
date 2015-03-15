//
//  DJDriverMapViewController.m
//  58DaijiaClient
//  司机主视图控制器
//  Created by 58 on 14-3-31.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverMapViewController.h"
#import "DJDriverModel.h"
#import "DJDriverAnnotation.h"
#import "DJPhoneUtil.h"
#import "DJDriverAnnotationView.h"
#import "DJDriverCalloutAnnotation.h"
#import "DJTableViewCellUtil.h"
#import <HuangyeLib/CUSFillLayout.h>
#import "DJControlsFactory.h"
#import "DJDriveListViewController.h"
#import "BaiduMobStat.h"
#import "ImageBuffer.h"
#import "DJDriverCell.h"

@interface DJDriverMapViewController ()
{
    DJDriverModel * driver;
    DJDriverCalloutAnnotation * _calloutAnnotation;
    UIView * _relocationView;
    CLLocationCoordinate2D _calloutCoordinate;
    NSMutableArray * kvoArray;
    BOOL first;
    id _delegate;
}

@end
@implementation DJDriverMapViewController
@synthesize mapview;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        _relocationView = nil;
//        self.title = @"地图" ;
//    }
//    return self;
//}

-(id) init {
    self = [super init ] ;
    if (self) {
        _relocationView = nil;
        self.title = @"地图" ;
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    first = YES;
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"地图页面"];
    [self refreshMapview];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"地图页面"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor ] ;
    _relocationView = nil;
    
    _calloutAnnotation = nil;
    kvoArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.mapview = nil;
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[DJDriverAnnotation class]]) {
        if (_calloutAnnotation != nil) {
            _calloutCoordinate = _calloutAnnotation.coordinate;
            [self.mapview removeAnnotation:_calloutAnnotation];
        if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {//点击自己消失。。
                _calloutAnnotation = nil;
                return ;
        }
            _calloutAnnotation = nil;
        }
        driver = ((DJDriverAnnotation*)view.annotation).driver;
        DJDriverCalloutAnnotation * calloutAnnotation = [[DJDriverCalloutAnnotation alloc] initWithDriver:driver];
        _calloutAnnotation = calloutAnnotation;
        //定位到选中的annotation处
      [self.mapview setCenterCoordinate:calloutAnnotation.coordinate animated:YES];
        [self.mapview addAnnotation:calloutAnnotation];
    }
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[DJDriverCalloutAnnotation class]]) {
        NSString * calloutIdentifier = @"callout";
        DJDriverAnnotationView * driverAnnotationView =  driverAnnotationView = [[DJDriverAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:calloutIdentifier];
        UIView * cell = [[UIView alloc] initWithFrame:driverAnnotationView.contentView.frame];
        cell.backgroundColor = [UIColor whiteColor];
        DJDriverCell * driverCell = [[DJDriverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mapDriverCell"];
        if (driver.pic == nil ) {
            [driver addObserver:self forKeyPath:@"pic" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(void *)driverCell];
            [kvoArray addObject:driver];
            NSArray * splits = [driver.picUrl componentsSeparatedByString:@"/"];
            NSString * picName = [splits objectAtIndex:[splits count]-1];
            [DJAFNetworkingUtil loadPicWihtURL:driver.picUrl name:picName observer:driver forKey:@"pic"];
        }else
            driverCell.photoView.image = driver.pic;
        driverCell.frame = cell.frame;
        driverCell.nameLabel.text = driver.name;
        driverCell.driverYearLabel.text = [NSString stringWithFormat:@"驾龄:%d年",driver.year];
        driverCell.homeCityLabel.text = [NSString stringWithFormat:@"籍贯:%@",driver.homeCity];
        driverCell.distanceLabel.text = [NSString stringWithFormat:@"距离:%@",driver.distance];
        if (driver.phoneNum != [NSNull null]) {
            driverCell.phoneButton.titleLabel.text = [ NSString stringWithFormat:@"%@_%@",driver.phoneNum,driver.driverId ];
            [driverCell.phoneButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.layer.borderColor = HexToUIColorRGB(0xffffff).CGColor;
        cell.layer.borderWidth = 0.5f;
        [cell.layer setCornerRadius:8];
        [cell addSubview:driverCell];
        [driverAnnotationView.contentView addSubview:cell];
        CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        basicAnimation.fromValue = [NSNumber numberWithFloat:0.2];
        basicAnimation.toValue = [NSNumber numberWithFloat:1];
        basicAnimation.duration = 0.1f;
        [driverAnnotationView.layer addAnimation:basicAnimation forKey:@"transform.scale"];
        
            return driverAnnotationView;
    }
    
    if ([annotation isKindOfClass:[DJDriverAnnotation class]]) {
      DJDriverModel * driverTemp = [(DJDriverAnnotation *) annotation driver];
        NSString * identifier =[NSString stringWithFormat: @"driver_%d",arc4random()];
    NSString * newIdentifier = [NSString stringWithFormat:@"driver%d",arc4random()];
        MKAnnotationView *view =
        (MKAnnotationView *) [self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (view == nil) {
            MKAnnotationView * customView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:newIdentifier];
            UIImage * image = [UIImage imageNamedFrombundle:@"标"];
            customView.image = image;
            return customView;
        }
        else{
            view.annotation = annotation;
        }
        return view;
    }
    return  nil;
}

-(void) callPhone:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString * driverId = [[button.titleLabel.text componentsSeparatedByString:@"_"] objectAtIndex:1];
    NSString * phone = [[button.titleLabel.text componentsSeparatedByString:@"_"] objectAtIndex:0];
    DJOrderEntity * order = [[DJOrderEntity alloc] initWithDriverID:driverId userPhone:[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"] driverPhone:phone coordinate:_location.coordinate];
    NSString * phoneNum = [NSString stringWithFormat:@"tel://%@",phone];
    [DJPhoneUtil dailPhone:self.mapview phoneNum:phoneNum order:order viewController:viewController];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocationCoordinate2D location = userLocation.coordinate;
    if (first) {
       [self.mapview setRegion:MKCoordinateRegionMakeWithDistance(location, 8000, 8000)];
        first = NO;
    }

}
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    //定位失败跳转到人工服务页面
}

//DJDriverListViewController delegate
- (void)setPosition:(CLLocation *)location DriverList:(NSMutableArray *)drivers delegate:(id)delegate{
    self.location = location;
    self.drivers = drivers;
    _delegate = delegate;
    [DJConst getDJConstInstance].location = location;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"deselectAnnotationView");
    if ([view.annotation isKindOfClass:[DJDriverAnnotation class]]) {
        if (_calloutAnnotation!=nil) {
            if (_calloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
                _calloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude){
                [self.mapview removeAnnotation:_calloutAnnotation];
                _calloutAnnotation = nil;
            }
        }
    }
}

-(void) refreshMapview
{
    if (self.drivers == nil||[self.drivers count]==0) {
        [self.mapview removeFromSuperview];
        self.mapview = nil;
        if (!_relocationView) {
            _relocationView = [DJPhoneUtil createRelocationView:self.view.frame delegate:self];
        }
        [self.view addSubview:_relocationView];
    }
    else
    {
        if (_relocationView) {
            [_relocationView removeFromSuperview];
        }
        if (self.mapview == nil) {
            CUSFillLayout * layout = [[CUSFillLayout alloc] init];
            layout.type = CUSLayoutTypeVertical;
            layout.marginHeight = layout.marginWidth = 0.0f;
            layout.spacing = 0.0f;
            self.view.layoutFrame = layout;
            self.mapview = [[MKMapView alloc] init];
            [self.view addSubview:self.mapview];
        }
        self.mapview.delegate = self;
        self.mapview.showsUserLocation = YES;
        [self.mapview removeAnnotations:self.mapview.annotations];
//        [self.mapview setUserTrackingMode:MKUserTrackingModeFollow];
        [self.mapview setCenterCoordinate:self.location.coordinate];
        CLLocationDistance lanDistance = 8000.f;
        CLLocationDistance lonDistance = 8000.f;
        self.mapview.centerCoordinate = self.location.coordinate;
        [self.mapview setRegion:MKCoordinateRegionMakeWithDistance(self.location.coordinate, lanDistance, lonDistance)];
        NSMutableArray * annotations = [[NSMutableArray alloc] init];
        for (int i=0; i<[self.drivers count]; i++) {
            DJDriverAnnotation * driverAnnotation = [[DJDriverAnnotation alloc] initWithDriver:[self.drivers objectAtIndex:i]];
            [annotations addObject:driverAnnotation];
        }
        driver = [self.drivers objectAtIndex:0];
        DJDriverCalloutAnnotation * calloutAnnotation = [[DJDriverCalloutAnnotation alloc] initWithDriver:driver];
        _calloutAnnotation = calloutAnnotation;
        [self.mapview setCenterCoordinate:calloutAnnotation.coordinate animated:NO];
        [annotations addObject:calloutAnnotation];
        [self.mapview addAnnotations:annotations];
    }
}
-(void) refreshLocation:(id) sender
{
    NSLog(@"refreshLocation");
    [self.drivers removeAllObjects];
    [_delegate refreshLocation:self];
    
}
+(CLLocation *) getCurrentLoction
{
    return currentLocation;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    DJDriverCell * cell = (__bridge DJDriverCell *) context;
    cell.photoView.image = [object valueForKey:@"pic"];
    
}

-(void)dealloc{
    for (id object in kvoArray) {
        [object removeObserver:self forKeyPath:@"pic"];
    }
    kvoArray = nil;
}

@end
