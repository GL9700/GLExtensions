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
NS_INLINE void hideActivity()
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
NS_INLINE void showActivity(id vc)
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
NS_INLINE void showActivityWithCustom(id vc)
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
NS_INLINE void showToastMsg(NSString *format, ...) {
	va_list args;
	va_start(args, format);
	[UIAlertController showToastWithMessage:format valist:args];
	va_end(args);
}

NS_INLINE void showToastMsgWithOptions(NSDictionary<GLToastOptionsName, id> *options, NSString *format, ...) {
	va_list args;
	va_start(args, format);
	[UIAlertController showToastWithMessage:format valist:args options:options];
	va_end(args);
}
@interface UIViewController (GLExtension)

@end
