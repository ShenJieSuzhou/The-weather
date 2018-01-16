//
//  ConstantIndex.m
//  TheWeather
//
//  Created by shenjie on 2018/1/16.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "ConstantIndex.h"

@implementation ConstantIndex

+ (ConstantIndex *)getInstance{
    static ConstantIndex *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [ConstantIndex new];
    });
    
    return _instance;
}

@end
