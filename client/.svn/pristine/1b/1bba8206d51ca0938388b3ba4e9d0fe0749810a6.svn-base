//
//  DJTableViewCellUtil.h
//  58DaijiaClient
//  tableviewcell工具
//  Created by huangbin on 14-4-2.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJOrderModel.h"
#import "DJEnumUtil.h"
#import <MapKit/MapKit.h>

static UIView * _view;
static CLLocation *  _location;
static UIViewController * viewController;
//static NSArray * driverList = [[NSArray alloc] init];
@interface DJTableViewCellUtil : NSObject
/**
 *  Method : setTableViewCell:Text:accessoryType
 *  Description : 设置TableViewCell的text和accessoryType
 *  Params
 *      cell : 要设置的TableViewCell
 *      Text : cell的text
 *      accessoryType : cell的accessoryType
 *  return : void
 */
 
+(void) setTableViewCell:(UITableViewCell *) cell
                    Text:(NSString * )text
           accessoryType:(UITableViewCellAccessoryType ) accessoryType;


/**
 *  Method : setTableViewCell:Text:accessoryType:detailTextLabelText
 *  Description : 设置TableViewCell的text和accessoryType
 *  Params
 *      cell : 要设置的TableViewCell
 *      Text : cell的text
 *      accessoryType : cell的accessoryType
 *      detailTextLabelText : cell右侧的detailTextLabel的text
 *  return : void
 */

+(void) setTableViewCell:(UITableViewCell *) cell
                    Text:(NSString * )text
           accessoryType:(UITableViewCellAccessoryType ) accessoryType
     detailTextLabelText:(NSString *)detailText;


/**
 *  Method : customDriverCell:cell:view:driver
 *  Description : 根据driver里面的内容定制司机列表页中的cell
 *  Params
 *      cell : 要设置的TableViewCell
 *      view : cell要添加到的view
 *      driver : 司机实体
 *  return : void
 */
+(void) customDriverCell:(UIView *) cell
                     view:(UIView *) view
                   driver:(NSObject *) driver
                location:(CLLocation *) location;



+(void) customMapDriverCell:(UIView *)cell
                       view:(UIView *)view
                     driver:(NSObject *)driver
                   location:(CLLocation *)location;

/**
 *  Method : customOrderStateCell
 *  Description : 根据order里面的状态定制订单列表页中的cell
 *  Params
 *      cell : 要设置的TableViewCell
 *      order : 订单实体
 *  return : void
 */
+(void) customOrderStateCell:(UIView *)cell order:(DJOrderModel *) order;

/**
 *  Method : customOrderContentCell:cell:order
 *  Description : 根据order里面的内容定制订单列表页中的cell
 *  Params
 *      cell : 要设置的TableViewCell
 *      order : 订单实体
 *  return : void
 */
+(void) customOrderContentCell:(UIView *)cell order:(DJOrderModel *) order;

+(CUSLinnerData *) linnerDatawithWidth:(float) width
                                height:(float) height
                                  fill:(BOOL) fill;

+(void) setViewController:(UIViewController *) controller;

@end;
