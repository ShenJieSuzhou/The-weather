//
//  FileUtil.m
//  TheWeather
//
//  Created by shenjie on 2018/1/22.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

//传入一个文件名获得其路径
+ (NSString *) getFilePath:(NSString *) fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
}

+ (BOOL)createFile:(NSString *)fileName{
    BOOL success;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:fileName];
    NSFileManager* fm = [NSFileManager defaultManager];
    success = [fm fileExistsAtPath:filename];
    if (success) return YES;
    
    if(![fm createFileAtPath:filename contents:nil attributes:nil]){
        NSLog(@"创建文件失败");
        return NO;
    }
    
    return YES;
}

+ (BOOL) fileISExist:(NSString *)filename{
    NSFileManager *nsmaager = [NSFileManager defaultManager];
    return [nsmaager fileExistsAtPath:[self getFilePath:filename]];
}

@end
