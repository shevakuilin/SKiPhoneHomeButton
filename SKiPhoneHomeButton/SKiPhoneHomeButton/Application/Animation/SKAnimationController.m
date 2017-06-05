//
//  SKAnimationController.m
//  SKiPhoneHomeButton
//
//  Created by ShevaKuilin on 2017/5/22.
//  Copyright © 2017年 ShevaKuilin. All rights reserved.
//

#import "SKAnimationController.h"

@interface SKAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong, readwrite) UIView *animationView;
@property (nonatomic, assign, readwrite) NSTimeInterval duration;
@property (nonatomic, assign, readwrite) CGPoint startPoint;
@property (nonatomic, assign, readwrite) SK_ANIMATION_TYPE animationType;
@property (nonatomic, copy, readwrite) AnimationFinishBlock isFinish;

@end

@implementation SKAnimationController


#pragma mark - 动画组

- (void)transformAnimationGroupWithView:(UIView *)view
                          duration:(NSTimeInterval)duration
                        startPoint:(CGPoint)startPoint
                     animationType:(SK_ANIMATION_TYPE)animationType
                               isFinish:(AnimationFinishBlock)isFinish {
    _animationView = view;
    _duration = duration;
    _startPoint = startPoint;
    _animationType = animationType;
    _isFinish = isFinish;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self animationGroupPosition:self.startPoint], [self transformAnimation]];
    animationGroup.duration = _duration;
    animationGroup.delegate = self;

    [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];
}

#pragma mark - 动画位移

- (CAKeyframeAnimation *)animationGroupPosition:(CGPoint)startPosition {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *startValue, *endValue;
    if (_animationType == SK_ANIMATION_TYPE_LARGEN) {
        startValue = [NSValue valueWithCGPoint:startPosition];
        endValue = [NSValue valueWithCGPoint:[UIApplication sharedApplication].keyWindow.center];
        animation.duration = _duration - 0.1;
    } else {
        startValue = [NSValue valueWithCGPoint:[UIApplication sharedApplication].keyWindow.center];
        endValue = [NSValue valueWithCGPoint:startPosition];
        animation.duration = _duration;
    }
    animation.values = @[startValue, endValue];
    
    return animation;
}

#pragma mark - 变形效果

- (CABasicAnimation *)transformAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    if (_animationType == SK_ANIMATION_TYPE_LARGEN) {
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.2];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.duration = _duration;
    } else {
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.1];
        scaleAnimation.duration = _duration;
    }
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return scaleAnimation;
}

#pragma mark - CAAnimationDelegate 

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag == YES) {
        _isFinish(YES);
        if (_animationType == SK_ANIMATION_TYPE_SHRINK) {
            [[_animationView superview] removeFromSuperview];
        } else {
            
        }
    }
}

@end
