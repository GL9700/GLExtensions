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
    UIViewController *root = self.rootViewController;
    BOOL done = YES;
    while (done) {
        if([root isKindOfClass:[UINavigationController class]]) {
            root = [(UINavigationController *)root topViewController];
        } else if([root isKindOfClass:[UITabBarController class]]) {
            root = [(UITabBarController *)root selectedViewController];
        } else if(root.presentedViewController) {
            root = root.presentedViewController;
        } else {
            done = NO;
        }
    }
    return root;
}

@end
