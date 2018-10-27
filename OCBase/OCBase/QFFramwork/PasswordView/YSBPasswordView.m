//
//  YSBPasswordView.m
//  Yuansubei
//
//  Created by HJQ on 2017/3/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#import "YSBPasswordView.h"
#import "UITextField+YSBTextFieldDelegate.h"

// 输入密码的位数
static const int boxCount = 6;


@interface YSBPasswordView()<UITextFieldDelegate,WJTextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *boxes;
// 占位编辑框(这样就点击密码格以外的部分,可以弹出键盘)
@property (weak, nonatomic) UITextField *contentTextField;

// 暂时保存密码
@property (nonatomic, assign) NSString  *tempPassword;
@property (nonatomic, assign) BOOL isFirst;


@end

@implementation YSBPasswordView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.isFirst = YES;
        [self setUpContentView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark: - Private Methods
- (void)setUpContentView {
    
    UITextField *contentField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    contentField.delegate = self;
    self.contentTextField = contentField;
    contentField.placeholder = @"";
    contentField.hidden = YES;
    [contentField setKeyboardType:UIKeyboardTypeNumberPad];
    [contentField addTarget:self action:@selector(txchange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:contentField];
    
    // 密码格之间的间隔
    CGFloat itemX = 0;
    for (int i = 0; i < boxCount; i++) {
        CGFloat itemSpace = 5;
        CGFloat itemWH = (self.frame.size.width - (boxCount - 1) * itemSpace)  / boxCount;
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake(itemX, (self.frame.size.height - itemWH) * 0.5, itemWH, itemWH)];
        pwdLabel.layer.borderColor = [UIColor grayColor].CGColor;
        pwdLabel.font = [UIFont systemFontOfSize:21];
        pwdLabel.layer.masksToBounds = YES;
        pwdLabel.layer.cornerRadius = 1;
        pwdLabel.enabled = NO;
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
        //pwdLabel.secureTextEntry = YES;//设置密码模式
        pwdLabel.layer.borderWidth = 1;
        [self addSubview:pwdLabel];
        
        itemX = pwdLabel.origin.x + itemWH + itemSpace;
        
        [self.boxes addObject:pwdLabel];
    }
    //进入界面，contentTextField 成为第一响应
    //[self.contentTextField becomeFirstResponder];
}


- (void)singleTap:(UITapGestureRecognizer *) tap {
    [self.contentTextField becomeFirstResponder];
}

#pragma mark: - 清空
- (void) clearAllText:(UITextField *) tx {
    tx.text = @"";
    for (int i = 0; i < self.boxes.count; i++) {
        UITextField *pwdtx = [self.boxes objectAtIndex:i];
        pwdtx.text = @"";
        
    }
}

#pragma mark 文本框内容改变
- (void)txchange:(UITextField *)tx {
    NSString *password = tx.text;
    
    for (int i = 0; i < self.boxes.count; i++) {
        UITextField *pwdtx = [self.boxes objectAtIndex:i];
        
        if (i < password.length){
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
            pwdtx.text = @"*";
        }
        
    }
    // 输入密码完毕
    if (password.length == boxCount) {
        
        if (self.isNeedverify) { // 是否需要两次校验密码
            if (self.isFirst) {
                self.isFirst = NO;
                _tempPassword = password;
                [self performSelector:@selector(clearAllText:) withObject:tx afterDelay:.3];
            }else {
                self.isFirst = YES;
                if ([password isEqualToString:_tempPassword]) {
                    if (self.returnPasswordblock) {
                        self.returnPasswordblock(password,successStatus);
                    }
                }else {
                    if (self.returnPasswordblock) {
                        self.returnPasswordblock(password,noTheSameASStatus);
                        [self performSelector:@selector(clearAllText:) withObject:tx afterDelay:.3];
                    }
                }

            }
        }else { // 如果不需要两次密码，直接返回
            if (self.returnPasswordblock) {
                self.returnPasswordblock(password,successStatus);
            }
        }

        
    }
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"变化%@", string);
    if ([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        //判断是不是删除键
        return YES;
    } else if (textField.text.length >= boxCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        // 只允许输入数字（主要针对第三方键盘 还有空格）
        return YES;
    }
}

- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    NSLog(@"删除%@",textField.text);
    NSString *password = textField.text;
    
    for (int i = 0; i < self.boxes.count; i++) {
        UITextField *pwdtx = [self.boxes objectAtIndex:i];
        pwdtx.text = @"";
        if (i < password.length){
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
            pwdtx.text = @"*";
        }
    }
}

#pragma mark --- 懒加载
- (NSMutableArray *)boxes{
    if (!_boxes) {
        _boxes = [NSMutableArray array];
    }
    return _boxes;
}
@end
