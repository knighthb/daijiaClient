//
//  DJOrderCell.m
//  58DaijiaClient
//
//  Created by huangbin on 14-5-4.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderCell.h"
//#import "CUSFillLayout.h"
#import "DJTableViewCellUtil.h"
#import "DJControlsFactory.h"
#import "DJPhoneUtil.h"

@implementation DJOrderCell
@synthesize stateLabel;
@synthesize driverName;
@synthesize subView;
@synthesize position;
@synthesize timeText;
@synthesize line;
@synthesize phoneButoon;
@synthesize commentButton;
@synthesize priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier order:(DJOrderModel *) order
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        CUSLinnerLayout * layout = [[CUSLinnerLayout alloc] init];
        layout.type = CUSLayoutTypeVertical;
        layout.marginTop = 20/2;
        layout.marginBottom = 0;
        layout.spacing = 0.0f;
        layout.marginLeft = layout.marginRight = 10;
        self.contentView.layoutFrame = layout;
        //外面的view，添加在contentView上
        self.subView = [[UIView alloc] init];
        self.subView.backgroundColor =  [UIColor whiteColor];
        self.subView.layer.borderColor = HexToUIColorRGB(0xdddddd).CGColor;
        self.subView.layer.borderWidth = 0.5f;
        self.subView.layer.shadowColor = HexToUIColorRGB(0xdddddd).CGColor;
        self.subView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
        [self.contentView addSubview:self.subView];
        
        //往subview上布局订单需要的控件,由三个view组成
        CUSLinnerLayout * subViewLayout = [[CUSLinnerLayout alloc] init];
        subViewLayout.type = CUSLayoutTypeVertical;
        subViewLayout.marginLeft = subViewLayout.marginRight = 24/2.0f;
        subViewLayout.marginBottom = subViewLayout.marginTop = 0.0f;
        subViewLayout.spacing = 0.0f;
        self.subView.layoutFrame = subViewLayout;
        
        //状态区
        [self addStatusView:order ] ;
        
        //中间的线条
        self.line = [[UIView alloc] init];
        self.line.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:1 fill:NO];
        self.line.backgroundColor = HexToUIColorRGB(0xe0e0e0);
        [self.subView addSubview:self.line];
        //下面的订单内容
        
        [self addContent:order ] ;
    }
    UIView * shadowLine = [[UIView alloc] initWithFrame:CGRectMake(20, self.frame.size.height-1, self.frame.size.width, 1)];
    shadowLine.backgroundColor = HexToUIColorRGB(0xdedede);
    [self.contentView addSubview:shadowLine];
    return  self;
}

-(void) addStatusView:(DJOrderModel *)order{
    
    //上面的订单状态
    
    stateView = [DJControlsFactory createLabel:H2 text:@""];
    stateView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:84/2 fill:NO];
    int state = [order state];
    CUSLinnerLayout * linnerLayout = [[CUSLinnerLayout alloc] init];
    linnerLayout.type = CUSLayoutTypeHorizontal;
    linnerLayout.marginLeft = linnerLayout.marginRight = 0;
    linnerLayout.marginTop = linnerLayout.marginBottom = ORDER_STATE_MARGIN_TOP;
    stateView.layoutFrame = linnerLayout;
    self.stateLabel = [DJControlsFactory createLabel:H2 text:[DJEnumUtil orderStateDescByState:(orderState) state]];
    
    self.stateLabel.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    [stateView addSubview:self.stateLabel];
    if (state == FINISH){
        if (!order.comment_closed_state) {
            //评价未关闭时，如果已评论过则显示“已评价”，否则显示评价按钮
            if (order.already_comment) {
                UILabel * commentLabel = [DJControlsFactory createLabel:H2 text:@"已评价"];
                commentLabel.textColor = [UIColor grayColor];
                commentLabel.layoutData = [DJTableViewCellUtil linnerDatawithWidth:130/2.0f height:60.f fill:NO];
                [stateView addSubview:commentLabel];
            }else{
                self.commentButton = [DJControlsFactory createControlWithColor:COLOR_ORANGE text:@"评价" ];
                self.commentButton.layoutData = [DJTableViewCellUtil linnerDatawithWidth:130/2.0f height:60.f fill:NO];
                stateView.userInteractionEnabled = YES ;
                [stateView addSubview:self.commentButton];
            }
            
        }
        //如果评价已关闭，则什么也不显示
    }
    [self.subView addSubview:stateView];

}

//订单内容
-(void) addContent:(DJOrderModel *)order{
    UIView * content = [[UIView alloc] init];
    content.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    
    CUSLinnerLayout * contentlayout = [[CUSLinnerLayout alloc] init];
    contentlayout.type = CUSLayoutTypeVertical;
    contentlayout.marginLeft = 0;
    contentlayout.marginTop = contentlayout.marginBottom = 30/2.f;
    contentlayout.spacing = 20/2.f;
    content.layoutFrame = contentlayout;
    
    [self addTopViewToContent: content withOrder:order ];
    
    self.position = [DJControlsFactory createLabel:NORMAL_TEXT text:@"开始地址:"];
    self.position.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:30/2.f fill:NO];
    [content addSubview:self.position];
    
    [self addBottomViewToContent:content withOrder:order ] ;
}

