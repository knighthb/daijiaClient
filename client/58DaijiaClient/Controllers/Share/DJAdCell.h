//
//  DJAdCell.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-18.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface DJAdCell : UITableViewCell

@property (strong ) UILabel *adTitle ;

@property (strong ) EGOImageView *adImage ;

//左边距
@property (nonatomic,assign) CGFloat marginLeft;
//上边距
@property (nonatomic,assign) CGFloat marginTop;
//右边距
@property (nonatomic,assign) CGFloat marginRight;
//下边距
@property (nonatomic,assign) CGFloat marginBottom;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;


@end
