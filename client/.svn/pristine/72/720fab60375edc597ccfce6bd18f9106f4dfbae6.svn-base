//
//  DJAdCell.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-18.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJAdCell.h"
#import "DJControlsFactory.h"

@implementation DJAdCell

@synthesize adImage , adTitle ;

//左边距
@synthesize marginLeft;
//上边距
@synthesize marginTop;
//右边距
@synthesize marginRight;
//下边距
@synthesize marginBottom;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ] ;
    
    if (self) {
        
        marginBottom = 5 ;
        
        CUSLinnerLayout *linnerLayout = [[CUSLinnerLayout alloc ] init] ;
        linnerLayout.type = CUSLayoutTypeVertical ;
//        self.layoutFrame = linnerLayout ;
        
        adTitle = [DJControlsFactory createLabel:H2 text:@"" ];
        adTitle.frame  = CGRectMake( marginLeft, marginTop, 295 - marginRight, 43 - marginBottom/2 ) ;
        CUSLinnerData *data1 = [[CUSLinnerData alloc ] init ] ;
        data1.height = 43 ;
        data1.width = 295;
        adTitle.layoutData = data1 ;
        
        adImage = [[EGOImageView alloc ] initWithImage:nil ] ;
        CUSLinnerData *data2 = [[CUSLinnerData alloc ] init ] ;
         adImage.frame  = CGRectMake(marginLeft, marginTop + 45, 295- marginRight , 110 - marginBottom/2 ) ;
        data2.height = 148 ;
        data2.width = 295;
        adImage.layoutData = data2 ;
        
        [self addSubview:adTitle ];
        [self addSubview:adImage ] ;
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    return self;
}

-(void) layoutSubviews{
    
    adTitle.frame  = CGRectMake( marginLeft, marginTop, 295 - marginRight, 43 - marginBottom/2 ) ;
    adImage.frame  = CGRectMake(marginLeft, marginTop + 45, 295- marginRight , 148 - marginBottom/2 ) ;
    
}

@end
