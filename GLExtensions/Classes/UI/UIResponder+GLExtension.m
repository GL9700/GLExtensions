//
//  UIResponder+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/UIResponder+GLExtension.h>

@implementation UIResponder (GLExtension)

- (void)sendEvent:(id)event from:(UIResponder *)from param:(id)param {
    [self.nextResponder sendEvent:event from:from param:param];
}

@end
