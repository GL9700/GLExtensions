//
//  UIResponder+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GLExtension)

/** 发送消息给自己的父视图 */
- (void)sendEvent:(id)event from:(UIResponder *)from param:(id)param;

@end
