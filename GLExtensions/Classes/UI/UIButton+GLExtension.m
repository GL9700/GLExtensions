//
//  UIButton+GLExtension.m
//  GLExtensions
//
//  Created by liguoliang on 2018/9/27.
//

#import <GLExtensions/UIButton+GLExtension.h>
#import <objc/message.h>

@implementation UIButton (GLExtension)

- (void)setImagePositionInClock:(int)imagePositionInClock {
    if(imagePositionInClock!=0){
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
        imageSize.width+=10;
        titleSize.width+=10;
        if(imagePositionInClock==12){
            self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height),-imageSize.width,0,0);
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height),0,0,-titleSize.width);
        }else if(imagePositionInClock==3){
            self.titleEdgeInsets = UIEdgeInsetsMake(0,-imageSize.width*2,0,0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-self.titleLabel.frame.size.width*2);
        }else if(imagePositionInClock==6){
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height),-imageSize.width,0,0);
            self.imageEdgeInsets = UIEdgeInsetsMake((titleSize.height),0,0,-titleSize.width);
        }else if(imagePositionInClock==9){
            self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
        }
    }else{
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
    }
}

- (instancetype)copy {
    NSData *temp = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:temp];
}

@end
