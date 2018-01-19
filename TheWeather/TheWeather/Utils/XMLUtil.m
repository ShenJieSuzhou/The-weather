//
//  XMLUtil.m
//  TheWeather
//
//  Created by shenjie on 2018/1/18.
//  Copyright © 2018年 com.snailgames. All rights reserved.
//

#import "XMLUtil.h"

@implementation XMLUtil
@synthesize par = _par;
@synthesize currentElement = _currentElement;

//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}

//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    self.currentElement = elementName;
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([self.currentElement isEqualToString:@"urlBase"]){
        NSLog(@"%@", string);
        _mBlock(string);
    }
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    if ([elementName isEqualToString:@"urlBase"]) {
        
    }
    self.currentElement = nil;

}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}

//外部调用接口
//-(void)parse:(NSData *)data {
//    self.par = [[NSXMLParser alloc] initWithData:data];
//    self.par.delegate = self;
//    [self.par parse];
//}
- (void)parse:(NSData *)data block:(bingImageBlock)_block{
    _mBlock = _block;
    self.par = [[NSXMLParser alloc] initWithData:data];
    self.par.delegate = self;
    [self.par parse];
}
@end
