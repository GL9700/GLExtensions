//
//  UIAlertController+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (GLExtension)

/// Alert ** 单按钮 **
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)msg
                  singleButton:(NSString *)btnTitle
                         event:(void(^)(void))eventBLK;

/// Alert ** 多按钮 **
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)msg
                  buttonTitles:(NSArray<NSString *> *)btnTitles
                         event:(void(^)(NSUInteger index))eventBLK;

/// Alert Show **
- (void)show;
- (void)dismiss;
- (void)showAfterAutoDismissSec:(NSUInteger)sec withComplete:(void(^)(void))complete;

/// Toast ** 2秒后自动关闭 **
+ (void)showToastWithMessage:(NSString *)msg;
+ (void)showToastWithMessage:(NSString *)msg withPoint:(CGPoint)center;
+ (void)showToastWithMessage:(NSString *)msg withPoint:(CGPoint)center textColor:(UIColor *)tcolor backgroundColor:(UIColor *)color;

/// Status Toast(默认模态)
/// @param contentText 文字内容。如果nil，则其他内容居中
/// @param contentImg 图像内容。如果nil，则其他内容居中
/// @param color 背景颜色（透明度需要在颜色中设置）
/// @param size 整体尺寸
+ (void)showStatusToastWithTitle:(NSString *)contentText Image:(UIImage *)contentImg backgroundColor:(UIColor *)color size:(CGSize)size;

/// Status Toast(默认模态)
/// @param contentText 文字内容。如果nil，则其他内容居中
/// @param progress 进度指示。如果nil，则其他内容居中
/// @param color 背景颜色（透明度需要在颜色中设置）
/// @param size 整体尺寸
+ (void)showStatusToastWithTitle:(NSString *)contentText Progress:(NSProgress *)progress backgroundColor:(UIColor *)color size:(CGSize)size;

@end
