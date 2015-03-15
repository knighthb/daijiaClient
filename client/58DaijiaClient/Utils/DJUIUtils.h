//
//  DJUIUtils.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJUIUtils : NSObject


+(CGRect ) getWindowSize;

+(CGFloat ) getWindowWidth ;
+(CGFloat ) getWindowHeight ;


+(UIImage *) getImageFromURL:(NSString *) picUrl ;

+(GLfloat ) getLabelHeight:(UILabel *) label forWidth:(GLfloat) width  ;

+(BOOL ) point:(CGPoint)curPoint inRect:(CGRect) bound ;

@end
