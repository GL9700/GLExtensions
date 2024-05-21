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
UIKIT_STATIC_INLINE void hideActivity(void)
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
UIKIT_STATIC_INLINE void showToastMsg(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    [UIAlertController showToastWithMessage:format valist:args];
    va_end(args);
}

/// Toast 自定义
UIKIT_STATIC_INLINE void showToastMsgAtPoint(NSString *msg, CGPoint point) {
    [UIAlertController showToastWithMessage:msg withPoint:point];
}

/// 居中
UIKIT_STATIC_INLINE void showToastMsgAtCenter(NSString *msg) {
    [UIAlertController showToastWithMessage:msg withPoint:CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2)];
}

UIKIT_STATIC_INLINE void showToastMsgWithMoreProps(NSString *msg, UIColor *textColor, CGPoint point, UIColor *bgcolor) {
    [UIAlertController showToastWithMessage:msg
                                  withPoint:point
                                  textColor:textColor
                            backgroundColor:bgcolor];
}

@interface UIViewController (GLExtension)
@end

@interface UIViewController(GLExtPresent)<UIViewControllerTransitioningDelegate>

/// [非必需]重写get方法生效 [0、>=main_screen_height、不重写 : 均为全屏]
@property (nonatomic, readonly) CGFloat pHeight;

/// [非必需]当需要自定义动画的时候，需要在在presentingViewController中重写，并返回正确的AnimatedTransitioningViewController
@property (nonatomic, readonly) id<UIViewControllerAnimatedTransitioning> transitioningViewController;

/// 可控高度弹出ViewController
/// - Parameters:
///   - vc: 弹出ViewController
///   - overScreen: Yes:UIModalPresentationOverFullScreen | No:UIModalPresentationFullScreen
///   - animated: 动画
///   - completion: 完成后回调
- (void)presentViewController:(UIViewController *)vc isOverScreen:(BOOL)overScreen animated:(BOOL)animated completion:(void (^)(void))completion;
@end

@interface UIViewController (GLExtanimatedTransitioning)<UIViewControllerAnimatedTransitioning>
@end
