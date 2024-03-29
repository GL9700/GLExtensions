//
//  NSObject+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define weak(o)   autoreleasepool {} __weak typeof(o) o ## Weak = o;
#define strong(o) autoreleasepool {} __strong typeof(o) o = o ## Weak;
#define GLGETTER(_TYPE_, _VAR_, _VALUE_) -(_TYPE_)_VAR_{if(!_##_VAR_){_##_VAR_=_VALUE_;}return _##_VAR_;}
#define GLSIGNLE_H(_NAME_) + (instancetype)Shared##_NAME_;
#define GLSIGNLE_M(_NAME_) + (instancetype)Shared##_NAME_{static dispatch_once_t onceToken;static id instance;dispatch_once(&onceToken,^{instance=[[self class] new];});return instance;}


/** 异步执行 ，主线更新 */
static inline void dispatch_async_work_ui(dispatch_block_t workblock, dispatch_block_t uiblock)
{
    if (workblock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            workblock();
            if (uiblock) {
                dispatch_async(dispatch_get_main_queue(), uiblock);
            }
        });
    }
    else if (uiblock) {
        dispatch_async(dispatch_get_main_queue(), uiblock);
    }
}

@interface NSObject (GLExtension)

- (NSString *)JSONString;

/** 设置关联的一个参数对象 (retain) */
- (void)setAssociatedObjectRetain:(id)object;

/** 获取关联的一个参数对象 */
- (id)associatedObjectRetain;

/** 设置关联的一个类型参数对象 (weak , assign) */
- (void)setAssociatedObject:(id)object;

/** 获取关联的一个参数对象weak */
- (id)associatedObject;

@end
