//
//  MLFunctionPageView.h
//  FunctionPageDemo
//
//  Created by midland on 2018/11/2.
//  Copyright © 2018年 midland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLFunctionPageViewDelegate <NSObject>

- (void)functionPageViewSelected: (id) model withIndex: (int) selectIndex;

@end

@interface MLFunctionPageView : UIView

@property (nonatomic, weak) id <MLFunctionPageViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArray;

@end
