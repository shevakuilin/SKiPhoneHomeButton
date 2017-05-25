//
//  SKAnimationController.h
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/22.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SK_ANIMATION_TYPE) {// 动画类型
    SK_ANIMATION_TYPE_LARGEN,// 变大效果
    SK_ANIMATION_TYPE_SHRINK// 缩小效果
};

typedef void(^AnimationFinishBlock)(BOOL isFinish);

@interface SKAnimationController : NSObject

- (void)transformAnimationGroupWithView:(UIView *)view
                               duration:(NSTimeInterval)duration
                             startPoint:(CGPoint)startPoint
                          animationType:(SK_ANIMATION_TYPE)animationType
                               isFinish:(AnimationFinishBlock)isFinish;

@end
