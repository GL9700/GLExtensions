//
//  UIAlertController+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/UIAlertController+GLExtension.h>
#import <GLExtensions/UIWindow+GLExtension.h>

#define kToastShowTime 2.5
#define kToastPointDefault CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 4 * 3)



@interface ToastView : UIView
@property (nonatomic) BOOL inAnimate;
@property (nonatomic) CGPoint cenpoint;
@property (nonatomic) UIColor *fontColor;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UILabel *textLabel;
- (instancetype)initWithMessage:(NSString *)msg;
@end

@implementation ToastView
- (instancetype)initWithMessage:(NSString *)msg {
    if((self = [super init])) {
        [self setToastMessage:msg];
        [self addSubview:self.textLabel];
    }
    return self;
}
- (void)setToastMessage:(NSString *)msg {
    self.textLabel.text = msg;
    [self.textLabel sizeToFit];
    self.textLabel.layer.cornerRadius = 8;
    self.textLabel.frame = CGRectInset(self.textLabel.frame, -10, -8);
    self.textLabel.frame = CGRectOffset(self.textLabel.frame, 10, 8);
    self.frame = self.textLabel.frame;
}
- (void)setFontColor:(UIColor *)fontColor {
    _fontColor = fontColor;
    self.textLabel.textColor = fontColor;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.textLabel.backgroundColor = backgroundColor;
}
- (void)setCenpoint:(CGPoint)cenpoint {
    _cenpoint = cenpoint;
    self.center = cenpoint;
}
- (UILabel *)textLabel {
    if(!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 5 * 4, 0);
        _textLabel.layer.masksToBounds = YES;
    }
    return _textLabel;
}
@end


static NSMutableArray<ToastView *> *toastList;

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
    UIViewController *root = [[UIApplication sharedApplication].keyWindow topViewController];
    [root presentViewController:self animated:YES completion: ^{
        if (sec > 0) {
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

+ (void)showToastWithMessage:(NSString *)format valist:(va_list)list {
    NSString *msg = format;
    if(list != NULL) {
        msg = [[NSString alloc] initWithFormat:format arguments:list];
    }
    [self showToastWithMessage:msg withPoint:CGPointZero];
}

+ (void)showToastWithMessage:(NSString *)msg withPoint:(CGPoint)point {
    [self showToastWithMessage:msg withPoint:point textColor:nil backgroundColor:nil];
}

+ (void)showToastWithMessage:(NSString *)msg withPoint:(CGPoint)point textColor:(UIColor *)tcolor backgroundColor:(UIColor *)color {
    dispatch_async(dispatch_get_main_queue(), ^{
        ToastView *toast = [[ToastView alloc] initWithMessage:msg];
        toast.fontColor = tcolor ? : [UIColor whiteColor];
        toast.backgroundColor = color ? : [UIColor colorWithWhite:0 alpha:.6];
        toast.cenpoint = point;
        [self showToast:toast inQueue:YES];
    });
}

+ (void)dismissToast:(ToastView *)toast {
    toast.inAnimate = YES;
    if(toast){
        [UIView animateWithDuration:0.25 animations: ^{
            toast.alpha = 0;
        } completion: ^(BOOL finished) {
            toast.superview ? [toast removeFromSuperview] : nil;
            [toastList containsObject:toast] ? [toastList removeObject:toast] : nil;
        }];
    }
}

+ (void)showToast:(ToastView *)toast {
    toast.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
    [UIView animateWithDuration:0.25 animations: ^{
        toast.alpha = 1;
    } completion: ^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kToastShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(toast.inAnimate == NO) {
                [self dismissToast:toast];
            }
        });
    }];
}
+ (void)showToast:(ToastView *)toast inQueue:(BOOL)queue {
    toastList = toastList==nil ? [NSMutableArray array] : toastList;
    if(CGPointEqualToPoint(toast.cenpoint, CGPointZero)){
        toast.cenpoint = kToastPointDefault;
    }
    if(CGRectGetMinY(toast.frame)<0) {
        toast.cenpoint = kToastPointDefault;
    }
    if(toastList.count>0) {
        for(int i=0; i<toastList.count; i++){
            ToastView *t = toastList[i];
            if(i>1){
                if(t.inAnimate == NO) {
                    [self dismissToast:t];
                }
                continue;
            }
            [UIView animateWithDuration:0.25 animations:^{
                t.cenpoint = CGPointMake(t.center.x, t.cenpoint.y-CGRectGetHeight(toast.frame)/1.2-10);
            }];
        }
    }
    [toastList insertObject:toast atIndex:0];
    [self showToast:toastList.firstObject];
}

+ (void)showStatusToastWithTitle:(NSString *)contentText Image:(UIImage *)contentImg backgroundColor:(UIColor *)color size:(CGSize)size {
}

+ (void)showStatusToastWithTitle:(NSString *)contentText Progress:(NSProgress *)progress backgroundColor:(UIColor *)color size:(CGSize)size {
}

@end
