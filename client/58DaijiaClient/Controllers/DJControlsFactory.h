//
//  DJControlsFactory.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HuangyeLib/PrettyDrawing.h>
typedef enum{
    H1,
    H2,
    NORMAL_TEXT
}LABEL_STYLE;
typedef enum{
    LIGHT,
    DEEP
}LINE_COLOR_STYLE;

#define COLOR_ORANGE  [ UIColor colorWithHex:0xff9200]
#define COLOR_RED2   [ UIColor colorWithHex:0xfe5e46 ]  
#define COLOR_WHITE2   [ UIColor colorWithHex:0xffffff ]
#define COLOR_BLUE2   [ UIColor colorWithHex:0xe3efff ]

const static NSString *ERROR_NETWORK = @"网络错误，请稍候重试"  ;

@interface UIImage (UIImageExt)
//从bundle中获取图片
+ (UIImage*) imageNamedFrombundle:(NSString *) name ;
@end

@interface DJControlsFactory : NSObject

+(UIColor *) getBackgroundColor;

+(UIColor *) getLineColor : (LINE_COLOR_STYLE) style ;

+(UIButton *) createControl:(NSString *)type text:(NSString *) text ;

+(UIButton *) createControlWithColor:(UIColor *)color text:(NSString *) text ;

+(UIButton *) createControlWithColor:(UIColor *)color text:(NSString *) text frame:(CGRect)frame ;

+(UIBarButtonItem *) createNavigationItemImage:(UIImage *) image target:(id)target action:(SEL) selector ;

+(UIBarButtonItem *) createNavigationItemText:(NSString *) title ;


+(UIButton *) createButton:(UIColor *)color text:(NSString *) text  radius:(float) rad fontSize:(float) size;

+(UIButton *) createCustomButton:(UIColor *)color text:(NSString *) text  radius:(float) rad fontSize:(float) size;

+(UIButton *) setButton:(UIButton *) button color:(UIColor *)color text:(NSString *) text radius:(float) rad fontSize:(float) size;

+(UILabel *) createLabel:(LABEL_STYLE)type text:(NSString *) text ;

+(UIButton *) createButton:(NSString *)type imageName:(NSString *) imageName;

+(UIViewController *) createTab:(NSMutableArray *) subVCs ;

+(UINavigationController *) createNavigation:(UIViewController *) rootController ;

+(UITextField *) createTextFiled:(NSString *) placeholder delegate:(id) delegate;

+(UIView *) createEmptyView:(CGRect) frame  image:(NSString *)imageString title:(NSString *)title description:(NSString *) des ;


+(void) showError:(NSString *) errorMessage ;

+(void) showSuccess:(NSString *) message ;

+(UIView *) createFlatSegment:(NSMutableArray *)segmentedControlItems selectionBlock:selectionBlock ;

@end
