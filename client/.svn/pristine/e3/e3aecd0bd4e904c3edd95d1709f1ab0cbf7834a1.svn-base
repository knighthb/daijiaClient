//
//  ImageBuffer.m
//  58DaijiaClient
//
//  Created by huangbin on 14-5-14.
//  Copyright (c) 2014年 58. All rights reserved.
//

#import "ImageBuffer.h"

static NSString * folderName = @"pic";
@implementation ImageBuffer
{
    NSString * cacheFolderDir;
    NSString * cacheRootPath;
}
+(ImageBuffer *) sharedImageBuffer
{
//    @synchronized(self){
        if (sharedImageBuffer==nil) {
            sharedImageBuffer = [[self alloc] init];
        }
//    }
    return sharedImageBuffer;
}

//+(id) allocWithZone:(struct _NSZone *)zone
//{
////    @synchronized(self){
//        if (sharedImageBuffer == nil) {
//            sharedImageBuffer = [[super  alloc] init];
//            return sharedImageBuffer;
//        }
////    }
//    return nil;
//}

-(id) init{
    if (self = [super init]) {
        if (self.buffer==nil) {
            self.buffer = [[NSMutableDictionary alloc] init];
        }
        if (self.chagesDic==nil) {
            self.chagesDic = [[NSMutableDictionary alloc] init];
        }
       cacheRootPath = [self cacheRootPath];
       cacheFolderDir = [self cacheFolderDir:folderName];
    }
    return self;
}

-(void) addToBufferWithKey:(NSString *) key value:(id) value immediatelyWrite:(BOOL) flag{
    id object = [self.buffer objectForKey:key];
    if (object==nil) {
        //buffer中没有则放入到changesDic里面去
        [self.chagesDic setObject:value forKey:key];
        [self.buffer setObject:value forKey:key];
    }else{
        //buffer中有，但是数据不同（如图片被修改），仍然放到changesDic里，并更新buffer，否则不改变
        NSData * imageData = [self imageData:(UIImage *)object WithImageName:key];
        UIImage * localImage = [self readFromBufferWithKey:key path:folderName];
        NSData * localImageData = [self imageData:localImage WithImageName:key];
        if (imageData != localImageData) {
            [self.chagesDic setObject:value forKey:key];
            [self.buffer setObject:value forKey:key];
        }
    }
        if (flag) {
        [self saveToDisk:folderName];
    }else{
        if ([self.chagesDic count]>=10) {
            [self saveToDisk:folderName];
        }
    }
}


//先从buffer里面取
//再从changesDic里面取
//最后从磁盘里面取
//如果都没有取到，丢给用户去处理（如，通过请求从网络获取）
-(UIImage *) readFromBufferWithKey:(NSString *) key path:(NSString *)path{//path暂时先用pic，以后如果有需要可以改回来
    UIImage * image = nil;
    UIImage *  objectFromBuffer = [self.buffer objectForKey:key];
    if ( objectFromBuffer != nil) {
        return objectFromBuffer;
    }else{
        UIImage * objectFromChangesDic = [ self.chagesDic objectForKey:key];
        if (objectFromChangesDic != nil) {
            [self.buffer setObject:objectFromChangesDic forKey:key];
            return objectFromChangesDic;
        }else{
            //有没有通过匹配扩展名（即后缀名）来取对应文件的函数？
            NSArray * fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cacheFolderDir error:nil];
            if (fileList == nil || [fileList count]<=0) {
                return  nil;
            }else{
                for (NSString * fileName in fileList) {
                    if ([key isEqualToString:fileName]) {
                        NSString * imageFilePath = [cacheFolderDir stringByAppendingPathComponent:key];
                        UIImage * imageFromDisk = [UIImage imageWithContentsOfFile:imageFilePath];
                        [self.buffer setObject:imageFromDisk forKey:key];
                        return imageFromDisk;
                    }
                }
            }
        }
    }
    return  image;
}

-(void) clearBuffer{
    //清楚缓存，最好是在receiveMemoryWarning的时候调用一次，也可以自己根据需要调用
    if (self.buffer!=nil) {
        [self.buffer removeAllObjects];
        self.buffer = nil;
    }
    if (self.chagesDic!=nil) {
        [self.chagesDic removeAllObjects];
        self.chagesDic = nil;
    }
}

-(void) saveToDisk:(NSString *) folderName{
//    NSArray * cachePathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * cacheRootPath = [cachePathArray objectAtIndex:0];
    NSFileManager * fileManager = [NSFileManager defaultManager];
//    NSString * cacheFolderDir = [cacheRootPath stringByAppendingPathComponent:folderName];
    BOOL isDir = YES;
    if (![fileManager fileExistsAtPath:cacheFolderDir isDirectory:&isDir]) {
        //没有该目录就直接创建目录
        NSLog(@"创建目录.....");
        BOOL result = [fileManager createDirectoryAtPath:cacheFolderDir withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            NSLog(@"创建目录成功！");
        }else{
            NSLog(@"创建目录失败！");
        }
    }
    
    @try {
        for (NSString * key in [self.chagesDic allKeys] ) {
            id data = [self.chagesDic objectForKey:key];
            NSData * imageData = [self imageData:(UIImage *)data WithImageName:key];
            NSString * imageName = [cacheFolderDir stringByAppendingPathComponent:key];
            [imageData writeToFile:imageName atomically:YES];
        }
        NSLog(@"文件写入成功");
    }
    @catch (NSException *exception) {
        NSLog(@"文件写入失败－》原因：%@",[exception reason]);
    }
    @finally {
        //不管读写失败与否，都把changesDic的数据remove掉，迎接下一次数据写入
        [self.chagesDic removeAllObjects];

    }
    
   NSArray * fileList = [fileManager contentsOfDirectoryAtPath:cacheFolderDir error:nil];
    NSLog(@"fileList number = %d",[fileList count]);
}

-(NSData *) imageData:(UIImage *)image WithImageName:(NSString *) imageName
{
    if (imageName ==nil | image == nil) {
        return nil;
    }
    if ([[imageName pathExtension] isEqualToString:@"jpg"]) {
        //0 for best, 1 for lost
        return UIImageJPEGRepresentation(image, 0);
    }else{
        return UIImagePNGRepresentation(image);
    }
}
-(NSString *)cacheRootPath
{
    NSArray * cachePathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [cachePathArray objectAtIndex:0];
}

-(NSString *) cacheFolderDir:(NSString *) folderName
{
    return [cacheRootPath stringByAppendingPathComponent:folderName];
}


@end
