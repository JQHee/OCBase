//
//  YSBStartView.h
//  TestPasswordView
//
//  Created by HJQ on 2017/3/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSBStarView;
@protocol YSBStarViewDelegate <NSObject>
@optional

// 星星百分比（得分值）发生变化的代理
- (void)starView:(YSBStarView *)starView scorePercentDidChange:(CGFloat)newScorePercent;
@end

@interface YSBStarView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0~1，默认1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, weak) id<YSBStarViewDelegate> delegate;

// 单例
+ (instancetype) shareInstance;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

/**
 重写属性level的方法，一旦给此属性赋值，就创建星星
 @param level 评级分数
 */
- (void)setLevel:(CGFloat)level starView:(UIView *)starView;

@end
