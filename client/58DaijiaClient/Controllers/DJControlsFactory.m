//
//  DJControlsFactory.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-12.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJControlsFactory.h"
#import "DJTabController.h"
#import "DJNavigationWrapper.h"
#import "ProgressHUD.h"
#import <HuangyeLib/PPiFlatSegmentedControl.h>
#import "DJNavigationWraper2.h"

@implementation UIImage(UIImageExt)

//从bundle中获取图片
+ (UIImage*) imageNamedFrombundle:(NSString *) name {
    NSBundle *main =[NSBundle mainBundle];
    NSString *path = [main resourcePath];
    NSString *main_images_dir_path = [ path stringByAppendingPathComponent:@"daijia.bundle/images"];
    //    NSAssert(main_images_dir_path, @"main_images_dir_path is null");
    NSString *image_path = [main_images_dir_path stringByAppendingFormat:@"/%@.png",name];
    return [UIImage imageWithContentsOfFile:image_path];
}


@end


@implementation DJControlsFactory

+(UIButton *) createControl:(NSString *)type text:(NSString *) text {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom ] ;
    UIImage *image = nil;
    UIImage *image2 = nil;
    if ( [type isEqualToString:@"新浪微博"] ) {
        image = [ UIImage imageNamedFrombundle:@"新浪"] ;
        image2 = [ UIImage imageNamedFrombundle:@"新浪选中"] ;
    }else if([type isEqualToString:@"微信好友"]  ){
        image = [ UIImage imageNamedFrombundle:@"微信"] ;
        image2 = [ UIImage imageNamedFrombundle:@"微信选中"] ;
    }else if([type isEqualToString:@"QQ好友"]  ){
        image = [ UIImage imageNamedFrombundle:@"QQ"] ;
        image2 = [ UIImage imageNamedFrombundle:@"QQ选中"] ;
    }else if([type isEqualToString:@"朋友圈"]  ){
        image = [ UIImage imageNamedFrombundle:@"朋友圈"] ;
        image2 = [ UIImage imageNamedFrombundle:@"朋友圈选中"] ;
    }
    [button setImage:image forState:UIControlStateNormal ];
    [button setImage:image2  forState:UIControlStateHighlighted ];
    if( text != nil ){
      [ button setTitle:text forState:UIControlStateNormal ] ;
        button.titleLabel.font = [UIFont systemFontOfSize:14  ];
        [button setTitleColor:[UIColor colorWithHex:0x8d8d8d ] forState:UIControlStateNormal ] ;
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 9, 20, 0) ];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(55, -47 , 0, 0); //top, left, bottom, right
        if ( IsIOS7 && text.length < 4 ) {
            insets.left -= (4 - text.length) * 8 ;
        }
        if ( ! IsIOS7) {
            insets.left+= 6 ;
            if ( text.length < 4 ) {
                insets.left -= (4 - text.length) * 2 ;
            }
        }
        [button setTitleEdgeInsets:insets ];
    }
    return  button;
}

+(UIButton *) createControlWithColor:(UIColor *)color text:(NSString *) text {
    return [DJControlsFactory createControlWithColor:color text:text frame:CGRectZero ] ;
}

+ (BOOL) isTheSameColor:(UIColor*)color andColor:(UIColor *)color2
  {
    
          if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        
                  CGFloat redValue, greenValue, blueValue, alphaValue;
                CGFloat rValue, gValue, bValue, aValue;

                  if ([color getRed:&redValue green:&greenValue blue:&blueValue alpha:&alphaValue] &&
                       [color2 getRed:&rValue green:&gValue blue:&bValue alpha:&aValue] ) {
                          if (redValue == rValue && greenValue == gValue
                                                   && blueValue == bValue && alphaValue == aValue) {
                                  return YES;
                              }
                          else {
                                return NO;
                            }
                    }
          }
      return  NO ;
}

