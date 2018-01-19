//
//  ConstantIndex.h
//  TheWeather
//
//  Created by shenjie on 2018/1/16.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstantIndex : NSObject

@property (strong, nonatomic) NSString *todayWeather;
@property (strong, nonatomic) NSString *tommorrowWeather;
@property (strong, nonatomic) NSString *todayRange;
@property (strong, nonatomic) NSString *tommorrowRange;
@property (strong, nonatomic) NSString *todayIcon;
@property (strong, nonatomic) NSString *tommorrowIcon;
@property (assign) BOOL locationFlag;

+ (ConstantIndex *)getInstance;
@end
