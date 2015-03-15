//
//  DJStarSlider.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-23.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJStarSlider;

@protocol DJSliderDelegate <NSObject>

-(void) slider:(DJStarSlider*)slider didSelectIndex:(NSInteger) index ;

@end

@interface DJStarSlider : UIView{

}

@property ( nonatomic , weak) id<DJSliderDelegate> delegate ;

@property ( nonatomic ) int starCount ;

@property ( nonatomic , strong ) NSMutableArray *stars ;

@property ( nonatomic ) int score ;


@end

@interface DJStarDescriptionView : UIView{
    
    UILabel *label ;
    
}

@property ( nonatomic , strong , setter = setTitle: ) NSString *title ;



@end