+(NSString *) imageNameFromColor:(UIColor*)color forState:(UIControlState) state{
    
    if ( [ DJControlsFactory isTheSameColor:COLOR_ORANGE andColor:color ] ) {
        if (state == UIControlStateHighlighted) {
            return @"orange_h";
        }else
            return @"orange_n";
    }
    if ( [ DJControlsFactory isTheSameColor:COLOR_RED2 andColor:color ] ) {
        if (state == UIControlStateHighlighted) {
            return @"red_h";
        }else
            return @"red_n";
    }
    if ( [ DJControlsFactory isTheSameColor:COLOR_WHITE2 andColor:color ] ) {
        if (state == UIControlStateHighlighted) {
            return @"white_h";
        }else
            return @"white_n";
    }
    if ( [ DJControlsFactory isTheSameColor:COLOR_BLUE2 andColor:color ] ) {
        if (state == UIControlStateHighlighted) {
            return @"blue_h";
        }else
            return @"blue_n";
    }
    
    
    return @"orange_n";
    
}

+(UIButton *) createControlWithColor:(UIColor *)color text:(NSString *) text  frame:(CGRect)frame{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame ;

    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ] ;
    UIImage *image_n = [UIImage imageNamedFrombundle:[DJControlsFactory imageNameFromColor:color forState:UIControlStateNormal ]  ] ;
    UIEdgeInsets insets = UIEdgeInsetsMake(image_n.size.height /2 -1 , image_n.size.width /2 - 1, image_n.size.height /2 -1 , image_n.size.width /2 -1 ) ;

    UIImage *image_n2 = [image_n resizableImageWithCapInsets:insets ] ;
    
    UIImage *image_h = [UIImage imageNamedFrombundle:[DJControlsFactory imageNameFromColor:color forState:UIControlStateHighlighted ] ] ;
    UIEdgeInsets insets2 = UIEdgeInsetsMake(image_n.size.height /2 -1 , image_n.size.width /2 - 1, image_n.size.height /2, image_n.size.width /2) ;
    
    UIImage *image_h2 = [image_h resizableImageWithCapInsets:insets2 ] ;
    [button setBackgroundImage:image_n2 forState:UIControlStateNormal ] ;
    [button setBackgroundImage:image_h2 forState:UIControlStateHighlighted ] ;
    [button setTitleColor:[UIColor colorWithHex:0xf3d8b3] forState:UIControlStateHighlighted ] ;
    return button ;
}

+(UIButton *) createButton:(UIColor *)color text:(NSString *) text radius:(float) rad fontSize:(float) size{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom ] ;
    button = [self setButton:button color:color text:text radius:rad fontSize:size];
    return  button;
}

+(UIButton *) setButton:(UIButton *) button color:(UIColor *)color text:(NSString *) text radius:(float) rad fontSize:(float) size{
    if( text != nil ){
        [ button setTitle:text forState:UIControlStateNormal ] ;
        button.titleLabel.font = FontSize(size);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if (rad >= 0.0f) {
        [button.layer setCornerRadius:rad];
    }
    button.backgroundColor  = color==nil?[UIColor clearColor]:color;
    return  button;

}

+(UIButton *) createCustomButton:(UIColor *)color text:(NSString *) text  radius:(float) rad fontSize:(float) size {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button = [self setButton:button color:color text:text radius:rad fontSize:size];
    [button setImage:[UIImage imageNamedFrombundle:@"电话2"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamedFrombundle:@"电话2"] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    return button;
}


+(UIButton *) createButton:(NSString *)type imageName:(NSString *) imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom ] ;
    if( imageName != nil ){
        [button setBackgroundImage:[UIImage imageNamedFrombundle:imageName] forState:UIControlStateNormal];
        UIImage *img_h = [UIImage imageNamedFrombundle:[imageName stringByAppendingString:@"选中"]] ;
        if (img_h) {
            [button setBackgroundImage: img_h forState:UIControlStateHighlighted ];
        }
    }
    return  button;
}


