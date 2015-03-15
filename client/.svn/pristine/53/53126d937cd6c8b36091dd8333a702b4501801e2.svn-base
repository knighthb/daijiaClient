//
//  DJTableViewCellUtil.m
//  58DaijiaClient
//  tableviewcell工具
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJTableViewCellUtil.h"
#import "DJControlsFactory.h"
#import "DJDriverModel.h"
#import <HuangyeLib/CUSLayout.h>
#import "DJPhoneUtil.h"

@implementation DJTableViewCellUtil


+(void) setTableViewCell:(UITableViewCell *)cell Text:(NSString *)text accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    cell.textLabel.text = text;
    cell.accessoryType = accessoryType;
}


#warning detailTextlabel的text值没赋进去！！
+(void) setTableViewCell:(UITableViewCell *)cell Text:(NSString *)text accessoryType:(UITableViewCellAccessoryType)accessoryType detailTextLabelText:(NSString *)detailText
{
    cell.detailTextLabel.text = detailText;
    [DJTableViewCellUtil setTableViewCell:cell Text:text accessoryType:accessoryType];
    
}

//+(void) customDriverCell:(UIView *)cell view:(UIView *)view driver:(DJDriverModel *)driver location:(CLLocation *)location
//{
//    _view = view;
//    _location = location;
//    //布局好麻烦。。 抽空写个自动布局的
//    CUSLinnerLayout * layout = [[CUSLinnerLayout alloc] init];
//    layout.type = CUSLayoutTypeHorizontal;
//    layout.spacing = SPACING;
//    layout.marginRight = MARGIN_LEFT;
//    layout.marginLeft = MARGIN_LEFT + 2;
//    layout.marginBottom = layout.marginTop = MARGIN_TOP;
//    cell.layoutFrame = layout;
//    
//    [self setDriverCellLayout:cell driver:driver phoneMarginTop:5.0];
//}

+(void) customMapDriverCell:(UIView *)cell view:(UIView *)view driver:(DJDriverModel *)driver location:(CLLocation *)location
{
    _view = view;
    _location = location;
    CUSLinnerLayout * layout = [[CUSLinnerLayout alloc] init];
    layout.type = CUSLayoutTypeHorizontal;
    layout.spacing = 6;
    layout.marginLeft = 10 ;
    layout.marginRight = 6;
    layout.marginBottom = layout.marginTop = MARGIN_TOP;
    cell.layoutFrame = layout;
    [self setDriverCellLayout:cell driver:driver phoneMarginTop:(float) 10.0f];
   
    
}
+(void) setDriverCellLayout:(UIView * ) cell driver:(DJDriverModel *)driver phoneMarginTop:(float) marginTop
{
    
    //左边的图片布局
    
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = driver.pic;
    CALayer * imageViewLayer = [imageView layer];
    imageViewLayer.borderColor = [HexToUIColorRGB(0xECECEC) CGColor];
    imageViewLayer.borderWidth = 1.0/2.0f;
    CUSLinnerData * imageData = [[CUSLinnerData alloc] init];
    imageData.width = DRIVER_LIST_PHOTO_WIDTH;
    imageData.height = DRIVER_LIST_PHOTO_HEIGHT;
    imageData.fill = NO;
    imageView.layoutData = imageData;
    [cell addSubview:imageView];
    
    //中间的标签布局
    UIView * lableView = [[UIView alloc] init];
    CUSLinnerData  * lableViewData = [[CUSLinnerData alloc] init];
    lableViewData.width = 150.f;
    lableViewData.fill = YES;
    lableView.layoutData = lableViewData;
    
    CUSLinnerLayout * innerLayout = [[CUSLinnerLayout alloc] init];
    innerLayout.type = CUSLayoutTypeVertical;
    innerLayout.marginLeft = 0.0f;
    innerLayout.spacing = 0.0f;
    innerLayout.marginTop = innerLayout.marginBottom = 0.0f;
    lableView.layoutFrame = innerLayout;
    
    //中间的姓名标签布局
    UILabel * nameLable = [DJControlsFactory createLabel:H2 text:driver.name];
    CUSLinnerData * nameLableData = [[CUSLinnerData alloc] init];
    nameLableData.fill = YES;
    nameLable.layoutData = nameLableData;
    [lableView addSubview:nameLable];
    
    UIView * innerLabelView = [[UIView alloc] init];
    CUSLinnerData * innerLableViewData = [[CUSLinnerData alloc] init];
    innerLableViewData.fill =  YES;
    innerLabelView.layoutData =  innerLableViewData;
    CUSLinnerLayout * innerLabelViewLayout = [[CUSLinnerLayout alloc] init];
    innerLabelViewLayout.type = CUSLayoutTypeHorizontal;
    innerLabelViewLayout.marginLeft = 0.0f;
    innerLabelViewLayout.marginRight = 0.0f;
    innerLabelViewLayout.spacing = 10.0f;
    innerLabelView.layoutFrame = innerLabelViewLayout;
    
    UILabel * driveYearLable = [DJControlsFactory createLabel:NORMAL_TEXT text:[NSString stringWithFormat:@"驾龄:%d年",driver.year]];
    CUSLinnerData * driverYearLableData = [[CUSLinnerData alloc] init];
    driverYearLableData.width = 70;
    driveYearLable.layoutData = driverYearLableData;
    [innerLabelView addSubview:driveYearLable];
    
    
    UILabel * homeCityLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:[NSString stringWithFormat:@"籍贯:%@",driver.homeCity == [NSNull null]?@"无":driver.homeCity]];
    CUSLinnerData * homeCityLabelData = [[CUSLinnerData alloc] init];
    homeCityLabelData.width = 80;
    homeCityLabel.layoutData = homeCityLabelData;
    [innerLabelView addSubview:homeCityLabel];
    [lableView addSubview:innerLabelView];
    
    UILabel * distanceLable = [DJControlsFactory createLabel:NORMAL_TEXT text:[NSString stringWithFormat:@"距离:%@",driver.distance]];
    CUSLinnerData * distanceLabelData = [[CUSLinnerData alloc] init];
    distanceLable.layoutData = distanceLabelData;
    [lableView addSubview:distanceLable];
    
    [cell addSubview:lableView];
    
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
    
    UIButton * button = [DJControlsFactory createButton:@"电话" imageName:@"电话"];
    if (driver.phoneNum != [NSNull null]) {
        button.titleLabel.text = [ NSString stringWithFormat:@"%@_%@",driver.phoneNum,driver.driverId ];
        ;
    }
    CUSLinnerData * innerData = [[CUSLinnerData alloc] init];
    innerData.fill = NO;
    innerData.width = 112/2;
    innerData.height = 112/2;
    button.layoutData = innerData;
    [button addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    [cell addSubview:rightView];
}

