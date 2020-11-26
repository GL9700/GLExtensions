//
//  UIButton+GLExtension.m
//  GLExtensions
//
//  Created by liguoliang on 2018/9/27.
//

#import <GLExtensions/UIButton+GLExtension.h>
#import <objc/message.h>

@implementation UIButton (GLExtension)

/*
 - (void)setImagePositionInClock:(int)imagePositionInClock {
 self.backgroundColor = [UIColor lightGrayColor];
 if(imagePositionInClock!=0){
 [self.titleLabel sizeToFit];
 CGRect rImg = self.imageView.frame;
 CGRect rTxt = self.titleLabel.frame;
 CGRect rSup = self.bounds;
 if(imagePositionInClock==12){
 
 float toCenter = 0;
 if(CGRectGetMinX(rImg)>CGRectGetMidX(rSup)) {
 toCenter = -(CGRectGetMinX(rImg) - (CGRectGetMinX(rImg) - CGRectGetMidX(rSup));
 }else{
 toCenter = CGRectGetMinX(rImg) + (CGRectGetMidX(rSup) - (CGRectGetMinX(rImg));
 }
 
 self.imageEdgeInsets = UIEdgeInsetsMake(0, -(CGRectGetMinX(rImg)-(size.width-CGRectGetWidth(rImg))/2), 0, (CGRectGetMinX(rImg)-(size.width-CGRectGetWidth(rImg))/2)
 );
 self.titleEdgeInsets = UIEdgeInsetsMake(0, -(CGRectGetMinX(rTxt)-(size.width-CGRectGetWidth(rTxt))/2), 0, (CGRectGetMinX(rTxt)-(size.width-CGRectGetWidth(rTxt))/2)
 );
 }
 else if(imagePositionInClock==3){
 self.titleEdgeInsets = UIEdgeInsetsMake(0, -(CGRectGetMaxX(rImg)), 0, CGRectGetMaxX(rImg));
 self.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetMaxX(rTxt), 0, -(CGRectGetMaxX(rTxt)));
 }
 else if(imagePositionInClock==6){
 self.titleEdgeInsets = UIEdgeInsetsMake(-(CGRectGetMaxY(rImg)),0,0,0);
 self.imageEdgeInsets = UIEdgeInsetsMake((CGRectGetMaxY(rTxt)),0,0,0);
 }
 else if(imagePositionInClock==9){
 self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
 self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
 }
 }else{
 self.titleEdgeInsets = UIEdgeInsetsZero;
 self.imageEdgeInsets = UIEdgeInsetsZero;
 }
 }
 */

- (instancetype)copy {
    NSData *temp = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:temp];
}

@end
