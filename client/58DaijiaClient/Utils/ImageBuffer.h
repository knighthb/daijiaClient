//
//  ImageBuffer.h
//  58DaijiaClient
//
//  Created by huangbin on 14-5-14.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageBuffer;
static ImageBuffer * sharedImageBuffer = nil;
@interface ImageBuffer : NSObject
@property (nonatomic, strong) NSMutableDictionary * buffer;
@property (nonatomic, strong) NSMutableDictionary * chagesDic;

+(ImageBuffer *) sharedImageBuffer;

-(void) clearBuffer;

/**
 * 把数据以kv形式放入缓存中，如果flag设置为YES，则会立即存入磁盘，如果设置为NO，只有等chagesDic中数据满10个时才会写磁盘
 */
-(void) addToBufferWithKey:(NSString *) key value:(id) value immediatelyWrite:(BOOL) flag;

-(UIImage *) readFromBufferWithKey:(NSString *) key path:(NSString *) path;

-(void) saveToDiskPath:(NSString *) folderName ;

-(void) readFromDiskWithName:(NSString *) name;
@end
