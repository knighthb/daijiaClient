//
//  DJOrderDetailCell2.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderDetailCell2.h"
#import "DJControlsFactory.h"

@implementation DJOrderDetailCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        int y = 12 ;
    //等候费
        UILabel *denghoufei = [DJControlsFactory createLabel:NORMAL_TEXT text:@"等候费:"] ;
        denghoufei.frame = CGRectMake(12, y, 45, 20) ;
        [self addSubview:denghoufei ] ;
        waitingFeeLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"￥60（30分钟）"] ;
        waitingFeeLabel.frame = CGRectMake(57, y, 120, 20) ;
        [self addSubview:waitingFeeLabel ] ;
        y += 20 ;
    //起步价
        UILabel *qibujia = [DJControlsFactory createLabel:NORMAL_TEXT text:@"起步价:"] ;
        qibujia.frame = CGRectMake(12, y, 45, 20) ;
        [self addSubview:qibujia ] ;
        startsLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"￥58"] ;
        startsLabel.frame = CGRectMake(57, y, 90, 20) ;
        [self addSubview:startsLabel ] ;
        y += 20 ;
    //里程费
        UILabel *lichengfei = [DJControlsFactory createLabel:NORMAL_TEXT text:@"里程费:"] ;
        lichengfei.frame = CGRectMake(12, y, 45, 20) ;
        [self addSubview:lichengfei ] ;
        mileageLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"￥10（100公里）"] ;
        mileageLabel.frame = CGRectMake( 57 , y, 120, 20) ;
        [self addSubview:mileageLabel ] ;
        y += 20 ;
        //总计
        UILabel *zongji = [DJControlsFactory createLabel:NORMAL_TEXT text:@"总 计:"] ;
        zongji.frame = CGRectMake(12, y, 45, 20) ;
        [self addSubview:zongji ] ;
        totalLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"￥130"] ;
        totalLabel.frame = CGRectMake(57, y, 90, 20) ;
        [self addSubview:totalLabel ] ;
        y += 20 ;
        //优惠
        UILabel *youhui = [DJControlsFactory createLabel:NORMAL_TEXT text:@"优 惠:"] ;
        youhui.frame = CGRectMake(12, y, 45, 20) ;
        [self addSubview:youhui ] ;
        discountLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"￥10"] ;
        discountLabel.frame = CGRectMake(57, y, 90, 20) ;
        [self addSubview:discountLabel ] ;
        y += 20 ;
        //实付
        UILabel *shifu = [DJControlsFactory createLabel:NORMAL_TEXT text:@"实 付:"] ;
        shifu.frame = CGRectMake(230, 45, 45, 20) ;
        [self addSubview:shifu ] ;
        costLabel = [[UILabel alloc] init ] ;
        costLabel.textColor = COLOR_ORANGE ;
        costLabel.text = @"￥120" ;
        costLabel.font = [ UIFont systemFontOfSize: 24 ] ;
        costLabel.frame = CGRectMake(230, 67, 90, 39) ;
        [self addSubview:costLabel ] ;
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
