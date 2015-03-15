//
//  DJOrderTablePartProvider.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJOrderCompletedTableProvider.h"
#import "DJUIUtils.h"
#import "DJStarSlider.h"
#import "DJControlsFactory.h"
#import "DJOrderDetailCell2.h"
#import "DJOrderDetailCell.h"
#import "DJOrderStatus.h"
#import "DJOrderProviderFactory.h"


@implementation DJOrderCompletedTableProvider


-(id) init{
    self = [super init ] ;
    if (self) {
        heights = [[NSArray alloc] initWithObjects:  [NSNumber numberWithFloat: 44] , //标题
                   [NSNumber numberWithFloat:HEITH_NORMAL_CELL + 20 ] , //司机已就位，有地址
                   [NSNumber numberWithFloat: HEITH_NORMAL_CELL ] , [NSNumber numberWithFloat: HEITH_NORMAL_CELL ] , [NSNumber numberWithFloat: HEITH_NORMAL_CELL], [NSNumber numberWithFloat:HEITH_NORMAL_CELL],nil ] ;
    }
    return self ;
}

-(int) numberOfSection {
    if ( self.model.commentStatus == ORDER_COMMENT_COMPLETED  ) {  //已评价，需要有评价cell
        return 3 ;
    }
    return 2 ;
    
}

-(int) numberOfRowInSection:(int) section {
    if ( section >= 1 ) { //// 价格明细 , 评价
        return 1 ;
    }
    return [self.model.statusList count ] + 1  ;
}

-(CGFloat ) heightOfRow:(int) row inSection:(int) section {
    if (  section == 0   ) {
        NSNumber *number = [heights objectAtIndex: row ];
        return  [number floatValue];
    }
    if( section == 1 ) //价格明细
        return 135 ;
    if (section == 2 ) { // 评价内容
        return 63 ;
    }
    return 0 ;
}



-(UIView *) viewForFooterInSection:(NSInteger)section {
    if (section != 1 )
        return nil ;
    
    if ( self.model.commentStatus == ORDER_COMMENT_TODO ) { //待评价
        return  [self commentTODO];
    }else if( self.model.commentStatus == ORDER_COMMENT_COMPLETED ) { //评价内容
        return [self commentShow] ;
    }else{ // 评价已关闭
        return [self commentClosed] ;
    }
}

-(UIView *) commentShow {
    //TODO:显示注释
    return nil ;
}


-(UIView *) commentClosed {
    //TODO:显示注释已经关闭
    return nil ;
}

-(UIView *) commentTODO {
    
    UIView *footer = [[UIView alloc ] initWithFrame:CGRectMake(0, 10, [DJUIUtils getWindowWidth], 135) ] ;
    DJStarDescriptionView *uselessView = [[DJStarDescriptionView alloc ] init ] ;
    uselessView.frame = CGRectMake(5, 5, [DJUIUtils getWindowWidth] -10  , 12) ;
    uselessView.title = @"点击星星即可点评" ;
    [footer addSubview:uselessView ] ;
    
    DJStarSlider *stars = [[DJStarSlider alloc ] initWithFrame:CGRectMake(5, 15 , [DJUIUtils getWindowWidth] -10, 85 ) ];
    stars.delegate = self.delegate ;
    [footer addSubview:stars ] ;
    
    UIButton *button = [DJControlsFactory  createControlWithColor:COLOR_ORANGE text:@"分享有好礼" frame:CGRectMake(13 , 105 , [DJUIUtils getWindowWidth] - 26 , 40 )] ;
    [button addTarget:self.delegate action:@selector(share:) forControlEvents:UIControlEventTouchUpInside ] ;
    [footer addSubview:button ] ;
    return footer ;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.section == 1 ) {
        return [self addCost];
    }
    else if( indexPath.section == 0 ) {// 状态列表
        return [self statusList:indexPath ] ;
    }
    
    return nil ;
}


-(UITableViewCell *) statusList:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DJOrderDetail";
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [ [DJOrderDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:identifier];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    DJOrderStatus *status = [self.model.statusList objectAtIndex:indexPath.row - 1  ] ;
    ((DJOrderDetailCell *)cell).status = status.name ;
    ((DJOrderDetailCell *)cell).timeString = status.time ;
    ((DJOrderDetailCell *)cell).locationDes = status.location ;
    if ( self.model.currentStatus >= indexPath.row -1  ) {
        ((DJOrderDetailCell *)cell).enable = YES ;
    }else
        ((DJOrderDetailCell *)cell).enable = NO ;
    
    return cell;

}

-(UITableViewCell *) addCost {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cost"];
	if (!cell) {
		cell = [ [DJOrderDetailCell2 alloc]initWithStyle:UITableViewCellStyleSubtitle
                                         reuseIdentifier:@"cost"];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    return cell ;
}


@end
