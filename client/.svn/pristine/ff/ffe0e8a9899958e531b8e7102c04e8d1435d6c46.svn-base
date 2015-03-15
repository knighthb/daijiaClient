//
//  DJDriverCell.m
//  58DaijiaClient
//
//  Created by huangbin on 14-5-6.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverCell.h"
#import "DJControlsFactory.h"

@implementation DJDriverCell

@synthesize nameLabel;
@synthesize photoView;
@synthesize driverYearLabel;
@synthesize homeCityLabel;
@synthesize distanceLabel;
@synthesize phoneButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CUSLinnerLayout * layout = [[CUSLinnerLayout alloc] init];
        layout.type = CUSLayoutTypeHorizontal;
        if ([@"mapDriverCell" isEqualToString:reuseIdentifier]) {
            layout.spacing = 6;
            layout.marginLeft = 10 ;
            layout.marginRight = 6;
        }
        else{
            layout.spacing = SPACING;
            layout.marginRight = MARGIN_LEFT;
            layout.marginLeft = MARGIN_LEFT + 2;
        }
        layout.marginBottom = layout.marginTop = MARGIN_TOP;
        self.contentView.layoutFrame = layout;
        
        //左边的图片布局
        self.photoView = [[UIImageView alloc] init];
        CALayer * imageViewLayer = [self.photoView layer];
        imageViewLayer.borderColor = [HexToUIColorRGB(0xECECEC) CGColor];
        imageViewLayer.borderWidth = 1.0/2.0f;
        CUSLinnerData * imageData = [[CUSLinnerData alloc] init];
        imageData.width = DRIVER_LIST_PHOTO_WIDTH;
        imageData.height = DRIVER_LIST_PHOTO_HEIGHT;
        self.photoView.layoutData = imageData;
        [self.contentView addSubview:self.photoView];
        
        [self addCenter ] ;
        
        //右边的电话按钮布局
        UIView * rightView = [[UIView alloc] init];
        CUSLinnerData * buttonData = [[CUSLinnerData alloc] init];
        buttonData.width = 112/2;
        buttonData.height =112/2;
        rightView.layoutData = buttonData;
        CUSLinnerLayout * RightInnerLayout = [[CUSLinnerLayout alloc] init];
        RightInnerLayout.spacing = 0.0f;
        RightInnerLayout.marginLeft = RightInnerLayout.marginRight = 0.0f;
        RightInnerLayout.marginBottom = RightInnerLayout.marginTop = 5;
        rightView.layoutFrame = RightInnerLayout;
        
        self.phoneButton = [DJControlsFactory createButton:@"电话" imageName:@"电话"];
        CUSLinnerData * innerData = [[CUSLinnerData alloc] init];
        innerData.fill = NO;
        innerData.width = 112/2;
        innerData.height = 112/2;
        self.phoneButton.layoutData = innerData;
        [rightView addSubview:self.phoneButton];
        [self.contentView addSubview:rightView];

    }
    return self;
}

-(void) addCenter {
    
    //中间的标签布局
    UIView * lableView = [[UIView alloc] init];
    CUSLinnerData  * lableViewData = [[CUSLinnerData alloc] init];
    lableViewData.width = 150.f;
    lableViewData.fill = YES;
    lableView.layoutData = lableViewData;
    if ( _DJDEBUGGER) {
        lableView.backgroundColor = [UIColor redColor ] ;
    }
    CUSLinnerLayout * innerLayout = [[CUSLinnerLayout alloc] init];
    innerLayout.type = CUSLayoutTypeVertical;
    innerLayout.marginLeft = 0.0f;
    innerLayout.spacing = 0.0f;
    innerLayout.marginTop = innerLayout.marginBottom = 0.0f;
    lableView.layoutFrame = innerLayout;
    
    //中间的姓名标签布局
    self.nameLabel = [DJControlsFactory createLabel:H2 text:@""];
    CUSLinnerData * nameLableData = [[CUSLinnerData alloc] init];
    //        nameLableData.fill = YES;
    nameLableData.height = 24 ;
    self.nameLabel.layoutData = nameLableData;
    if ( _DJDEBUGGER ) {
        nameLabel.backgroundColor = [UIColor greenColor ] ;
    }
    _starView = [[DJStarView alloc] initWithFrame:CGRectMake(70, 0 , 70 , 25 ) ];
    _starView.userInteractionEnabled = NO ;
    _starView.score = 4 ;
    if ( _DJDEBUGGER ) {
        _starView.backgroundColor = [UIColor purpleColor ] ;
    }
    [nameLabel addSubview:_starView ] ;
    
    [lableView addSubview:self.nameLabel];
    
    
    
    
    UIView * innerLabelView = [[UIView alloc] init];
    CUSLinnerData * innerLableViewData = [[CUSLinnerData alloc] init];
    //        innerLableViewData.fill =  YES;
    innerLableViewData.height = 24 ;
    innerLabelView.layoutData =  innerLableViewData;
    CUSLinnerLayout * innerLabelViewLayout = [[CUSLinnerLayout alloc] init];
    innerLabelViewLayout.type = CUSLayoutTypeHorizontal;
    innerLabelViewLayout.marginLeft = 0.0f;
    innerLabelViewLayout.marginRight = 0.0f;
    innerLabelViewLayout.spacing = 10.0f;
    if ( _DJDEBUGGER ) {
        innerLabelView.backgroundColor = [UIColor blueColor ] ;
    }
    innerLabelView.layoutFrame = innerLabelViewLayout;
    
    self.driverYearLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@""];
    CUSLinnerData * driverYearLableData = [[CUSLinnerData alloc] init];
    driverYearLableData.width = 70;
    self.driverYearLabel.layoutData = driverYearLableData;
    if ( _DJDEBUGGER ) {
        self.driverYearLabel.backgroundColor = [UIColor yellowColor ] ;
    }
    [innerLabelView addSubview:self.driverYearLabel];
    
    
    self.homeCityLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@"" ];
    //[NSString stringWithFormat:@"籍贯:%@",driver.homeCity == [NSNull null]?@"无":driver.homeCity]];
    CUSLinnerData * homeCityLabelData = [[CUSLinnerData alloc] init];
    homeCityLabelData.width = 80;
    self.homeCityLabel.layoutData = homeCityLabelData;
    [innerLabelView addSubview:self.homeCityLabel];
    [lableView addSubview:innerLabelView];
    
    self.distanceLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@""];
    CUSLinnerData * distanceLabelData = [[CUSLinnerData alloc] init];
    distanceLabelData.fill = YES;
    self.distanceLabel.layoutData = distanceLabelData;
    if ( _DJDEBUGGER ) {
        self.distanceLabel.backgroundColor = [UIColor orangeColor ] ;
    }
    [lableView addSubview:self.distanceLabel];
    
    [self.contentView addSubview:lableView];

    
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

-(void) setStars:(int)stars {
    
    
    
}

@end
