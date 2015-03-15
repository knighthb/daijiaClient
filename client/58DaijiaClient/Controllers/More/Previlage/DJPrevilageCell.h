//
//  DJPrevilageCell.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-22.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int CURRENCY_FONT_SIZE = 15 ;
static const int MONEY_FONT_SIZE = 42 ;
static const int TITLE2_FONT_SIZE = 14 ;
static const int TIME_FONT_SIZE = 10 ;


@interface DJPrevilageCell : UITableViewCell{
    UIImageView *_contentView1 ;
    UIImage *_bgImage ;
    UIImageView *_stampView ;
    UILabel *_currencyLabel ;
    UILabel *_amountLabel ;
    UILabel *_titleLabel ;
    UILabel *_timeLabel ;
}

@property (nonatomic , setter = setStatus: ) int  status ;

@property (nonatomic , setter = setAmount: ) GLfloat amount ;

@property (nonatomic , strong , setter = setEndTime: ) NSString *endTime ;

@property (nonatomic , strong , setter = setUseTime: ) NSString *useTime ;

-(void) setStatus : (int ) status1 ;

-(void) setAmount : (GLfloat ) amout1 ;

-(void) setEndTime : (NSString *) endTime1 ;

-(void) setUseTime : (NSString *) useTime1 ;


@end
