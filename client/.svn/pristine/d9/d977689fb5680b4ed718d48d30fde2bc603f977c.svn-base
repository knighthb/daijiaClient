//
//  StrechCell.m
//  Demos
//
//  Created by 周文杰 on 14-6-11.
//  Copyright (c) 2014年 周文杰. All rights reserved.
//

#import "DJOrderDetailCell.h"
#import "DJControlsFactory.h"

#define LABEL2_HEIGHT 20

@implementation DJOrderDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addLine ] ;
        
        [self addContent ] ;
        
        [self addSeperator ] ;
    }
    return self;
}


-(void) addSeperator{
    
    seperatorline = [[UIView alloc ] initWithFrame:CGRectMake(48, 69 , 260, 0.5 ) ] ;
    seperatorline.backgroundColor = [UIColor grayColor ] ;
    [self addSubview:seperatorline ] ;
}

-(void) addLine {
    
    lineTop = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 17, 14) ] ;
    [self addSubview:lineTop ] ;
    
    ballCenter = [[UIImageView alloc ] initWithFrame:CGRectMake(12, 14, 17, 18) ];
    [self addSubview:ballCenter ] ;

    lineBottom = [[UIImageView alloc ] initWithFrame:CGRectMake(12, 32, 17, 38) ];
    [self addSubview:lineBottom ] ;

    
    lineTop.image = [ UIImage imageNamedFrombundle:@"grayLineT" ] ;
    ballCenter.image = [ UIImage imageNamedFrombundle:@"uncomplete" ] ;
    UIImage *image1= [ UIImage imageNamedFrombundle:@"grayLineB" ] ;
    UIEdgeInsets edge ;
    edge.top = image1.size.height / 2 - 1 ;
    edge.bottom = image1.size.height / 2 ;
    edge.left = image1.size.width / 2 - 1;
    edge.right = image1.size.width / 2 ;
    
    lineBottom.image = [image1 resizableImageWithCapInsets:edge ] ;
    
}

-(void) addContent {
    
    statusLabel = [DJControlsFactory createLabel:H2 text:@""] ;//[[UILabel alloc ] initWithFrame:CGRectMake(48, 15, 260, 20)] ;
    statusLabel.font = [UIFont boldSystemFontOfSize:16] ;
    statusLabel.frame = CGRectMake(48, 15, 260, 20) ;
    [self addSubview:statusLabel ] ;
    
    locationLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@""] ;
    locationLabel.frame = CGRectMake(48, 40, 260, 20) ;
    
    timeLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@""] ;
    timeLabel.frame = CGRectMake(48, 40, 260, 20) ;
    [self addSubview:timeLabel ] ;

    mapView = [[UIImageView alloc] initWithFrame:CGRectMake(48, 65, 260, 180) ]   ;
    
    
}

-(void) stretch {
    
    ((UIImageView *)mapView).image =  [UIImage imageNamedFrombundle:@"mapView"];
    CGRect frame = lineBottom.frame ;
    frame.size.height = 38 + 190 ;
    lineBottom.frame = frame ;
    
    CGRect frame2 = seperatorline.frame ;
    frame2.origin.y  = 69 +  190 ;
    seperatorline.frame = frame2 ;

    
    [self addSubview:mapView ] ;
}

-(void) shrink {
    [mapView removeFromSuperview ] ;
    CGRect frame = lineBottom.frame ;
    frame.size.height = 38 ;
    lineBottom.frame = frame ;
    
    CGRect frame2 = seperatorline.frame ;
    frame2.origin.y = 69 ;
    seperatorline.frame = frame2 ;
    
}

-(void) setStatus:(NSString *) status {
    
    statusLabel.text = status ;
    if ([ status isEqualToString:@"司机已确认" ]) {
        [lineTop removeFromSuperview ] ;
        //司机已确认状态有三行
        CGRect frame2 = seperatorline.frame ;
        frame2.origin.y  += 20 ;
        seperatorline.frame = frame2 ;
        
        CGRect frame = lineBottom.frame ;
        frame.size.height += 20 ;
        lineBottom.frame = frame ;
    }else
        [self addSubview:lineTop ] ;
    if ([ status isEqualToString:@"完成代驾" ] ) {
        [lineBottom removeFromSuperview ] ;
    }else
        [self addSubview:lineBottom ] ;
}

-(void) setLoctionDes:(NSString *) loctionDes {
    
    if ( loctionDes == nil ) {
        [locationLabel removeFromSuperview ] ;
    }else{
        locationLabel.text = loctionDes ;
        [self addSubview:locationLabel ] ;
    }
    
}

-(void) setTimeString:(NSString *) timeString {
    if (timeString == nil ) {
        [timeLabel removeFromSuperview ] ;
    }else
        [self addSubview:timeLabel ] ;
    
    timeLabel.text = timeString ;
}

-(void) setShowMap:(BOOL) timeString {
    
    
}

-(void) setEnable:(BOOL)enable {
    
    if ( enable ) {
        ballCenter.image = [UIImage imageNamedFrombundle:@"completed" ] ;
        statusLabel.textColor = [UIColor blackColor ] ;
    }else{
        ballCenter.image = [UIImage imageNamedFrombundle:@"uncomplete" ] ;
        statusLabel.textColor = [UIColor grayColor ] ;
        //分割线
        CGRect frame2 = seperatorline.frame ;
        frame2.origin.y = 49 ;
        seperatorline.frame = frame2 ;
        //右侧流程线
        CGRect frame = lineBottom.frame ;
        frame.size.height = 20 ;
        lineBottom.frame = frame ;
    }
    
}

-(void) layoutSubviews{
    
    [super layoutSubviews ] ;
    
    if ( locationLabel.superview  == nil ) { //没有地址
        
        timeLabel.frame = CGRectMake(48, 40, 260, 20) ;
        mapView.frame = CGRectMake(48, 65, 260, 180) ;
    }else {
        timeLabel.frame = CGRectMake(48, 60, 260, 20) ;
        mapView.frame = CGRectMake(48, 85, 260, 180) ;
    }
    
    
}

@end
