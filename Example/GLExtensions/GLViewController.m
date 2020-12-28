//
//  GLViewController.m
//  GLExtensions
//
//  Created by liandyii@msn.com on 10/23/2018.
//  Copyright (c) 2018 liandyii@msn.com. All rights reserved.
//

#import "GLViewController.h"
#import <NSString+GLExtension.h>
#import <UIViewController+GLExtension.h>
#import <UIButton+GLExtension.h>

@interface GLViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *checkResultLabel;
@property (weak, nonatomic) IBOutlet UIButton *abutton;
@end

@implementation GLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.checkResultLabel.hidden = YES;
    
    [self.abutton setImage:[UIImage imageNamed:@"InternationalTelephoneCode"] forState:UIControlStateNormal];
//    self.abutton.imagePositionInClock = 12;
}

- (IBAction)onClickCheckText:(id)sender {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    self.checkResultLabel.hidden = NO;
    if(isEmptyString(self.textField.text)) {
        self.checkResultLabel.text = @"这是一个空字符串";
    }else if(isPhoneNumber(self.textField.text)) {
        self.checkResultLabel.text = @"这是一个手机号";
    } else if(isEMail(self.textField.text)) {
        self.checkResultLabel.text = @"这是一个邮箱";
    } else {
        self.checkResultLabel.text = @"验证失败";
    }
#pragma clang diagnostic pop
}

- (IBAction)onClickToast:(id)sender {
    showToastMsgWithMoreProps(@"你好，我是居中红色背景", [UIColor yellowColor], self.view.center, [UIColor redColor]);
}


@end