+(UILabel *) createLabel:(LABEL_STYLE)type text:(NSString *) text {

    UILabel *label = [[UILabel alloc ] init ] ;
    label.backgroundColor = [UIColor clearColor ] ;
    label.text = text ;
    switch (type) {
        case H1:
            label.textColor = [UIColor whiteColor ] ;
            label.font = [ UIFont systemFontOfSize:20 ];
            break;
        case H2:
            label.textColor = [UIColor blackColor ] ;
            label.font = [ UIFont systemFontOfSize:16 ];
            break;
        case NORMAL_TEXT:
            label.textColor = [UIColor grayColor];
            label.font =  [UIFont systemFontOfSize:14.0f];
            if (IsIOS6) {
                label.lineBreakMode = NSLineBreakByWordWrapping ;
            }else
                label.lineBreakMode = UILineBreakModeWordWrap ;
            break;
        default:
            break;
    }
    return label ;
    
}


+(UIViewController *) createTab:(NSMutableArray *) subVCs {
    
    
    DJTabController *con = [[DJTabController alloc ]initWithSubViews:subVCs ] ;

    return con ;
}


+(UINavigationController *) createNavigation:(UIViewController *) rootController {
    if ( ! IsIOS7) {
        DJNavigationWrapper *navi = [[DJNavigationWrapper alloc ] initWithRootViewController:rootController ] ;
        return navi ;
    }
    DJNavigationWraper2 *navi = [[DJNavigationWraper2 alloc ] initWithRootViewController:rootController ] ;

    return navi ;
    
}

+(UITextField *) createTextFiled:(NSString *) placeholder delegate:(id) delegate
{
    UITextField * phoneNumText = [[UITextField alloc] init];
    phoneNumText.delegate = delegate;
    phoneNumText.layer.borderColor = [HexToUIColorRGB(0xdddddd) CGColor];
    phoneNumText.layer.borderWidth = 2/2.0f;
    [phoneNumText.layer setCornerRadius:10/2.0f];
    phoneNumText.textColor = HexToUIColorRGB(0x000);
    phoneNumText.backgroundColor = [UIColor whiteColor];
    if (placeholder!=nil) {
        phoneNumText.placeholder = placeholder;
    }
    phoneNumText.enablesReturnKeyAutomatically = YES;
    phoneNumText.keyboardType = UIKeyboardTypePhonePad;
    phoneNumText.returnKeyType = UIReturnKeyDone;
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    phoneNumText.leftViewMode = UITextFieldViewModeAlways;
    phoneNumText.leftView = leftview;
    phoneNumText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
    
    phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;

//    UIButton *  closeButton = [DJControlsFactory createButton:@"" imageName:@"关闭"];
//    closeButton.frame = CGRectMake(0, 0, 25, 25);
//    phoneNumText.rightViewMode =  UITextFieldViewModeAlways;
//    phoneNumText.rightView = closeButton;
    
    
    return phoneNumText;
}



+(UIColor *) getBackgroundColor {
    
    return HexToUIColorRGB(0xf6f6f6);
    
}

+(UIColor *) getLineColor : (LINE_COLOR_STYLE) style {
    
    switch ( style ) {
        case DEEP :
            
           return  HexToUIColorRGB( 0xdddddd );
        case LIGHT:
            
            return HexToUIColorRGB(0xe9e9e9 );
        default :
            break ;
            
    }
    return HexToUIColorRGB( 0xdddddd ); ;
}

+(UIView *) createEmptyView:(CGRect) frame  image:(NSString *)imageString title:(NSString *)title description:(NSString *) des {
    UIView *_emptyView = [[UIView alloc ] init ] ;
    _emptyView.backgroundColor = [DJControlsFactory getBackgroundColor] ;
    UIImage *image = [UIImage imageNamedFrombundle:imageString ] ; //@"无优惠券"
    CUSLinnerData *data =[[CUSLinnerData alloc ] init ] ;
    data.height =  frame.size.height ;
    _emptyView.layoutData = data ;
    UIImageView *imageView = [[UIImageView alloc ] initWithImage:image ] ;
    imageView.frame = CGRectMake(   (frame.size.width - 100)/2 ,   (frame.size.height - 100)/2 - 50 , 100, 100) ;
    [_emptyView addSubview:imageView ] ;
    
    UILabel *title1 = [DJControlsFactory createLabel:H2 text:title ] ;
    title1.frame = CGRectMake(0, (frame.size.height + 100)/2 + 15  - 50 , frame.size.width, 18) ;
    title1.textAlignment = UITextAlignmentCenter ;
    title1.textColor = [UIColor colorWithHex:0x8d8d8d ] ;
    [_emptyView addSubview:title1 ] ;
    
    UILabel *title2 = [DJControlsFactory createLabel:H2 text:des ] ;
    title2.frame = CGRectMake(0, (frame.size.height + 100)/2 + 45  - 50 , frame.size.width, 18) ;
    title2.font = [UIFont systemFontOfSize:12 ] ;
    title2.textAlignment = UITextAlignmentCenter ;
    title2.textColor = [UIColor colorWithHex:0xc3c3c3 ] ;
    title2.lineBreakMode = UILineBreakModeCharacterWrap ;
    if (des.length > 24 ) {
        title2.numberOfLines = 2 ;
    }
    
    [_emptyView addSubview:title2 ] ;
    return  _emptyView ;
}

