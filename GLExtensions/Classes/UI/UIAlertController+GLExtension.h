//
//  UIAlertController+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString* const GLToastOptionsName NS_STRING_ENUM;
UIKIT_EXTERN GLToastOptionsName kToastOptionPointCenter;			// CGPoint
UIKIT_EXTERN GLToastOptionsName kToastOptionBackgroundColor;		// UIColor
UIKIT_EXTERN GLToastOptionsName kToastOptionTextFont;			// UIFont
UIKIT_EXTERN GLToastOptionsName kToastOptionTextColor;			// UIColor
UIKIT_EXTERN GLToastOptionsName kToastOptionKeepTimeSeconds;		// CGFloat

@interface UIAlertController (GLExtension)


/// Alert ** 单按钮 **
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg singleButton:(NSString *)btnTitle event:(void(^)(void))eventBLK;

/// Alert ** 多按钮 **
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg buttonTitles:(NSArray<NSString *> *)btnTitles event:(void(^)(NSUInteger index))eventBLK;

/// Alert Show **
- (void)show;
- (void)dismiss;
- (void)showAfterAutoDismissSec:(NSUInteger)sec withComplete:(void(^)(void))complete;


/// 显示Toast ** 位置:3/4, 时间:2.5秒 **
+ (void)showToastWithMessage:(NSString *)format valist:(va_list)list;

/// 显示Toast **默认 位置:3/4, 时间:2.5秒 **
/// @param format string format
/// @param list string list
/// @param options @linkAlias GLToastOptionsName
+ (void)showToastWithMessage:(NSString *)format valist:(va_list)list options:(NSDictionary<GLToastOptionsName, id> *)options;

@end
