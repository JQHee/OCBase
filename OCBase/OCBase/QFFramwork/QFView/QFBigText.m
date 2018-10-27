//
//  QFBigText.m
//  elmsc
//
//  Created by qinfensky on 2016/11/11.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import "QFBigText.h"

@implementation QFBigText

- (CGSize)intrinsicContentSize {
    CGSize originSize = [super intrinsicContentSize];
    [self setupUI:originSize.height];
    return CGSizeMake(originSize.width + 20, originSize.height + 10);
}

- (void)setupUI:(CGFloat)height {
    self.layer.cornerRadius = height / 2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.clipsToBounds = YES;
}

@end
