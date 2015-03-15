//
//  DJStarSlider.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJStarSlider.h"
#import "DJControlsFactory.h"
#import "DJUIUtils.h"

@implementation DJStarDescriptionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //    uselessView.backgroundColor = [UIColor greenColor ] ;
        
        /*    CUSLinnerLayout *layout = [[CUSLinnerLayout alloc ] init ] ;
         layout.marginTop =layout.marginBottom = 0 ;
         layout.marginLeft = layout.marginRight = 5 ;
         layout.type = CUSLayoutTypeHorizontal ;
         uselessView.layoutFrame = layout ;
         */
        UIView *line1 = [self addLine:[UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:0] to: [UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:1] ];
        line1.frame = CGRectMake(0, 5, 85, 1) ;
        [self addSubview:line1 ] ;
        
        label = [[UILabel alloc ] init ] ;
        label.backgroundColor = [UIColor clearColor ] ;
        label.font = [UIFont systemFontOfSize:11 ] ;
        label.text = self.title ;
        label.textColor = [UIColor colorWithHex:0xd0d0d0 ];
        label.textAlignment = NSTextAlignmentCenter ;
        label.frame = CGRectMake(85, 0, 106, 12) ;
        CUSLinnerData *data3 = [[CUSLinnerData alloc ] init ] ;
        data3.width = 106 ;
        data3.height = 12 ;
        label.layoutData = data3 ;
        [self addSubview:label ] ;
        
        UIView *line2 =[self addLine:[UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:1] to: [UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:0] ];
        line2.frame = CGRectMake(190, 5, 85, 1) ;
        [self addSubview:line2 ] ;
        
    }
    return  self ;
}

-(void) setTitle:(NSString *) title1 {
    
    _title = title1 ;
    label.text = _title ;
    
}

-(UIView *) addLine:(UIColor *) color to:(UIColor *) color2 {
    UIView *line1 = [[UIView alloc ] init ];
    CUSLinnerData *data2 = [[CUSLinnerData alloc ] init ] ;
    data2.height = 1 ;
    data2.fill = true ;
    line1.layoutData = data2 ;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //决定了绘制渐变时方向性. 默认是 由上往下,  可以通过修改产生颜色渐变的倾斜效果
    gradient.startPoint = CGPointMake(0, 0.5);//默认轴为: 0.5 0.0
    gradient.endPoint = CGPointMake(1, 0.5);//默认轴为: 0.5 1.0
    gradient.frame = CGRectMake(0 , 0 , 85 , 1 ) ;
    gradient.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:1],nil];
    gradient.colors = [NSArray arrayWithObjects:(id)color.CGColor,
                       //                       (id)[UIColor colorWithRed:0.051 green:0.051 blue:0.051 alpha:0 ].CGColor,
                       (id)color2.CGColor,nil];
    
    [line1.layer insertSublayer:gradient atIndex:0];
    return line1 ;
}

@end

@implementation DJStarSlider

UIImage *grayStar ;
UIImage *orangeStar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _starCount = 5 ;
        self.score = 0 ;
        self.stars = [[NSMutableArray alloc ] init ] ;
        CUSFillLayout *layout= [[CUSFillLayout alloc ] init ];
        layout.marginHeight =  20 ;
        layout.marginWidth = 5 ;
        layout.spacing =  20 ;

        self.layoutFrame =  layout ;
        for ( int i = 0 ; i < _starCount ; i ++ ) {
            
            UIImageView *imageView = [[UIImageView alloc ] init ] ;
            imageView.image = [UIImage imageNamedFrombundle:@"灰星"] ;
            [self addSubview:imageView ] ;
            
            imageView.tag = 1001 + i ;
            
            UITapGestureRecognizer *tapListener =[[UITapGestureRecognizer alloc ] initWithTarget:self action:@selector(onTap:) ];
            [imageView addGestureRecognizer:tapListener ] ;
             imageView.userInteractionEnabled = YES;
            [self.stars addObject:imageView ] ;
        }
        UIPanGestureRecognizer *panListener = [[UIPanGestureRecognizer alloc ]initWithTarget:self action:@selector(onPan:) ] ;
        [self addGestureRecognizer:panListener ] ;

        if (grayStar == nil ) {
            grayStar = [UIImage imageNamedFrombundle:@"灰星"] ;
            orangeStar = [UIImage imageNamedFrombundle:@"橙星"]  ;
        }
    }
    return self;
}


- (id)init
{
    self = [self initWithFrame:CGRectMake(0, 0, 1, 1)];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) layoutSubviews{
    [super layoutSubviews ];
    
}

-(void) onTap:(UIPanGestureRecognizer*)gestureRecognizer {
    
    UIImageView *imageView = (UIImageView *)gestureRecognizer.view;
    [self onSelect:imageView ] ;
}

-(void) onSelect:(id) sender {

    UIImageView *imageView = sender ;
    int tag = imageView.tag - 1000 ;
    if ( tag  != self.score ) {
        self.score = tag    ;
    }
//    else{ //如果点击已选中星星，deselect it
//        self.score = tag - 1 ;
//    }
    
    for ( int i = 0 ;  i < self.score ; i ++ ) {
        UIImageView *iView  = [self.stars objectAtIndex:i ];
        iView.image =  orangeStar ;
    }
    for ( int i = self.score ;  i <  [self.stars count ] ; i ++) {
        UIImageView *iView  = [self.stars objectAtIndex:i ];
        iView.image =  grayStar ;
    }
    if ( self.delegate != nil ) {
        [self.delegate slider:self didSelectIndex:_score ] ;

    }
}

-(void) onPan:(UIPanGestureRecognizer*)gestureRecognizer{
    //获取平移手势对象在self.view的位置点，并将这个点作为self.aView的center,这样就实现了拖动的效果
    CGPoint curPoint = [gestureRecognizer locationInView:self ];
    
    if ( ! [DJUIUtils point:curPoint inRect:self.bounds ]  ) {
        return ;
    }
    
    for ( int i = self.starCount-1 ; i >= 0 ; i -- ) {
        UIImageView *iView = [ _stars objectAtIndex:i ] ;
//        CGPoint curPoint = [gestureRecognizer locationInView:self ];
        if ( [DJUIUtils point:curPoint inRect:iView.frame ]  ) {
            [self onSelect:iView ] ;
            
        }
        
    }
}


@end