//订单内容的上部
-(void) addTopViewToContent:(UIView *)content withOrder:(DJOrderModel *) order {
    UIView * topView = [[UIView alloc] init];
    topView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:50/2 fill:NO];
    CUSLinnerLayout * topViewLayout = [[CUSLinnerLayout alloc] init];
    topViewLayout.type = CUSLayoutTypeHorizontal;
    topViewLayout.marginLeft = topViewLayout.marginRight = 0.0f;
    topViewLayout.marginTop = topViewLayout.marginBottom = 0.0f;
    topViewLayout.spacing = 0.0f;
    topView.layoutFrame =  topViewLayout;
    UIView * topLeftView = [[UIView alloc] init];
    topLeftView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    CUSLinnerLayout * topLeftInnerViewLayout = [[CUSLinnerLayout alloc] init];
    topLeftInnerViewLayout.marginBottom = topLeftInnerViewLayout.marginLeft = 10/2.f;
    topLeftInnerViewLayout.marginLeft = 0.0f;
    topLeftView.layoutFrame = topLeftInnerViewLayout;
    self.driverName = [DJControlsFactory createLabel:NORMAL_TEXT text:@"司       机:"];
    self.driverName.layoutData = [DJTableViewCellUtil linnerDatawithWidth:100 height:-1 fill:NO];
    [topLeftView addSubview:self.driverName];
    [topView addSubview:topLeftView];
    
    UIView * topRightView = [[UIView alloc] init];
    topRightView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:150 height:-1 fill:NO];
    CUSLinnerLayout * topRightViewInnerLayout = [[CUSLinnerLayout alloc] init];
    topRightViewInnerLayout.marginBottom = topRightViewInnerLayout.marginTop = 0.0f;
    topRightViewInnerLayout.marginRight = 0.0f;
    topRightViewInnerLayout.marginLeft = 30.f;
    topRightView.layoutFrame = topRightViewInnerLayout;
    self.phoneButoon = [DJControlsFactory createControlWithColor:COLOR_BLUE2 text:order.driverPhoneNum];
    [self.phoneButoon setImage:[UIImage imageNamedFrombundle:@"电话2"] forState:UIControlStateNormal];
    [self.phoneButoon setImage:[UIImage imageNamedFrombundle:@"电话2"] forState:UIControlStateHighlighted];
    self.phoneButoon.titleLabel.font = FontSize(14.f);
    [self.phoneButoon setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 10)];
    self.phoneButoon.tag = 100;
    [self.phoneButoon setTitleColor:HexToUIColorRGB(0x69abff) forState:UIControlStateNormal];
    [self.phoneButoon setTitleColor:HexToUIColorRGB(0x69abff) forState:UIControlStateHighlighted];
    [self.phoneButoon addTarget:[DJPhoneUtil class] action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    self.phoneButoon.layoutData = [DJTableViewCellUtil linnerDatawithWidth:230/2 height:-1 fill:YES];
    [topRightView addSubview:self.phoneButoon];
    [topView addSubview:topRightView];
    [content addSubview:topView];
}

-(void) addBottomViewToContent:(UIView *)content withOrder:(DJOrderModel *) order {
    UIView * buttomView = [[UIView alloc] init];
    buttomView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    
    CUSLinnerLayout * buttonViewLayout = [[CUSLinnerLayout alloc] init];
    buttonViewLayout.marginLeft = buttonViewLayout.marginRight = 0.0f;
    buttonViewLayout.marginBottom = 0.0f;
    buttomView.layoutFrame = buttonViewLayout;
    if (order.state == FINISH) {
        buttonViewLayout.marginTop = 10/2.0f;
        buttonViewLayout.spacing = 20/2.0f;
        UIView * priceView = [[UIView alloc] init];
        priceView.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:28/2 fill:NO];
        [buttomView addSubview:priceView];
        CUSLinnerLayout * priceLabelLayout = [[CUSLinnerLayout alloc] init];
        priceLabelLayout.type = CUSLayoutTypeHorizontal;
        priceLabelLayout.marginBottom = priceLabelLayout.marginTop = 0;
        priceLabelLayout.marginLeft = priceLabelLayout.marginRight = 0;
        priceLabelLayout.spacing = 0.0f;
        priceView.layoutFrame = priceLabelLayout;
        UILabel * priceTitle = [DJControlsFactory createLabel:NORMAL_TEXT text:@"付       款:"];
        priceTitle.layoutData = [DJTableViewCellUtil linnerDatawithWidth:62 height:-1 fill:NO];
        [priceView addSubview:priceTitle];
        self.priceLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:@""];
        self.priceLabel.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
        self.priceLabel.textColor = HexToUIColorRGB(0xff9200);
        [priceView addSubview:self.priceLabel];
    }
    else
    {
        buttonViewLayout.marginTop = 0.0f;
        buttonViewLayout.spacing = 0.0f;
    }
    self.timeText = [DJControlsFactory createLabel:NORMAL_TEXT text:@""];
    self.timeText.textAlignment = NSTextAlignmentRight;
    self.timeText.font = FontSize(9);
    self.timeText.textColor = HexToUIColorRGB(0xc3c3c3);
    self.timeText.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    [buttomView addSubview:self.timeText];
    [content addSubview:buttomView];
    [self.subView addSubview:content];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
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

-(void) showCommentButton:(BOOL) show {
    
    if ( show ) {
        [stateView addSubview:self.commentButton ] ;
    }else
        [self.commentButton removeFromSuperview ] ;
    
}


@end
