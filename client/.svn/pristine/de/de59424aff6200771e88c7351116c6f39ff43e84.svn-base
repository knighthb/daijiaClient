//
//  DJOrderCell.h
//  58DaijiaClient
//
//  Created by huangbin on 14-5-4.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJOrderModel.h"
@interface DJOrderCell : UITableViewCell
{
    
    UIView * stateView ;
}
@property (nonatomic, strong) UIView * subView;
@property (nonatomic, strong) UILabel * stateLabel;
@property (nonatomic, strong) UILabel * driverName;
@property (nonatomic, strong) UILabel * position;
@property (nonatomic, strong) UILabel * timeText;
@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UIButton * phoneButoon;
@property (nonatomic, strong) UIButton * commentButton;
@property (nonatomic, strong) UILabel * priceLabel;

@property (nonatomic , setter = setStatus:) NSString *status ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier order:(DJOrderModel *) order;

-(void) setStatus:(orderState )status ;

-(void) showCommentButton:(BOOL) show ;

@end
