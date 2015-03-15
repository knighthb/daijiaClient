//
//  DJPrevilageCell.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-22.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJPrevilageCell.h"
#import "DJUIUtils.h"
#import "DJControlsFactory.h"

@implementation DJPrevilageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _status = INIT_STATUS ;
        self.backgroundColor = [DJControlsFactory getBackgroundColor] ;
        CGRect frame  =  CGRectMake( 10 , 10, [DJUIUtils getWindowWidth] - 20 , 60 ) ;
        _contentView1 = [[UIImageView alloc ] initWithFrame:frame ] ;
        [self addSubview:_contentView1 ] ;
        CUSLinnerLayout *layout = [[CUSLinnerLayout alloc ] init ] ;
        layout.marginTop = 5 ;
        layout.marginBottom = 5 ;
        layout.marginLeft += 5 ;
        layout.type = CUSLayoutTypeHorizontal ;
        layout.spacing = 5 ;
        _contentView1.layoutFrame = layout ;
        
        UIView *useless = [[UIView alloc ] init ] ;
        CUSLinnerData *data1 = [[CUSLinnerData alloc ]init ] ;
        data1.width = 10 ;
        useless.layoutData = data1 ;
        [_contentView1 addSubview:useless ] ;

        _currencyLabel =  [self createLabelOFFont:CURRENCY_FONT_SIZE bold:NO ]  ;  //
        _currencyLabel.frame = CGRectMake(0, 8, 12, 15 ) ;
        _currencyLabel.text = @"￥";
        [useless addSubview:_currencyLabel ] ;

        
        _amountLabel =  [self createLabelOFFont:MONEY_FONT_SIZE bold:NO ]  ; // [[UILabel alloc ] initWithFrame:CGRectMake(10, 8, 8, 10 ) ];
//        _amountLabel.frame = CGRectMake(18, 8, 30, 33 ) ;
        _amountLabel.backgroundColor = [UIColor clearColor ];
        _amountLabel.text = @"0";
        CUSLinnerData *data2 = [[CUSLinnerData alloc ]init ] ;
        data2.width = 85 ;
        _amountLabel.layoutData = data2 ;
        [_contentView1 addSubview:_amountLabel ] ;
        
        //中间
        UIView *mid = [[UIView alloc ] init ] ;
        CUSLinnerData *data3 = [[CUSLinnerData alloc ]init ] ;
        data3.fill = true ;
        mid.layoutData = data3 ;
        [_contentView1 addSubview:mid ] ;

        CUSFillLayout *fillLayout = [[CUSFillLayout alloc ] init ];
        fillLayout.type = CUSLayoutTypeVertical ;
        fillLayout.marginHeight = 7 ;
        fillLayout.spacing = 0;
        mid.layoutFrame = fillLayout ;
        _titleLabel = [DJControlsFactory createLabel:H2 text:@"优惠券"  ];
        _titleLabel.textColor = [UIColor whiteColor ] ;
        [mid addSubview: _titleLabel ] ;
        
        _timeLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"有效期:"  ];
        _timeLabel.textColor = [UIColor whiteColor ] ;
        _timeLabel.font = [UIFont systemFontOfSize:12 ] ;
        [mid addSubview: _timeLabel ] ;
        
        //印戳
        _stampView = [[UIImageView alloc ] init ];
        _stampView.frame = CGRectMake( self.frame.size.width - 20 - 80 ,  - 2 , 80, 80) ;
        [self addSubview:_stampView ] ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ; //点击无效果
    }
    return self;
}

