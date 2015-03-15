//
//  DJOrderDetailCell2.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-19.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJOrderDetailCell2 : UITableViewCell{
    
    UILabel *waitingFeeLabel ;
    //起步价
    UILabel *startsLabel ;
    
    UILabel *mileageLabel ;
    
    //总计
    UILabel *totalLabel ;
    
    //优惠
    UILabel *discountLabel ;
    
    //实付
    UILabel *costLabel ;
    
}




//等候费
@property (nonatomic, strong , setter = setWaitingFee: ) NSString *waitingFee ;
//起步价
@property (nonatomic, strong , setter = setStarts: ) NSString *starts ;

//里程费
@property (nonatomic, strong , setter = setMileage: ) NSString *mileage ;

//总计
@property (nonatomic, strong , setter = setTotal: ) NSString *total ;

//优惠
@property (nonatomic, strong , setter = setDiscount: ) NSString *discount ;

//实付
@property (nonatomic, strong , setter = setCost: ) NSString *cost;

@end
