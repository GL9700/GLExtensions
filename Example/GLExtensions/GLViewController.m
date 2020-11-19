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



@interface GLViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *checkResultLabel;

@end

@implementation GLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.checkResultLabel.hidden = YES;
}

- (IBAction)onClickCheckText:(id)sender {
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
}

- (IBAction)onClickToast:(id)sender {
    showToastMsgWithCenterPoint(@"你好，我是居中的", self.view.center);
}


@end
