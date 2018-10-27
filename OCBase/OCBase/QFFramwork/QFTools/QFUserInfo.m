//
//  QFUserInfo.m
//  LoveCar
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 aichezhonghua. All rights reserved.
//

#import "QFUserInfo.h"

@implementation QFUserInfo
@synthesize IsLogin = _IsLogin;
@synthesize Mobile = _Mobile;
@synthesize realName = _realName;
@synthesize app_unid = _app_unid;
@synthesize user_unid = _user_unid;
@synthesize user_token = _user_token;
@synthesize lastReadMsgTime = _lastReadMsgTime;
@synthesize IDCard = _IDCard;
@synthesize Email = _Email;
@synthesize username = _username;
@synthesize picUrl = _picUrl;
@synthesize thumbUrl = _thumbUrl;
@synthesize wallet = _wallet;
@synthesize gender = _gender;
@synthesize birthday = _birthday;
@synthesize address = _address;
@synthesize point = _point;
@synthesize isRealName = _isRealName;

+ (instancetype)shareInfo {
    static QFUserInfo *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)isRealName {
   return  [[[NSUserDefaults standardUserDefaults] objectForKey:@"isRealName"] boolValue];
}

- (BOOL)IsLogin {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"IsLogin"] boolValue];
}
- (BOOL)needGestureAuth {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"needGestureAuth"] boolValue];
}

- (NSString *)Mobile {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Mobile"];
}

- (NSString *)realName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"realName"];
}

- (NSString *)app_unid {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"app_unid"];
}
- (NSString *)user_token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_token"];
}
- (NSString *)user_unid {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user_unid"];
}
- (NSDate *)lastReadMsgTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LastReadMsgTime"];
}
- (NSString *)IDCard {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IDCard"];
}
- (NSString *)Email {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Email"];
}
- (NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}
- (NSString *)picUrl {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"picUrl"];
}

- (NSString *)address {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
}

- (NSString *)gender {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
}
- (CGFloat)point {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"point"] floatValue];
}

- (NSString *)birthday {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"birthday"];
}

- (NSString *)thumbUrl {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbUrl"];
}

- (void)setIsLogin:(BOOL)IsLogin {
    _IsLogin = IsLogin;
    [[NSUserDefaults standardUserDefaults] setBool:_IsLogin forKey:@"IsLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsRealName:(BOOL)isRealName {
    _isRealName = isRealName;
    [[NSUserDefaults standardUserDefaults] setBool:_isRealName forKey:@"isRealName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)setMobile:(NSString *)Mobile {
    _Mobile = Mobile;
    [[NSUserDefaults standardUserDefaults] setValue:_Mobile forKey:@"Mobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setRealName:(NSString *)realName {
    _realName = realName;
    [[NSUserDefaults standardUserDefaults] setObject:_realName forKey:@"realName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUser_token:(NSString *)user_token {
    _user_token = user_token;
    [[NSUserDefaults standardUserDefaults] setValue:_user_token forKey:@"user_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setUser_unid:(NSString *)user_unid {
    _user_unid = user_unid;
    [[NSUserDefaults standardUserDefaults] setValue:_user_unid forKey:@"user_unid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setApp_unid:(NSString *)app_unid {
    _app_unid = app_unid;
    [[NSUserDefaults standardUserDefaults] setValue:_app_unid forKey:@"app_unid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setIDCard:(NSString *)IDCard {
    _IDCard = IDCard;
    [[NSUserDefaults standardUserDefaults] setValue:_IDCard forKey:@"IDCard"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setEmail:(NSString *)Email {
    _Email = Email;
    [[NSUserDefaults standardUserDefaults] setValue:_Email forKey:@"Email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLastReadMsgTime:(NSDate *)lastReadMsgTime {
    _lastReadMsgTime = lastReadMsgTime;
    [[NSUserDefaults standardUserDefaults] setValue:lastReadMsgTime forKey:@"LastReadMsgTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setPicUrl:(NSString *)picUrl {
    _picUrl = picUrl;
    [[NSUserDefaults standardUserDefaults] setValue:picUrl forKey:@"picUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setGender:(NSString *)gender {
    _gender = gender;
    [[NSUserDefaults standardUserDefaults] setValue:gender forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPoint:(CGFloat)point {
    _point = point;
    [[NSUserDefaults standardUserDefaults] setFloat:point forKey:@"point"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setAddress:(NSString *)address {
    _address = address;
    [[NSUserDefaults standardUserDefaults] setValue:address forKey:@"address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setBirthday:(NSString *)birthday {
    _birthday = birthday;
    [[NSUserDefaults standardUserDefaults] setValue:birthday forKey:@"birthday"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setThumbUrl:(NSString *)thumbUrl {
    _thumbUrl = thumbUrl;
    [[NSUserDefaults standardUserDefaults] setValue:thumbUrl forKey:@"thumbUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setWallet:(NSString *)wallet {
    _wallet = wallet;
    [[NSUserDefaults standardUserDefaults] setValue:wallet forKey:@"wallet"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setUsername:(NSString *)username {
    _username = username;
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//清楚登录信息
- (void)logout {
    [[QFUserInfo shareInfo] setIsLogin:NO];
    [[QFUserInfo shareInfo] setIsRealName:NO];
    [[QFUserInfo shareInfo] setMobile:nil];
    [[QFUserInfo shareInfo] setIDCard:nil];
    [[QFUserInfo shareInfo] setEmail:nil];
    [[QFUserInfo shareInfo] setUser_token:nil];
    [[QFUserInfo shareInfo] setLastReadMsgTime:nil];
    [[QFUserInfo shareInfo] setBirthday:nil];
    [[QFUserInfo shareInfo] setAddress:nil];
    [[QFUserInfo shareInfo] setGender:nil];
    [[QFUserInfo shareInfo] setPoint:0.0];
    
    [[QFUserInfo shareInfo] setUsername:nil];
    [[QFUserInfo shareInfo] setPicUrl:nil];
    [[QFUserInfo shareInfo] setRealName:nil];

    //[SFHFKeychainUtils deleteItemForUsername:@"Mobile" andServiceName:@"WEFAX1.0" error:nil];

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end
