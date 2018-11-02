//
//  MLFunctionPageItemView.m
//  FunctionPageDemo
//
//  Created by midland on 2018/11/2.
//  Copyright © 2018年 midland. All rights reserved.
//

#import "MLFunctionPageItemView.h"


@interface MLFunctionPageItemView()

@end

@implementation MLFunctionPageItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self viewBindEvents];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.bounds.size.width - 60) / 2.0, 5, 60, 60);
    self.label.frame = CGRectMake(0, self.bounds.size.height - 21, self.bounds.size.width, 21);
}

// MARK: - Private methods
- (void) setupUI {
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

- (void) viewBindEvents {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

// MARK: - Event respose
- (void) tapAction {
    if ([_delegate respondsToSelector:@selector(functionPageItemViewSelected:withIndex:)]) {
        [_delegate functionPageItemViewSelected:_model withIndex:_selectIndex];
    }
}

// MARK: - setter and getter
- (void)setModel:(id)model {
    _model = model;
}

- (void)setSelectIndex:(int)selectIndex {
    _selectIndex = selectIndex;
}

- (UIImageView *) imageView {
    if (!_imageView) {
        UIImageView *imageView = [UIImageView new];
        _imageView = imageView;
        
    }
    return _imageView;
}

- (UILabel *) label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        _label = label;
    }
    return _label;
}

@end