-(UILabel *) createLabelOFFont:(int) size bold:(BOOL)isBold {
    
    UILabel *label = [[UILabel alloc ] init];
    label.textColor = [UIColor whiteColor ] ;
    if ( isBold) {
        label.font = [UIFont boldSystemFontOfSize:size ] ;
    }else{
        label.font = [UIFont systemFontOfSize:size ] ;
    }
    label.backgroundColor = [UIColor clearColor ];
    return label ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setColor:(UIColor *) color {
    
    _currencyLabel.textColor = color ;
    _amountLabel.textColor = color ;
    _timeLabel.textColor = color ;
    _titleLabel.textColor = color ;
    
}

-(void) setStatus : (int ) status1 {
    if ( _status == status1 ) {
        return ;
    }
  
    _status = status1 ;
    
    switch (_status) {
        case INIT_STATUS: //
             [self setBg:@"券边1" ];
            _stampView.image = nil ;
            [self setColor:[UIColor whiteColor]] ;
            break;
        case EXPIRATION_STATUS: //过期
            [self setBg:@"券边2" ] ;
            _stampView.image = [UIImage imageNamedFrombundle:@"已过期" ] ;
            [self setColor:[UIColor colorWithHex:0xc3c3c3]] ;
            break;
        case USED_STATUS:
            [self setBg:@"券边2" ] ;
            _stampView.image = [UIImage imageNamedFrombundle:@"已消费" ] ;
            [self setColor:[UIColor colorWithHex:0xc3c3c3]];

            break;
        case BIND_STATUS:
            [self setBg:@"券边1" ] ;
            [self setColor:[UIColor whiteColor]];
            _stampView.image = nil ;

            break;
        case DISTORY_STATUS:
            [self setBg:@"券边2" ] ;
            _stampView.image = [UIImage imageNamedFrombundle:@"已过期" ] ;
            [self setColor:[UIColor colorWithHex:0xc3c3c3]];

            break;
        default:
            break;
    }
}

-(void)setBg:(NSString *)name {
    
    UIImage *image = [UIImage imageNamedFrombundle:name ] ;
    UIEdgeInsets  insets ;
    insets.left = insets.right = 5 ; //image.size.width / 4 ;
    insets.top = insets.bottom = 0 ;
    UIImage *image2 =  nil ;
    if ( IsIOS6 ) {
        image2 = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch ] ;
    }else{
        image2 = [image resizableImageWithCapInsets:insets ];
        
    }
    _contentView1.image =  image2 ;
}


-(void) setAmount : (GLfloat ) amout1 {
    if ( amout1 == _amount ) {
        return ;
    }
    _amount = amout1 ;
    if ( round( amout1 ) == amout1 ) {  //整数
        _amountLabel.text = [ NSString stringWithFormat:@"%d",(int)_amount  ] ;
    }else if ( amout1 < 10 )  //10块钱以内，显示两位小数
        _amountLabel.text = [ NSString stringWithFormat:@"%.2f",_amount  ] ;
    else //10块钱以上，只能显示一位小数
        _amountLabel.text = [ NSString stringWithFormat:@"%.1f",_amount  ] ;

}

-(void) layoutSubviews{
    
    [super layoutSubviews ] ;
    
}

-(void) setUseTime : (NSString *) useTime1 {
    NSArray *ary = [useTime1 componentsSeparatedByString:@" " ] ;
    NSString *timeTitle = nil ;

    if (self.status == USED_STATUS ) {
        timeTitle = @"使用时间:" ;
        _timeLabel.text = [ NSString stringWithFormat:@"%@%@", timeTitle,[ary objectAtIndex:0 ]  ] ;
        
    }
}

-(void) setEndTime : (NSString *) endTime1 {
    
    NSArray *ary = [endTime1 componentsSeparatedByString:@" " ] ;
    
    NSString *timeTitle = nil ;
    if ( self.status == EXPIRATION_STATUS) {
        timeTitle = @"过期时间:" ;
        _timeLabel.text = [ NSString stringWithFormat:@"%@%@", timeTitle,[ary objectAtIndex:0 ]  ] ;

    }else if (self.status == USED_STATUS ) {
        // do nothing
    
    }else{
        timeTitle = @"有效期:" ;
        _timeLabel.text = [ NSString stringWithFormat:@"%@%@", timeTitle,[ary objectAtIndex:0 ]  ] ;

    }
    
    
}

@end
