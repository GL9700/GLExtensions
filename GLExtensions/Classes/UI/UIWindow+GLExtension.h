//
//  UIWindow+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (GLExtension)
/// 获取最上层显示的ViewController
- (UIViewController *)topViewController;
@end
