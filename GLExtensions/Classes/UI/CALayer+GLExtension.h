//
//  CALayer+GLExtension.h
//  GLExtensions
//
//  Created by liguoliang on 2020/12/23.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (GLExtension)
/// 增加渐变颜色
/// @param colors 渐变的颜色
/// @param locations 分割点 (0.0~1.0)
/// @param start 起始点 (x:0.0~1.0, y:0.0~1.0)
/// @param end 结束点 (x:0.0~1.0, y:0.0~1.0)
- (void)backgroundColorGradientFromColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)start endPoint:(CGPoint)end;
@end
