//
//  DJOrderTablePartProvider.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderUnCompletedTableProvider.h"
#import "DJUIUtils.h"
#import "DJStarSlider.h"
#import "DJControlsFactory.h"
#import "DJOrderDetailCell2.h"
#import "DJOrderDetailCell.h"
#import "DJOrderStatus.h"
#import "DJOrderProviderFactory.h"


@implementation DJOrderUncompletedTableProvider

-(id) init{
    
    self = [super init ] ;
    if (self) {
        heights =[[NSMutableArray alloc]init ];
        [heights addObject:[NSNumber numberWithFloat:63  ]];
        [heights addObject:[NSNumber numberWithFloat:HEITH_NORMAL_CELL + 20  ]];

        for ( int i = 2 ; i < 6 ; i ++ ) {
            [heights addObject:[NSNumber numberWithFloat:HEITH_NORMAL_CELL ]];
        }
        
        //初始化时没有展开的
        _currentExtend = -1 ;

    }
    return self ;
}

-(int) numberOfSection {
    if ( self.model.currentStatus == ORDER_STATUS_COMPLETED  ) {  //完成状态，需要有价格明细
        return 2;
    }
    return 1;
    
}

-(int) numberOfRowInSection:(int) section {
    if ( section == 1 ) { ////完成状态，需要有价格明细
        return 1 ;
    }
    return [self.model.statusList count ] + 1  ;
}

-(CGFloat ) heightOfRow:(int) row inSection:(int) section {
    
    if ( self.model.currentStatus == ORDER_STATUS_CANCEL) {
        return 162 ;
    }
    else {
        if ( row -1 > self.model.currentStatus  ) { //当前还没达到的状态，黑色，矮20像素
            return [[heights objectAtIndex:row ] floatValue ] - 20 ;
        }
        return [[heights objectAtIndex:row ] floatValue ] ;
    }
    
}


-(UITableViewCell *) addTitle:(UITableView *)tableView{
    
    static NSString *identifier = @"DJOrderDetailTitle";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil ) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier ] ;
    }
    UILabel *label = [[UILabel alloc ] initWithFrame:CGRectMake(12, 12, 200, 20) ];
    label.font = [ UIFont boldSystemFontOfSize:16 ];
    label.textColor = [ UIColor grayColor ];
    label.text = @"订单状态" ;
    [cell addSubview:label ] ;
    
    UIView *seperatorline = [[UIView alloc ] initWithFrame:CGRectMake(12, 43 , 296, 0.5 ) ] ;
    seperatorline.backgroundColor = [UIColor grayColor ] ;
    [cell addSubview:seperatorline ] ;
    
    return cell ;
}


- (UITableViewCell *) driving:(UITableView *)tableView row:(int) row{
    
    
    if ( row == 0 ) { //第一行标题
        return [self addTitle:tableView ];
    }
    
    static NSString *identifier = @"DJOrderDetail";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [ [DJOrderDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:identifier];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    NSNumber *height = [heights objectAtIndex: row ] ;
    if ( [height floatValue ] >= HEITH_EXTENTED_CELL ) {
        [((DJOrderDetailCell*)cell) stretch ] ;
    }else
        [((DJOrderDetailCell*)cell) shrink ] ;
    
    DJOrderStatus *status = [self.model.statusList objectAtIndex: row - 1  ] ;
    ((DJOrderDetailCell *)cell).status = status.name ;
    ((DJOrderDetailCell *)cell).timeString = status.time ;
    ((DJOrderDetailCell *)cell).locationDes = status.location ;
    if ( self.model.currentStatus >= row -1  ) {
        ((DJOrderDetailCell *)cell).enable = YES ;
    }else
        ((DJOrderDetailCell *)cell).enable = NO ;
    
    return cell;
}

- (UITableViewCell *) orderCanceled{

    UILabel * label = [[UILabel alloc ] initWithFrame:CGRectMake(0, 0, 320, 40) ];
    label.text = @"已取消" ;
    
    return label ;
}

-(UIView *) viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ( self.model.currentStatus == ORDER_STATUS_CANCEL ) { //取消
        return  [self orderCanceled ] ;
    }
    else{
        return  [self driving : tableView row:indexPath.row ] ;
    }
   
}

@end
