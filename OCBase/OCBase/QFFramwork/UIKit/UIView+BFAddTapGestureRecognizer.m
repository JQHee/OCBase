//
//  UIView+BFAddTapGestureRecognizer.m
//  OCBase
//
//  Created by HJQ on 2018/11/11.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIView+BFAddTapGestureRecognizer.h"
#import <objc/runtime.h>

@implementation UIView (BFAddTapGestureRecognizer)

- (void)addTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void (^)(NSInteger))block {

    self.block = block;

    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClick)];

    [self addGestureRecognizer:tag];

    if (tapGestureDelegate) {
        tag.delegate = tapGestureDelegate;
    }
    self.userInteractionEnabled = YES;

}

- (void)tagClick {
    if (self.block) {
        self.block(self.tag);
    }
}

- (void)setBlock:(void (^)(NSInteger tag))block {

    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (void(^)(NSInteger tag))block {
    return objc_getAssociatedObject(self, @selector(block));
}

@end