+(void) showError:(NSString *) errorMessage {
    if (_DJDEBUGGER) {
        UIAlertView *alert = [ [UIAlertView alloc ] initWithTitle:@"debug" message:errorMessage delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil  ] ;
        [alert show ] ;
    }else
        [ProgressHUD showError:errorMessage ] ;
}

+(void) showSuccess:(NSString *) message {
    
    [ProgressHUD showSuccess:message ] ;
}


+(UIBarButtonItem *) createNavigationItemImage:(UIImage *) image target:(id)target action:(SEL) selector {
//    UIImageView *imageview = [[UIImageView alloc ] initWithImage:image ] ;
    CGRect frame ;
    if ( IsIOS7 ) {
        frame = CGRectMake(6, 0, image.size.width + 20, 44 );
    }else
        frame = CGRectMake(0, 0, image.size.width +10 , 44 );
    UIView *view = [[UIView alloc]initWithFrame: frame ];
    view.backgroundColor = [UIColor clearColor] ;// COLOR_ORANGE ;//
    view.tag = 990012;

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(6, 0, image.size.width + 20, 44 )] ;
    if ( ! IsIOS7 ) {
        button. frame = CGRectMake(0, 0, image.size.width + 15, 44 ) ;
    }
    [button setImage:image forState:UIControlStateNormal ] ;
    button.showsTouchWhenHighlighted = YES ;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside ] ;
    [view addSubview:button ];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc ]initWithCustomView:view ] ;
    return item ;
    
}


+(UIBarButtonItem *) createNavigationItemText:(NSString *) title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom ] ;
    [button setTitle:title forState:UIControlStateNormal ] ;
    button.showsTouchWhenHighlighted = YES ;

    
    UIBarButtonItem *item = [[UIBarButtonItem alloc ]initWithCustomView:button ] ;
    return item ;
}

+(UIView *) createFlatSegment:(NSMutableArray *)segmentedControlItems selectionBlock:selectionBlock {
    PPiFlatSegmentedControl *segment = [[PPiFlatSegmentedControl alloc]initWithFrame:CGRectMake(0, 6 , 180, 30) items:segmentedControlItems iconPosition:IconPositionRight andSelectionBlock:selectionBlock ];
    segment.backgroundColor = [ UIColor clearColor ] ; //COLOR_ORANGE
    segment.color= [ UIColor clearColor ] ; //COLOR_ORANGE ;
    segment.borderWidth= 1 ;
    segment.borderColor=[UIColor whiteColor];
    segment.selectedColor= [UIColor whiteColor];
    
    if (IsIOS6) {
        segment.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                     NSForegroundColorAttributeName:COLOR_ORANGE};
        segment.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                           NSForegroundColorAttributeName:[UIColor whiteColor]};
    }else{
        segment.selectedTextAttributes = @{ @"NSFontAttributeName":[UIFont systemFontOfSize:15],
                                                      @"NSForegroundColorAttributeName":COLOR_ORANGE };
        segment.textAttributes=@{@"NSFontAttributeName":[UIFont systemFontOfSize:15],
                                           @"NSForegroundColorAttributeName":[UIColor whiteColor]};
    }
    return segment ;
}


@end
