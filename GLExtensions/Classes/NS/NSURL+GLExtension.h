//
//  NSURL+GLExtension.h
//  GLExtensions
//
//  Created by liguoliang on 2018/9/10.
//

#import <Foundation/Foundation.h>

@interface NSURL (GLExtension)

/** 获取参数部分 */
- (NSDictionary *)querys;

/** 获取 IP 地址 */
- (NSArray *)IPAdress;
@end
