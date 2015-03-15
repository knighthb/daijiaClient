//
//  DJDriverCell.h
//  58DaijiaClient
//
//  Created by huangbin on 14-5-6.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJStarView.h"

@interface DJDriverCell : UITableViewCell{
    
    DJStarView *_starView ;
}

@property (nonatomic, strong) UIImageView * photoView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * driverYearLabel;
@property (nonatomic, strong) UILabel * homeCityLabel;
@property (nonatomic, strong) UILabel * distanceLabel;
@property (nonatomic, strong) UIButton * phoneButton;

@property (setter = setStars:) int stars ;

-(void) setStars:(int)stars ;

@end
