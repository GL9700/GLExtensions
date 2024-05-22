//
//  UIViewController+GLExtension.m
//  GLExtensions_Example
//
//  这个文件是 GLExtensions_Example 项目中对 UIViewController 的分类扩展，用于实现自定义的转场动画和交互效果。
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//


#import <GLExtensions/UIViewController+GLExtension.h>
#import <objc/message.h>

@implementation UIViewController (GLExtension)
- (void)presentViewController:(UIViewController *)vc isOverScreen:(BOOL)overScreen animated:(BOOL)animated completion:(void (^)(void))completion {
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = overScreen ? UIModalPresentationOverFullScreen : UIModalPresentationFullScreen;
    [self presentViewController:vc animated:animated completion:completion];
}
@end

@implementation UIViewController(GLExtPresent)

/// 自定义转场动画（用于 present 动画）(在这里实现或返回自定义的转场动画对象)
/// - Parameters:
///   - presented: 被呈现的 UIViewController
///   - presenting: 当前呈现视图控制器
///   - source: 来源视图控制器
///
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if([self respondsToSelector:@selector(transitioningViewController)]) {
        return [self transitioningViewController];
    }
    return presented;
}

/// 自定义转场动画（用于 dismiss 动画）(在这里实现或返回自定义的转场动画对象)
/// - Parameter dismissed: 被移除的 UIViewController
///
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if([self respondsToSelector:@selector(transitioningViewController)]) {
        return [self transitioningViewController];
    }
    return self;
}

/// 自定义交互转场（用于 present 动画）(在这里实现或返回自定义的交互转场对象)
/// - Parameter animator: 转场动画对象
///
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

/// 自定义交互转场（用于 dismiss 动画）(在这里实现或返回自定义的交互转场对象)
/// - Parameter animator: 转场动画对象
///
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

/// 自定义 Presentation Controller (在这里实现或返回自定义的 Presentation Controller，用于控制呈现视图的外观和行为)
/// - Parameters:
///   - presented: 被呈现的 UIViewController
///   - presenting: 当前呈现视图控制器
///   - source: 来源视图控制器
///
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return nil;
}

@end

@implementation UIViewController (GLExtanimatedTransitioning)

/// 动画执行时间
/// - Parameter transitionContext: 在转场过程中提供了关于转场的上下文信息，包括转场的开始和结束状态、动画的容器视图、以及是否正在执行动画等
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25; // 动画持续时间
}

/// 核心方法，转场动画我们就是在这个方法里面添加
/// - Parameter transitionContext: 在转场过程中提供了关于转场的上下文信息，包括转场的开始和结束状态、动画的容器视图、以及是否正在执行动画等
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    if(toViewController.presentedViewController == fromViewController) {
        // dismiss
        UIView *gesturereView = [containerView viewWithTag:10010];
        CGRect endRect = containerView.bounds;
        endRect.origin.y = containerView.bounds.size.height;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.frame = endRect;
            gesturereView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }else{
        // present
        UIView *gesturereView = [UIView new];
        gesturereView.tag = 10010;
        gesturereView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        gesturereView.frame = containerView.bounds;
        gesturereView.alpha = 0;
        [containerView addSubview:gesturereView];
        
        [gesturereView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBackground)]];
        
        CGRect startFrame = toViewController.view.frame;
        startFrame.origin.y = containerView.bounds.size.height;
        toViewController.view.frame = startFrame;
        [containerView addSubview:toViewController.view];
        
        CGRect endRect = containerView.bounds;
        if([toViewController respondsToSelector:NSSelectorFromString(@"pHeight")]) {
            CGFloat ph = [toViewController pHeight];
            if(ph>0) {
                endRect.origin.y = endRect.size.height - MIN(ph, endRect.size.height);
                endRect.size.height = MIN(ph, endRect.size.height);
            }
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.frame = endRect;
            gesturereView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

- (void)onTapBackground {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

@interface UINavigationController(GLExtPresent)
@end
@implementation UINavigationController(GLExtPresent)
- (CGFloat)pHeight {
    if([self.topViewController respondsToSelector:@selector(pHeight)]) {
        return [self.topViewController pHeight];
    }else{
        return 0;
    }
}
@end
@interface UITabBarController(GLExtPresent)
@end
@implementation UITabBarController(GLExtPresent)
- (CGFloat)pHeight {
    if([self.selectedViewController respondsToSelector:@selector(pHeight)]) {
        return [self.selectedViewController pHeight];
    }else{
        return 0;
    }
}
@end
