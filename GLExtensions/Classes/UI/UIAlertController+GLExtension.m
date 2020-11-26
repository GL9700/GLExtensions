//
//  UIAlertController+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/UIAlertController+GLExtension.h>

#define kToastShowTime 2

@implementation UIAlertController (GLExtension)

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg singleButton:(NSString *)btnTitle event:(void (^)(void))eventBLK {
    UIAlertController *instance = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (btnTitle != nil) {
        [instance addAction:[UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler: ^(UIAlertAction *_Nonnull action) {
            if (eventBLK != nil) eventBLK();
        }]];
    }
    return instance;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg buttonTitles:(NSArray<NSString *> *)btnTitles event:(void (^)(NSUInteger index))eventBLK {
    UIAlertController *instance = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (btnTitles != nil) {
        for (int i = 0; i < btnTitles.count; i++) {
            UIAlertAction *act = [UIAlertAction actionWithTitle:btnTitles[i] style:UIAlertActionStyleDefault handler: ^(UIAlertAction *_Nonnull action) {
                if (eventBLK != nil) eventBLK(i);
            }];
            [instance addAction:act];
        }
    }
    return instance;
}

- (void)show {
    if (self.view.superview == nil) {
        [self showAfterAutoDismissSec:0 withComplete:nil];
    }
}

- (void)dismiss {
    if (self.view.superview) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showAfterAutoDismissSec:(NSUInteger)sec withComplete:(void (^)(void))complete {
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion: ^{
        if (sec > 0) {
            /*
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep((int)sec);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.view.superview) {
                        [self dismissViewControllerAnimated:YES completion:^{
                            if(complete)
                                complete();
                        }];
                    }
                });
            });
             */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                               if (self.view.superview) {
                                   [self dismissViewControllerAnimated:YES completion: ^{
                                       if (complete) complete();
                                   }];
                               }
                           });
        }
    }];
}


+ (void)showToastWithMessage:(NSString *)msg withPoint:(CGPoint)center textColor:(UIColor *)tcolor backgroundColor:(UIColor *)color {
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = msg;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = tcolor;
        label.backgroundColor = color;
        label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 5 * 4, 0);
        [label sizeToFit];
        label.center = center;
        label.frame = CGRectInset(label.frame, -10, -8);
        label.layer.cornerRadius = label.frame.size.height / 2;
        label.layer.masksToBounds = YES;
        label.alpha = 0;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:label];
        [UIView animateWithDuration:0.25 animations: ^{
            label.alpha = 1;
            label.frame = CGRectOffset(label.frame, 0, 5);
        } completion: ^(BOOL finished) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                               sleep(kToastShowTime);
                               dispatch_async(dispatch_get_main_queue(), ^{
                                                  [UIView animateWithDuration:0.25 animations: ^{
                                                      label.alpha = 0;
                                                      label.frame = CGRectOffset(label.frame, 0, -5);
                                                  } completion: ^(BOOL finished) {
                                                      if (label.superview) {
                                                          [label removeFromSuperview];
                                                      }
                                                  }];
                                              });
                           });
        }];
    });
}

+ (void)showToastWithMessage:(NSString *)msg withPoint:(CGPoint)center {
    [self showToastWithMessage:msg
                     withPoint:center
                     textColor:[UIColor whiteColor]
               backgroundColor:[UIColor colorWithWhite:0 alpha:.6]];
}
+ (void)showToastWithMessage:(NSString *)msg {
    [self showToastWithMessage:msg withPoint:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 4 * 3)];
}

+ (void)showStatusToastWithTitle:(NSString *)contentText Image:(UIImage *)contentImg backgroundColor:(UIColor *)color size:(CGSize)size {
    
}

+ (void)showStatusToastWithTitle:(NSString *)contentText Progress:(NSProgress *)progress backgroundColor:(UIColor *)color size:(CGSize)size {
    
}
@end
