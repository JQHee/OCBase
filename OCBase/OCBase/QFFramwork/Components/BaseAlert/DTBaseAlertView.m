//
//  DTBaseAlertView.m
//  
//
//  Created by zhenyong on 16/5/1.
//  Copyright © 2016年 com.lnl. All rights reserved.
//

#import "DTBaseAlertView.h"

@interface DTBaseAlertView()
{
    DTAlertType alertType;
    BOOL isShowNav;
}

@property (copy , nonatomic) BFAlertBlock setUIAlert;
@property (copy , nonatomic) BFAlertBlock showUIAlert;
@property (copy , nonatomic) BFAlertBlock hideUIAlert;

@end

@implementation DTBaseAlertView

- (instancetype)initWithAlertType:(DTAlertType)type
                        isShowNav:(BOOL)isShowNav
{
    self = [super initWithFrame:CGRectMake(0, 0, BFScreenWidth, BFScreenHeight)];
    alertType = type;
    isShowNav = isShowNav;
    [self setUI];
    return self;
}

- (instancetype)initWithAlertType:(DTAlertType)type
                        isShowNav:(BOOL)isShowNav
                       setUIAlert:(BFAlertBlock)setUIAlertBlock
                   showhowUIBlock:(BFAlertBlock)showUIBlock
                      hideUIBlock:(BFAlertBlock)hideUIBlock;
{
    self = [super initWithFrame:CGRectMake(0, 0, BFScreenWidth, BFScreenHeight)];
    alertType = type;
    isShowNav = isShowNav;
    _setUIAlert = setUIAlertBlock;
    _showUIAlert = showUIBlock;
    _hideUIAlert = hideUIBlock;
    [self setUI];
    return self;
}

-(void)setUI
{
    self.backgroundColor = [UIColor clearColor];
    UIButton *bgView = [[UIButton alloc]initWithFrame:self.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [bgView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgView];
    if (_setUIAlert) {
        _setUIAlert(self);
    }
    
    [self setAlertView];
}
-(void)show
{
    [self showToDO];
    if (_showUIAlert) {
        _showUIAlert(self);
    }
    if (self.subviews.count == 2) {
        UIView *bgView = self.subviews[0];
        UIView *alertView = self.subviews[1];
        bgView.alpha = 0;
        CGRect frame = alertView.frame;
        frame.origin.y = BFScreenHeight;
        alertView.frame = frame;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            if (alertType == DTAlertTypeCenter) {
                CGRect frame = alertView.frame;
                frame.origin.x = (BFScreenWidth - alertView.frame.size.width)/2;
                frame.origin.y = (BFScreenHeight - alertView.frame.size.height)/2;
                alertView.frame = frame;
            }
            if (alertType == DTAlertTypeBottom) {
                CGRect frame = alertView.frame;
                frame.origin.x = (BFScreenWidth - alertView.frame.size.width)/2;
                float y = BFScreenHeight-alertView.frame.size.height;
                if (isShowNav) {
                    CGFloat navBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
                    y = BFScreenHeight - navBarHeight - alertView.frame.size.height;
                }
                frame.origin.y = y;
                alertView.frame = frame;
            }
            bgView.alpha = 0.5;
        } completion:nil];

    }
}
-(void)hide
{
    [self hideToDO];
    if(_hideUIAlert) {
        _hideUIAlert(self);
    }
    if (self.subviews.count == 2) {
        UIView *bgView = self.subviews[0];
        UIView *alertView = self.subviews[1];
        bgView.alpha = 0.5;
        if (alertType == DTAlertTypeCenter) {
            CGRect frame = alertView.frame;
            frame.origin.x = (BFScreenWidth - alertView.frame.size.width)/2;
            frame.origin.y = (BFScreenHeight - alertView.frame.size.height)/2;
            alertView.frame = frame;
        }
        if (alertType == DTAlertTypeBottom) {
            CGRect frame = alertView.frame;
            frame.origin.x = (BFScreenWidth - alertView.frame.size.width)/2;
            frame.origin.y = BFScreenHeight - alertView.frame.size.height;
            alertView.frame = frame;
        }

        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = alertView.frame;
            frame.origin.y = BFScreenHeight + 20;
            alertView.frame = frame;
            bgView.alpha = 0;
        } completion:^(BOOL finish){
            if (finish) {
                [self removeFromSuperview];
            }
        }];
        
    }

}

-(void)setAlertView {
    
}

-(void)showToDO {
    
}

-(void)hideToDO{
}

@end
