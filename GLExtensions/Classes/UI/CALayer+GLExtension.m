//
//  CALayer+GLExtension.m
//  GLExtensions
//
//  Created by liguoliang on 2020/12/23.
//

#import "CALayer+GLExtension.h"

@implementation CALayer (GLExtension)
- (void)backgroundColorGradientFromColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)start endPoint:(CGPoint)end {
    CAGradientLayer *gradlayer = [CAGradientLayer layer];
    NSMutableArray *cs = [NSMutableArray array];
    for(UIColor *col in colors) {
        [cs addObject:(__bridge id)col.CGColor];
    }
    gradlayer.colors = cs;
    gradlayer.locations = locations;
    gradlayer.startPoint = start;
    gradlayer.endPoint = end;
    gradlayer.frame = self.bounds;
    [self addSublayer:gradlayer];
}
@end
