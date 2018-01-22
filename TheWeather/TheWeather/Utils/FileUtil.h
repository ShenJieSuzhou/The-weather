//
//  FileUtil.h
//  TheWeather
//
//  Created by shenjie on 2018/1/22.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

//获取文件路径(沙盒)
+ (NSString *) getFilePath:(NSString *) fileName;

+ (BOOL)createFile:(NSString *)fileName;

//文件是否存在
+ (BOOL) fileISExist:(NSString *) filename;

@end
