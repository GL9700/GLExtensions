//
//  UIButton+GLExtension.m
//  GLExtensions
//
//  Created by liguoliang on 2018/9/27.
//

#import <GLExtensions/UIButton+GLExtension.h>
#import <objc/message.h>

@implementation UIButton (GLExtension)

- (instancetype)copy {
    NSData *temp = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:temp];
}

@end
