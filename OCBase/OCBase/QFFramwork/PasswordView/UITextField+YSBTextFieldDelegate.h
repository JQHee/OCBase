//
//  UITextField+YSBTextFieldDelegate.h
//  TestPasswordView
//
//  Created by HJQ on 2017/3/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;

@end

/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const WJTextFieldDidDeleteBackwardNotification;

@interface UITextField (YSBTextFieldDelegate)

@property (weak, nonatomic) id<WJTextFieldDelegate> delegate;

@end
