//
//  GLViewController.m
//  GLExtensions
//
//  Created by 36617161@qq.com on 10/23/2018.
//  Copyright (c) 2018 36617161@qq.com. All rights reserved.
//

#import "GLViewController.h"
#import <NSString+GLExtension.h>
#import <UIViewController+GLExtension.h>
#import <UIButton+GLExtension.h>
#import <UIColor+GLExtension.h>
#import <GLExtensions/GLExtReachability.h>

#import "GLEmptyViewController.h"

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
	NSInteger tempstamp = [[NSDate date] timeIntervalSince1970];
	BOOL isDoubleSecond = tempstamp%2==1;
//	showToastMsgWithOptions(@{
//		kToastOptionTextColor:isDoubleSecond ? [UIColor greenColor] : [UIColor redColor],
//		kToastOptionKeepTimeSeconds:@(arc4random()%5)
//	}, @"现在是单数秒?...%@ (%lu)\n随机时间后消失", isDoubleSecond?@" ✅":@" ❌" , tempstamp);
	
	
	
//    showToastMsgWithMoreProps(@"你好，我是居中红色背景", [UIColor yellowColor], self.view.center, [UIColor randomColor]);
//    可使用异步线程来获取同步显示
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.navigationController pushViewController:[GLEmptyViewController new] animated:YES];
//        [self.navigationController presentViewController:[GLEmptyViewController new] animated:YES completion:nil];
//    });
}

- (IBAction)onClickNormalToast:(UIButton *)sender {
    showToastMsg(@"正常的Toast ? ", [NSError errorWithDomain:@"aaa" code:123 userInfo:@{@"url":@"123"}]);
//    showToastMsgWithMoreProps([NSString stringWithFormat:@"%@", [self randomWord]], [UIColor yellowColor], CGPointZero, [UIColor randomColor]);
}

- (NSString *)randomWord {
    NSArray *array = @[
        @"1. add up 合计",
        @"2. upset [vt&vi] 弄翻，使…不安，使心烦，扰乱\nadj. 心烦意乱的，不舒服的，不适的，难过的。",
        @"3. ignore 不理睬、忽视",
        @"4. calm (使)平静、(使)镇定\ncalm down 平静/镇定下来",
        @"5. have got to 不得不、必须",
        @"6. concern (使)担忧、涉及、关系到\nbe concerned about…关心，挂念",
        @"7. go through 经历、经受",
        @"8. set down 记下、放下、登记",
        @"9. a series of 一系列",
        @"10. on purpose 故意",
        @"11. in order to 为了……",
        @"12. at dusk 在黄昏时刻",
        @"13. face to face 面对面地",
        @"14. no longer/not…any longer 不再……"
    ];
    return array[arc4random()%array.count];
}

@end
