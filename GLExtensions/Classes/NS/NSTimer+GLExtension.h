//
//  NSTimer+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GLExtension)

/// 计时器-间隔-无限循环
/// @param interval 间隔
/// @param repeat 无限循环
/// @param block 执行内容
+ (NSTimer *)startWithTimeInterval:(NSTimeInterval)interval repeat:(BOOL)repeat withBlock:(void (^)(void))block;

/// 计时器-分段-结束
/// @param second 总时长
/// @param count 把总时长分成几份
/// @param block 每份结束的时候进行的操作，通过countdown进行份数倒计从N->0, segmentIndex正计数从0->N
+ (NSTimer *)startWithCountSecond:(NSTimeInterval)second split:(NSUInteger)count withBlock:(void(^)(NSUInteger segmentIndex, NSUInteger countdown))block;

/// 结束计时器
/// @param timer 计时器指针
+ (void)stopTime:(NSTimer *)timer;

@end