+(void) customOrderStateCell:(UIView *)cell order:(DJOrderModel *) order
{
    int state = [order state];
    CUSLinnerLayout * linnerLayout = [[CUSLinnerLayout alloc] init];
    linnerLayout.type = CUSLayoutTypeHorizontal;
    linnerLayout.marginLeft = linnerLayout.marginRight = 0;
    linnerLayout.marginTop = linnerLayout.marginBottom = ORDER_STATE_MARGIN_TOP;
    cell.layoutFrame = linnerLayout;
    UILabel * stateLable = [DJControlsFactory createLabel:H2 text:[DJEnumUtil orderStateDescByState:(orderState) state]];
    if ( state == REFUSE) {
        stateLable.textColor = HexToUIColorRGB(0x8d8d8d);
    }
    stateLable.layoutData = [self linnerDatawithWidth:-1 height:-1 fill:YES];
    [cell addSubview:stateLable];
    if (state == FINISH){
        UIButton * commentButton = [DJControlsFactory createButton:HexToUIColorRGB(0xff9200) text:@"评价" radius:10/2.f fontSize:14.f];
        [commentButton addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
        commentButton.layoutData = [self linnerDatawithWidth:130/2.0f height:60.f fill:NO];
        [cell addSubview:commentButton];
        
    }
    
    
//    UIImageView * view = [[UIImageView alloc] init];
//    view.frame = cell.frame;
//    UIImage * bgImg = [UIImage imageNamedFrombundle:@"券边1"];
//        UIEdgeInsets  insets = UIEdgeInsetsMake(10, 5, 10, 5
//                                                );
//       bgImg = [bgImg resizableImageWithCapInsets:insets];
//    view.image =bgImg;
//    UIView * test = [[UIView alloc] init];
//    test.frame = CGRectMake(0, 0, 50, 30);
//    test.backgroundColor = [UIColor redColor];
//    [view addSubview:test];
//    [cell addSubview:view];
    
    
}

+(void) customOrderContentCell:(UIView *)cell order:(DJOrderModel *) order
{
    CUSLinnerLayout * layout = [[CUSLinnerLayout alloc] init];
    layout.type = CUSLayoutTypeVertical;
//    layout.marginLeft = MARGIN_LEFT;
    layout.marginLeft = 0;
    layout.marginTop = layout.marginBottom = 30/2.f;
    layout.spacing = 20/2.f;
    cell.layoutFrame = layout;
    
    UIView * topView = [[UIView alloc] init];
    topView.layoutData = [self linnerDatawithWidth:-1 height:50/2 fill:NO];
    CUSLinnerLayout * topViewLayout = [[CUSLinnerLayout alloc] init];
    topViewLayout.type = CUSLayoutTypeHorizontal;
    topViewLayout.marginLeft = topViewLayout.marginRight = 0.0f;
    topViewLayout.marginTop = topViewLayout.marginBottom = 0.0f;
    topViewLayout.spacing = 0.0f;
    topView.layoutFrame =  topViewLayout;
    UIView * topLeftView = [[UIView alloc] init];
    topLeftView.layoutData = [self linnerDatawithWidth:-1 height:-1 fill:YES];
    CUSLinnerLayout * topLeftInnerViewLayout = [[CUSLinnerLayout alloc] init];
    topLeftInnerViewLayout.marginBottom = topLeftInnerViewLayout.marginLeft = 10/2.f;
    topLeftInnerViewLayout.marginLeft = 0.0f;
    topLeftView.layoutFrame = topLeftInnerViewLayout;
    UILabel * nameLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:[NSString stringWithFormat:@"司       机:%@",order.driverName]];
    nameLabel.layoutData = [self linnerDatawithWidth:-1 height:-1 fill:YES];
    [topLeftView addSubview:nameLabel];
    [topView addSubview:topLeftView];
    
    UIView * topRightView = [[UIView alloc] init];
    topRightView.layoutData = [self linnerDatawithWidth:-1 height:-1 fill:YES];
    CUSLinnerLayout * topRightViewInnerLayout = [[CUSLinnerLayout alloc] init];
    topRightViewInnerLayout.marginBottom = topRightViewInnerLayout.marginTop = 0.0f;
    topRightViewInnerLayout.marginRight = 0.0f;
    topRightViewInnerLayout.marginLeft = 30.f;
    topRightView.layoutFrame = topRightViewInnerLayout;
    UIButton * phoneButoon = [DJControlsFactory createCustomButton:[UIColor whiteColor] text:order.driverPhoneNum radius:5.0f fontSize:14.f];
    phoneButoon.tag = 100;
    [phoneButoon setTitleColor:HexToUIColorRGB(0x69abff) forState:UIControlStateNormal];
    phoneButoon.layer.borderWidth = 0.5f;
    phoneButoon.layer.borderColor = [HexToUIColorRGB(0x69abff) CGColor];
    [phoneButoon addTarget:[DJPhoneUtil class] action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    phoneButoon.layoutData = [self linnerDatawithWidth:230/2 height:-1 fill:YES];
    [topRightView addSubview:phoneButoon];
    [topView addSubview:topRightView];
    [cell addSubview:topView];
    
    UILabel * middleView = [DJControlsFactory createLabel:NORMAL_TEXT text:[NSString stringWithFormat:@"开始地址:%@",order.position]];
    middleView.layoutData = [self linnerDatawithWidth:-1 height:30/2.f fill:NO];
    [cell addSubview:middleView];
    UIView * buttomView = [[UIView alloc] init];
    buttomView.layoutData = [self linnerDatawithWidth:-1 height:-1 fill:YES];
    
    CUSLinnerLayout * buttonViewLayout = [[CUSLinnerLayout alloc] init];
    buttonViewLayout.marginLeft = buttonViewLayout.marginRight = 0.0f;
    buttonViewLayout.marginBottom = 0.0f;
    buttomView.layoutFrame = buttonViewLayout;
    if (order.state == FINISH) {
        buttonViewLayout.marginTop = 10/2.0f;
        buttonViewLayout.spacing = 20/2.0f;
        UILabel * priceLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:[NSString stringWithFormat:@"金       额:¥%.2f",order.totalPrice]];
        priceLabel.textColor = HexToUIColorRGB(0xff9200);
        priceLabel.layoutData = [self linnerDatawithWidth:-1 height:-1 fill:YES];
        [buttomView addSubview:priceLabel];
    }
    else
    {
        buttonViewLayout.marginTop = 0.0f;
        buttonViewLayout.spacing = 0.0f;
    }
    UILabel * timeLabel = [DJControlsFactory createLabel:NORMAL_TEXT text:order.time];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = FontSize(9);
    timeLabel.layoutData = [DJTableViewCellUtil linnerDatawithWidth:-1 height:-1 fill:YES];
    [buttomView addSubview:timeLabel];
    [cell addSubview:buttomView];
}

