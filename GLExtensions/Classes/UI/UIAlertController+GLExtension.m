//
//  UIAlertController+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/UIAlertController+GLExtension.h>
#import <GLExtensions/UIWindow+GLExtension.h>

#define kToastPointDefault CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 4 * 3)

GLToastOptionsName kToastOptionPointCenter = @"kToastOptionPointCenter";			// CGPoint
GLToastOptionsName kToastOptionBackgroundColor = @"kToastOptionBackgroundColor";		// UIColor
GLToastOptionsName kToastOptionTextFont = @"kToastOptionTextFont";			// UIFont
GLToastOptionsName kToastOptionTextColor = @"kToastOptionTextColor";			// UIColor
GLToastOptionsName kToastOptionKeepTimeSeconds = @"kToastOptionKeepTimeSeconds";	// CGFloat

@interface ToastView : UIView
@property (nonatomic) CGPoint cenpoint;
@property (nonatomic) UIColor *fontColor;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UILabel *textLabel;
@property (nonatomic) CGFloat keepTime;
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
    self.textLabel.frame = CGRectInset(self.textLabel.frame, -10, -8);
    self.textLabel.layer.cornerRadius = _textLabel.frame.size.height <= 40 ? _textLabel.frame.size.height/2 : 20;
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

- (CGFloat)keepTime {
	if (_keepTime == 0) {
		_keepTime = 2.5;
	}
	return _keepTime;
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
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion: ^{
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
	[self showToastWithMessage:format valist:list options:nil];
}

+ (void)showToastWithMessage:(NSString *)format valist:(va_list)list options:(NSDictionary<GLToastOptionsName, id> *)options {
	NSString *msg = format;
	if(list != NULL) {
		msg = [[NSString alloc] initWithFormat:format arguments:list];
		dispatch_async(dispatch_get_main_queue(), ^{
			ToastView *toast = [[ToastView alloc] initWithMessage:msg];
			toast.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
			toast.fontColor = [UIColor whiteColor];
			if(options) {
				if([options[kToastOptionTextFont] isKindOfClass:[UIFont class]]) {
					toast.textLabel.font = options[kToastOptionTextFont];
				}
				
				if([options[kToastOptionBackgroundColor] isKindOfClass:[UIColor class]]) {
					toast.backgroundColor = options[kToastOptionBackgroundColor];
				}
				
				if([options[kToastOptionTextColor] isKindOfClass:[UIColor class]]) {
					toast.fontColor = options[kToastOptionTextColor];
				}
				
				if(options[kToastOptionPointCenter]) {
					toast.cenpoint = [options[kToastOptionPointCenter] CGPointValue];
				}
				
				if([options[kToastOptionKeepTimeSeconds] floatValue]>0) {
					toast.keepTime = [options[kToastOptionKeepTimeSeconds] floatValue];
				}
			}
			[self showToast:toast inQueue:YES];
		});
	}
}

+ (void)showToast:(ToastView *)toast {
    toast.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
    [UIView animateWithDuration:0.25 animations: ^{
        toast.alpha = 1;
        toast.frame = CGRectOffset(toast.frame, 0, 5);
    } completion: ^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(toast.keepTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations: ^{
                toast.alpha = 0;
                toast.frame = CGRectOffset(toast.frame, 0, -5);
            } completion: ^(BOOL finished) {
                toast.superview ? [toast removeFromSuperview] : nil;
                [toastList containsObject:toast] ? [toastList removeObject:toast] : nil;
            }];
        });
    }];
}
+ (void)showToast:(ToastView *)toast inQueue:(BOOL)queue {
    toastList = toastList==nil ? [NSMutableArray array] : toastList;
    if(toastList.count==0){
        if(CGPointEqualToPoint(toast.cenpoint, CGPointZero)){
            toast.cenpoint = kToastPointDefault;
        }
    }else{
        toast.cenpoint = CGPointMake(toastList.firstObject.center.x, CGRectGetMinY(toastList.firstObject.frame)- CGRectGetHeight(toast.frame)/2-10);
        if(CGRectGetMinY(toast.frame)<0) {
            toast.cenpoint = kToastPointDefault;
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
