//
//  UIImageView+Core.h
//  OCBase
//
//  Created by HJQ on 2018/11/3.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Core)

// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;

@end

NS_ASSUME_NONNULL_END
