//
//  QFUserInfo.h
//  LoveCar
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 aichezhonghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFUserInfo : NSObject

@property (nonatomic) BOOL IsLogin;
@property (nonatomic, copy) NSString *Mobile;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, assign) BOOL isRealName;
@property (nonatomic, copy) NSString *app_unid;
@property (nonatomic, copy) NSString *user_unid;
@property (nonatomic, copy) NSString *user_token;
@property (nonatomic, strong) NSDate *lastReadMsgTime;
@property (nonatomic, copy) NSString *IDCard;
@property (nonatomic, copy) NSString *Email;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *picUrl;
@property (copy,nonatomic) NSString *gender; // 性别
@property (assign,nonatomic) CGFloat point; // 积分
@property (copy,nonatomic) NSString *address; // 地址
@property (copy,nonatomic) NSString *birthday; // 生日
@property (nonatomic, copy) NSString *thumbUrl;
@property (nonatomic, copy) NSString *wallet;


+ (instancetype)shareInfo;
//清除登录信息
- (void)logout;

@end
