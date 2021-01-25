//
//  UIWindow+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/UIWindow+GLExtension.h>

@implementation UIWindow (GLExtension)
- (UIViewController *)topViewController {
    UIViewController *viewController = self.rootViewController;
    while (viewController.presentedViewController)
        viewController = viewController.presentedViewController;
    return viewController;
}

@end
