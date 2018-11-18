//
//  UIView+Animation.m
//  OCBase
//
//  Created by HJQ on 2018/11/18.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

#define AngleRatation(angle) (angle / 180.0 * M_PI)
// 点赞
- (void)startAnimationPopOut {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];

    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSValue *scaleValue1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 0)];
    NSValue *scaleValue2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0)];
    NSValue *scaleValue3 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 0)];
    NSValue *scaleValue4 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0)];
    scaleAnimation.values = @[scaleValue1,scaleValue2,scaleValue3,scaleValue4];

    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *rotateValue1 = @(AngleRatation(20));
    NSValue *rotateValue2 = @(AngleRatation(-20));
    NSValue *rotateValue3 = @(AngleRatation(10));
    NSValue *rotateValue4 = @(AngleRatation(0));
    rotateAnimation.values = @[rotateValue1,rotateValue2,rotateValue3,rotateValue4];

    animationGroup.animations = @[scaleAnimation,rotateAnimation];
    animationGroup.duration = 0.8;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.repeatCount = 0;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    // self.iconImageView
    [self.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

// 取消点赞
- (void)startAnimationPopIn {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];

    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSValue *scaleValue1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0)];
    NSValue *scaleValue2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 0)];
    NSValue *scaleValue3 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 0)];
    NSValue *scaleValue4 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0)];
    scaleAnimation.values = @[scaleValue1,scaleValue2,scaleValue3,scaleValue4];

    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *rotateValue1 = @(AngleRatation(10));
    NSValue *rotateValue2 = @(AngleRatation(-20));
    NSValue *rotateValue3 = @(AngleRatation(20));
    NSValue *rotateValue4 = @(AngleRatation(0));
    rotateAnimation.values = @[rotateValue1,rotateValue2,rotateValue3,rotateValue4];

    animationGroup.animations = @[scaleAnimation,rotateAnimation];
    animationGroup.duration = 0.8;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.repeatCount = 0;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    // iconImageView
    [self.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

@end
