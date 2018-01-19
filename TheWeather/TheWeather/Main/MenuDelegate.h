//
//  SnailApplePayDelegate.h
//  SgComPlatform
//
//  Created by Snail Ark on 16/3/3.
//  Copyright © 2016年 snailgame. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenusDelegate <NSObject>

- (void)openMenuViewController;
- (void)closeMenuController;
- (void)cityWeatherCallBack:(NSString *)cityname;


@end
