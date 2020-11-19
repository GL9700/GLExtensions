//
//  NSTimer+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/NSTimer+GLExtension.h>

@implementation NSTimer (GLExtension)

+ (NSTimer *)startWithCountSecond:(NSTimeInterval)second split:(NSUInteger)count withBlock:(void(^)(NSUInteger segmentIndex, NSUInteger countdown))block {
    NSTimeInterval segmentSecond = second/count;
    __block NSUInteger index = 0;
    NSTimer *_t;
    if (@available(iOS 10.0, *)) {
        _t = [self timerWithTimeInterval:segmentSecond repeats:YES block:^(NSTimer * _Nonnull timer) {
            index++;
            if(block && index<=count){
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(index, count-index);
                    NSLog(@">> 计时中 index:%lu", (unsigned long)index);
                });
            }
        }];
        [[NSRunLoop currentRunLoop] addTimer:_t forMode:NSRunLoopCommonModes];
    }else {
        _t = [self startWithTimeInterval:segmentSecond repeat:YES withBlock:nil];
    }
    return _t;
}

+ (NSTimer *)startWithTimeInterval:(NSTimeInterval)interval repeat:(BOOL)repeat withBlock:(void (^)(void))block {
    NSTimer *_t = [self timerWithTimeInterval:interval
                                       target:self
                                     selector:@selector(setBlock:)
                                     userInfo:[block copy]
                                      repeats:repeat];
    [[NSRunLoop currentRunLoop] addTimer:_t forMode:NSRunLoopCommonModes];
    return _t;
}

+ (void)setBlock:(NSTimer *)timer {
    void (^ blk)(void) = timer.userInfo;
    if (blk) {
        blk();
    }
}

+ (void)stopTime:(NSTimer *)timer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}
@end
