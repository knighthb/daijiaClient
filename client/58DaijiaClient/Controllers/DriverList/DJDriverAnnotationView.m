//
//  DJDriverAnnotationView.m
//  58DaijiaClient
//
//  Created by huangbin on 14-4-17.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJDriverAnnotationView.h"
#define  Arrow_height 10
#define WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define HEIGHT 186/2 + Arrow_height
#define LEFT_OFFSET 100
#define TOP_OFFSET -70
#define OFFSET 6
#define MARGIN_LEFT 20/2
@implementation DJDriverAnnotationView

@synthesize contentView;
-(id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, WIDTH-2*MARGIN_LEFT, HEIGHT);
        self.centerOffset = CGPointMake(0, TOP_OFFSET);
        self.backgroundColor = [UIColor clearColor];
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-Arrow_height)];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
    }
    return  self;
}

-(void) getDrawPath:(CGContextRef) context
{
    CGRect rect = self.bounds;
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxY = CGRectGetMaxY(rect) - Arrow_height;
    CGContextMoveToPoint(context, midX + OFFSET, maxY);
    CGContextAddLineToPoint(context, midX, maxY+Arrow_height);
    CGContextAddLineToPoint(context, midX - OFFSET, maxY);
    CGContextClosePath(context);

//    CGContextAddArc(context, minX+5, minY+5, 5, 270/360, 360/360, 1);

//    CGContextMoveToPoint(context, minX+0.5, minY+0.5);
   
    
}

-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

-(void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    [[UIColor darkGrayColor] setFill];
    self.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//    self.layer.borderColor = [UIColor grayColor].CGColor;
//    self.layer.borderWidth = 0.5f;
//    [self.layer setCornerRadius:0.5f];
}
@end
