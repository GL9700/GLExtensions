//
//  GLTimerViewController.m
//  GLExtensions_Example
//
//  Created by 李国梁 on 2020/11/20.
//  Copyright © 2020 36617161@qq.com. All rights reserved.
//

#import "GLTimerViewController.h"

@interface GLTimerViewController ()
@property (nonatomic) NSTimer *t1;
@end

@implementation GLTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)onClickTimer_1:(UIButton *)sender {
    sender.enabled = NO;
    self.t1 = [NSTimer startWithCountSecond:30 split:30 withBlock:^(NSUInteger segmentIndex, NSUInteger countdown) {
        if(countdown == 0) {
            [sender setTitle:@"重新开始" forState:UIControlStateNormal];
            sender.enabled = YES;
        }else{
            [sender setTitle:[NSString stringWithFormat:@"%lu-%lu", (unsigned long)segmentIndex, (unsigned long)countdown] forState:UIControlStateNormal];
        }
    }];
}
- (IBAction)onClickTimer_2:(UIButton *)sender {
    [NSTimer startWithCountSecond:30 split:10 withBlock:^(NSUInteger segmentIndex, NSUInteger countdown) {
        if(countdown == 0) {
            [sender setTitle:@"重新开始" forState:UIControlStateNormal];
            sender.enabled = YES;
        }else{
            [sender setTitle:[NSString stringWithFormat:@"%lu-%lu", (unsigned long)segmentIndex, (unsigned long)countdown] forState:UIControlStateNormal];
        }
    }];
}
- (void)dealloc {
    [NSTimer stopTimer:self.t1];
    NSLog(@"--- dealloc ---");
}
@end
