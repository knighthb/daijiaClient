//
//  DJUIUtils.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJUIUtils.h"
#import <HuangyeLib/HYSmartViewController.h>

@implementation DJUIUtils


+(CGRect ) getWindowSize{
    UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
    return  keyWindow.bounds;
}

+(CGFloat ) getWindowWidth{
    UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
    return  keyWindow.bounds.size.width;
}
+(CGFloat ) getWindowHeight{
    UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
    return  keyWindow.bounds.size.height;
}

+(UIImage *) getImageFromURL:(NSString *) picUrl {
    
    NSData * picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
    return [UIImage imageWithData:picdata];
}

+(GLfloat ) getLabelHeight:(UILabel *) label forWidth : (GLfloat) width {
    
    if ( label == nil ) {
        return 0 ;
    }
    
    CGSize size;
    
    if ( IsIOS7) {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        size = [label.text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil ].size ;
    }else{
        size = [label.text sizeWithFont:label.font forWidth:width lineBreakMode:NSLineBreakByWordWrapping ] ;
    }
    
    return size.height ;
}

+(BOOL ) point:(CGPoint)curPoint inRect:(CGRect) bound {
    
    if ( curPoint.x < bound.origin.x  ) {
        return false ;
    }
    if ( curPoint.y < bound.origin.y  ) {
        return false ;
    }
    if ( curPoint.x > bound.origin.x + bound.size.width  ) {
        return false ;
    }
    if ( curPoint.y > bound.origin.y + bound.size.height  ) {
        return false ;
    }
    return true ;
}

@end
