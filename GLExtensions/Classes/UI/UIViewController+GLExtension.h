//
//  UIViewController+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLExtensions/UIView+GLExtension.h>
#import <GLExtensions/UIAlertController+GLExtension.h>

/// 隐藏已经显示的Activity
UIKIT_STATIC_INLINE void hideActivity()
{
    UIView *actView = [UIView defaultViewForActivityWithFrame:CGRectZero];
    if (actView.superview) {
        [actView removeFromSuperview];
    }
    if([actView respondsToSelector:@selector(hideActivity)]) {
        [actView hideActivity];
    }
}

/// 显示单例Activity
UIKIT_STATIC_INLINE void showActivity(id vc)
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    if ([vc isKindOfClass:[UIViewController class]]) view = ((UIViewController *)vc).view;
    UIView *actView = [UIView defaultViewForActivityWithFrame:view.bounds];
    if([actView respondsToSelector:@selector(showActivity)]) {
        [actView showActivity];
    }
    if (actView.superview) {
        [actView removeFromSuperview];
    }
    [view addSubview:actView];
}

/// 自定义Activity
UIKIT_STATIC_INLINE void showActivityWithCustom(id vc)
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    if ([vc isKindOfClass:[UIViewController class]]) view = ((UIViewController *)vc).view;
    UIView *actView = [UIView defaultViewForActivityWithFrame:view.bounds];
    if([actView respondsToSelector:@selector(showActivity)]) {
        [actView showActivity];
    }
    if (actView.superview) {
        [actView removeFromSuperview];
    }
    [view addSubview:actView];
}


/// Toast
UIKIT_STATIC_INLINE void showToastMsg(NSString *msg)
{
    [UIAlertController showToastWithMessage:msg];
}

/// Toast 自定义显示位置
UIKIT_STATIC_INLINE void showToastMsgWithCenterPoint(NSString *msg, CGPoint point)
{
    [UIAlertController showToastWithMessage:msg withPoint:point];
}

UIKIT_STATIC_INLINE void showToastMsgWithMoreProps(NSString *msg, UIColor *textColor, CGPoint point, UIColor *bgcolor)
{
    [UIAlertController showToastWithMessage:msg
                                  withPoint:point
                                  textColor:textColor
                            backgroundColor:bgcolor];
}

@interface UIViewController (GLExtension)

@end