//这个地方一定要写成类方法,因为调用该方法时类还没有实例化,如果写成实例方法会报错找不到到该方法
+(void) comment
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"评价" message:@"评价这个地方还要实现,不知道要实现啥。。需求都没有给！！" delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles:nil, nil];
    [alert show];
}
+(void) callPhone:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag==100) {
        button.backgroundColor = HexToUIColorRGB(0xe3efff);
    }
    NSString * driverId = [[button.titleLabel.text componentsSeparatedByString:@"_"] objectAtIndex:1];
    NSString * phone = [[button.titleLabel.text componentsSeparatedByString:@"_"] objectAtIndex:0];
    DJOrderEntity * order = [[DJOrderEntity alloc] initWithDriverID:driverId userPhone:[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"] driverPhone:phone coordinate:_location.coordinate];
    NSString * phoneNum = [NSString stringWithFormat:@"tel://%@",phone];
    [DJPhoneUtil dailPhone:_view phoneNum:phoneNum order:order viewController:viewController];
}
+(CUSLinnerData *) linnerDatawithWidth:(float) width
                                height:(float) height
                                  fill:(BOOL) fill
{
    CUSLinnerData * data = [[CUSLinnerData alloc] init];
    if (width >= 0.0f) {
        data.width = width;
    }
    if (height >= 0.0f) {
        data.height = height;
    }
    if (fill) {
        data.fill = fill;
    }
    return data;
}

+(void) setViewController:(UIViewController *) controller
{
    viewController = controller;
}
@end
