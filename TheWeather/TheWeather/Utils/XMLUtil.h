//
//  XMLUtil.h
//  TheWeather
//
//  Created by shenjie on 2018/1/18.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^bingImageBlock)(NSString *imageName);

@interface XMLUtil : NSObject<NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *par;
@property (nonatomic, copy) NSString *currentElement;
@property (nonatomic, strong) bingImageBlock mBlock;

-(void)parse:(NSData *)data block:(bingImageBlock)_block;;

@end
