//
//  DTBaseAlertView.h
//  零邻里
//
//  Created by zhenyong on 16/5/1.
//  Copyright © 2016年 com.lnl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BFScreenWidth [UIScreen mainScreen].bounds.size.width
#define BFScreenHeight [UIScreen mainScreen].bounds.size.height

typedef void (^BFAlertBlock)(UIView *superView);
typedef NS_ENUM (NSInteger , DTAlertType){
    DTAlertTypeCenter,
    DTAlertTypeBottom,
};

@interface DTBaseAlertView : UIView

/**
 *  初始化
 *
 *  @param type  中部alert 还是底部alert
 *  @param isNav 是否包含导航栏
 *
 *  @return 初始化对象
 */
- (instancetype)initWithAlertType:(DTAlertType)type
                        isShowNav:(BOOL)isShowNav;

/**
 *  初始化
 *
 *  @param type  中部alert 还是底部alert
 *  @param isNav 是否包含导航栏
 *  @param setUIAlertBlock 设置alertView
 *  @param showUIBlock     显示alertView
 *  @param hideUIBlock     隐藏lertView
 *
 *  @return instancetype
 */
- (instancetype)initWithAlertType:(DTAlertType)type
                       isShowNav:(BOOL)isShowNav
                      setUIAlert:(BFAlertBlock)setUIAlertBlock
                  showhowUIBlock:(BFAlertBlock)showUIBlock
                  hideUIBlock:(BFAlertBlock)hideUIBlock;

-(void)show;
-(void)hide;

/**
 *  alertView
 */
-(void)setAlertView;

/**
 *  显示时执行的工作
 */
-(void)showToDO;

/**
 *  隐藏时执行的工作
 */
-(void)hideToDO;

@end

/* 使用方式
DTBaseAlertView *alertView; =  [[DTBaseAlertView alloc] initWithAlertType:DTAlertTypeCenter isShowNav:NO setUIAlert:^(UIView *superView) {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BFScreenWidth, 600)];
    view.backgroundColor = [UIColor blueColor];
    [superView addSubview:view];
} showhowUIBlock:^(UIView *superView) {
    
} hideUIBlock:^(UIView *superView) {
    
}];
 [self.view addSubview:alertView];
 [alertView show];
 */
