//
//  DJMoreCell.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-21.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJMoreCell.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"
#import "DJControlsFactory.h"

@implementation DJMoreCell


//左边距
@synthesize marginLeft;
//上边距
@synthesize marginTop;
//右边距
@synthesize  marginRight;
//下边距
@synthesize marginBottom;

GLfloat spacing = 12 ;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ] ;
    
    if (self) {
        _hasArrow = true ;
        _hasTopLine = false ;
        marginLeft = marginRight = marginBottom  = 12 ;
        marginTop = 13 ;
        self.hintIcon = [[UIImageView alloc ] initWithFrame:CGRectMake(marginLeft, marginTop, 20, 20) ] ;
        [self addSubview:self.hintIcon ] ;
        
        self.caption = [DJControlsFactory createLabel:H2 text:@"" ];
        self.caption.frame = CGRectMake( marginLeft + 20 + spacing , marginTop + 1, 110 , 20 ) ;
        [self addSubview:self.caption ];

        self.description = [DJControlsFactory createLabel:NORMAL_TEXT text:@"" ];
        self.description.frame = CGRectMake( [DJUIUtils getWindowWidth ] - marginRight - spacing - 12 - 130 , marginTop + 1 , 130 , 20 ) ;
        self.description.textAlignment = NSTextAlignmentRight ;
        [self addSubview:self.description ];

        _arrowImage = [[UIImageView alloc ] initWithFrame:CGRectMake([DJUIUtils getWindowWidth ] - marginRight - spacing , marginTop + 5 , 12, 12) ] ;
         _arrowImage.image = [UIImage imageNamedFrombundle:@"右箭头"] ;
        [self addSubview: _arrowImage ] ;
        
        self.line = [[UIView alloc ] init ] ;
        self.line.backgroundColor = [DJControlsFactory getLineColor:LIGHT ] ;
        [self addSubview:self.line ] ;
        
        if ( _hasTopLine ) {
            self.lineTop = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5) ] ;
            self.line.backgroundColor = [DJControlsFactory getLineColor:DEEP ] ;
            [self addSubview:self.line ] ;
        }
        self.selectionStyle = UITableViewCellSelectionStyleGray ;
    }
    return self;
}

-(void) setHasArrow:(BOOL) hasArrow1 {
    
    _hasArrow = hasArrow1 ;
    if (! hasArrow1 ) {
        _arrowImage.image = nil ;
        self.description.frame = CGRectMake( [DJUIUtils getWindowWidth ] - marginRight - spacing - 12 - 130 , marginTop + 1 , 150 , 20 ) ; ;
    }else{
        _arrowImage.image = [UIImage imageNamedFrombundle:@"右箭头"] ;
        self.description.frame = CGRectMake( [DJUIUtils getWindowWidth ] - marginRight - spacing - 12 - 130 , marginTop + 1 , 130 , 20 ) ;
    }
}

-(void) setTopLine:(BOOL) drawLine {
    
    _hasTopLine = drawLine ;
    if (drawLine  ) {
        if ( !self.lineTop ) {
            self.lineTop = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5) ] ;
            self.lineTop.backgroundColor = [DJControlsFactory getLineColor:DEEP ] ;
        }
        [self addSubview:self.lineTop ] ;
    }else
        [self.lineTop removeFromSuperview ];
}

@end
