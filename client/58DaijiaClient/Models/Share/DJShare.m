//
//  DJShareContent.m
//  58DaijiaClient
//
//  Created by 周文杰 on 14-4-15.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "DJShare.h"

@implementation DJShare

@synthesize timelineShare , friendsShare , qqShare , sinaShare , ads , url , title , activty_id , image , check_login ;


-(id) init{
    self = [super init ] ;
    if( self ){
        ads = [[NSMutableArray alloc ] init ] ;
        timelineShare = [[DJShareObject alloc ] init ] ;
        friendsShare = [[DJShareObject alloc ] init ] ;
        qqShare = [[DJShareObject alloc ] init ] ;
        sinaShare = [[DJShareObject alloc ] init ] ;
    }
    return self ;
}


-(void ) deserialize:(NSMutableDictionary *) dict {
    
    
    check_login = [[dict objectForKey:@"check_login" ] boolValue ] ;
    
    NSDictionary *wxDic = [dict objectForKey:@"weixin" ] ;//微信好友
    [friendsShare deserialize:wxDic ] ;
   
    NSDictionary *friendsDic = [dict objectForKey:@"friends" ] ; //朋友圈
    [timelineShare  deserialize:friendsDic ] ;

    NSDictionary *qqDic = [dict objectForKey:@"qq" ] ;

    [qqShare deserialize:qqDic ] ;
    
    NSDictionary *sinaDic = [dict objectForKey:@"weibo" ] ;
    [sinaShare deserialize:sinaDic] ;

    url = [dict objectForKey:@"url" ] ;
    
    title = [dict objectForKey:@"title" ] ;
    
    activty_id = [dict objectForKey:@"58_activity_id" ] ;
    
    image = [dict objectForKey:@"image" ] ;
    
    NSArray *adsAry = [dict objectForKey:@"ad" ] ;
    
    [ads removeAllObjects ] ;
    for ( NSDictionary *iDict in  adsAry ) {
        
        DJAdObject *ad = [[DJAdObject alloc ] init ] ;
        [ad deserialize:iDict ] ;
        [ads addObject: ad ] ;
        
    }
    
    
}



@end
