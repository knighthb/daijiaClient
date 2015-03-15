//
//  DJLoginFactory.h
//  58DaijiaClient
//
//  Created by 周文杰 on 14-5-8.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJLoginFactory : NSObject

+(UIViewController *) newLoginViewControllerWithTitle:(NSString *) title type:(loginType) type delegate:(id) delegate
;


@end
