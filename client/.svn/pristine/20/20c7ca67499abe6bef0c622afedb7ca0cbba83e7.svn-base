//
//  DJStarView.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-6-13.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJStarView.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"

@implementation DJStarView

    UIImage *grayStar ;
    UIImage *orangeStar;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (grayStar == nil ) {
            grayStar = [UIImage imageNamedFrombundle:@"灰星2"] ;
            orangeStar = [UIImage imageNamedFrombundle:@"橙星2"]  ;
        }
        _starCount = 5 ;
        self.score = 0 ;
        self.stars = [[NSMutableArray alloc ] init ] ;
        CUSFillLayout *layout= [[CUSFillLayout alloc ] init ];
        layout.marginHeight = ( frame.size.height - 13 ) / 2 ;
        layout.marginWidth = ( frame.size.width - (13 + 2) * _starCount ) / 2 ;
        layout.spacing = 2 ;
        
        self.layoutFrame =  layout ;
        for ( int i = 0 ; i < _starCount ; i ++ ) {
            
            UIImageView *imageView = [[UIImageView alloc ] init ] ;
            imageView.image = grayStar ;
            [self addSubview:imageView ] ;
            
            [self.stars addObject:imageView ] ;
        }
       
    }
    return self;
}


- (id)init
{
    self = [self initWithFrame:CGRectMake(0, 0, 1, 1)];
    return self;
}

-(void) setScore:(int)score{
    
    if ( score < 1 || score > _starCount ) {
        return;
    }
    _score = score ;
    for ( int i = 0 ;  i < _score ; i ++ ) {
        UIImageView *iView  = [self.stars objectAtIndex:i ];
        iView.image =  orangeStar ;
    }
    for ( int i = _score ;  i <  [self.stars count ] ; i ++) {
        UIImageView *iView  = [self.stars objectAtIndex:i ];
        iView.image =  grayStar ;
    }

    
}

@end
