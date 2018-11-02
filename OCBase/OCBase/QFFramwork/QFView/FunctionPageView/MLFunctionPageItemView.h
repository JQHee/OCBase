//
//  MLFunctionPageItemView.h
//  FunctionPageDemo
//
//  Created by midland on 2018/11/2.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MLFunctionPageItemViewDelegate <NSObject>

- (void)functionPageItemViewSelected: (id) model withIndex: (int) selectIndex;

@end

@interface MLFunctionPageItemView : UIView

@property (nonatomic, weak) id <MLFunctionPageItemViewDelegate> delegate;
@property (nonatomic, strong) id model;
@property (nonatomic, assign) int selectIndex;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end
