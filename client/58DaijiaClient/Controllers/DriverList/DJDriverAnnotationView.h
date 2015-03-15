//
//  DJDriverAnnotationView.h
//  58DaijiaClient
//
//  Created by huangbin on 14-4-17.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DJDriverAnnotationView : MKAnnotationView

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIView * cell;

@end
