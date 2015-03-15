//
//  StrechCell.h
//  Demos
//
//  Created by 周文杰 on 14-6-11.
//  Copyright (c) 2014年 周文杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJOrderDetailCell : UITableViewCell{
    
    UILabel *statusLabel ;
    
    UILabel *locationLabel ;
    
    UILabel *timeLabel ;
    
    UIView *mapView ;
    
    UIImageView * lineTop ;
    
    UIImageView * ballCenter ;

    UIImageView * lineBottom ;

    UIView *seperatorline ;
}

@property ( nonatomic , weak , setter = setStatus: ) NSString *status ;

@property ( nonatomic , weak ,setter = setLoctionDes: ) NSString *locationDes ;

@property ( nonatomic , weak ,setter = setTimeString: ) NSString *timeString ;

@property ( nonatomic ,setter = setShowMap: ) BOOL showMap ;

@property ( nonatomic ,setter = setEnable:) BOOL enable ;

-(void) setEnable:(BOOL)enable ;

-(void) setStatus:(NSString *) status ;

-(void) setLoctionDes:(NSString *) setLoctionDes ;

-(void) setTimeString:(NSString *) timeString ;

-(void) setShowMap:(BOOL) timeString ;

-(void) stretch ;

-(void) shrink ;

@end
