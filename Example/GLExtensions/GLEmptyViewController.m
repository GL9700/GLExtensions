//
//  GLEmptyViewController.m
//  GLExtensions_Example
//
//  Created by 李国梁 on 2021/1/25.
//  Copyright © 2021 liandyii@msn.com. All rights reserved.
//

#import "GLEmptyViewController.h"
#import <UIColor+GLExtension.h>
@interface GLEmptyViewController ()

@end

@implementation GLEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}

@end
