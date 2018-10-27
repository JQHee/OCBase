//
//  MBProgressToolsCenter.m
//  TestMBProgressHUD
//
//  Created by MAC on 2017/2/11.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "MBProgressToolsCenter.h"
//#import <MBProgressHUD/MBProgressHUD.h>

static const CGFloat kHudTag = 99999;
static const CGFloat kProgressHudTag = 88888;

@implementation MBProgressToolsCenter


#pragma mark - public Methods

void ShowStatusHUD(UIView *contentView,NSString *status,NSString *showImageStr) {
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowStatusHUDFunction(contentView,status, showImageStr);
        });
    }else {
        ShowStatusHUDFunction(contentView,status, showImageStr);
    }
}

void ShowProgressHUD(UIView *contentView,NSString *status,CGFloat progress) {
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowProgressHUDFunction(contentView,status, progress);
        });
    }else {
        ShowProgressHUDFunction(contentView,status, progress);
    }
}

void ShowToastHUD(UIView *contentView,NSString *status, NSTimeInterval time) {
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowToastHUDFunction(contentView,status, time);
        });
    }else {
        ShowToastHUDFunction(contentView,status, time);
    }
}

void ShowMaskHUD(UIView *contentView,NSString *status) {
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowMaskHUDFunction(contentView,status);
        });
    }else {
        ShowMaskHUDFunction(contentView,status);
    }
}

void ShowHUD(UIView *contentView,NSString *status) {
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowHUDFunction(contentView,status);
        });
    }else {
        ShowHUDFunction(contentView,status);
    }
}

void HideHUD(UIView *contentView){
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            HideHUDFunction(contentView);
        });
    }else {
        HideHUDFunction(contentView);
    }
}

#pragma mark - private Methods

MBProgressHUD * HUD(UIView *contentView,BOOL animationBOOL) {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:contentView animated:animationBOOL];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    // 默认有毛玻璃的效果(如果不这样设置，背景就不能设置为黑色)
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
    hud.opaque = NO;
    // 是否强制HUD背景框宽高相等
    //hud.square = YES;
    // HUD显示的最短时间。设置这个值是为了避免HUD显示后立即被隐藏。默认值为0
    hud.graceTime = 0.0f;
    hud.minShowTime = 1.5f;
    hud.contentColor = [UIColor whiteColor];
    hud.label.textColor = [UIColor whiteColor];
    //hud.label.font = [UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

void ShowStatusHUDFunction(UIView *contentView,NSString *status,NSString *showImageStr) {
    HideHUD(contentView);
    MBProgressHUD *hud = HUD(contentView,YES);
    hud.tag = kHudTag;
    UIImage *image = [[UIImage imageNamed:showImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc]initWithImage:image];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = status;
    [hud hideAnimated:YES afterDelay:3.0];
}

void ShowProgressHUDFunction(UIView *contentView,NSString *status,CGFloat progress) {
    if ([contentView viewWithTag:kHudTag]) {
        [contentView viewWithTag:kHudTag].hidden = YES;
        [[contentView viewWithTag:kHudTag] removeFromSuperview];
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:contentView];
    if (!hud) {
        hud = HUD(contentView,NO);
    }
    hud.tag = kProgressHudTag;
    hud.mode = MBProgressHUDModeDeterminate;
    hud.userInteractionEnabled = NO;
    hud.label.text = status;
    hud.progress = progress;
}

void ShowToastHUDFunction(UIView *contentView,NSString *status, NSTimeInterval time) {
    HideHUD(contentView);
    //显示提示信息;
    MBProgressHUD *hud = HUD(contentView, YES);
    hud.tag = kHudTag;
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = status;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
}

// 带有蒙版
void ShowMaskHUDFunction(UIView *contentView,NSString *status) {
    HideHUD(contentView);
    MBProgressHUD *hud = HUD(contentView, YES);
    // 半透明的遮罩
    hud.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    hud.tag = kHudTag;
    hud.userInteractionEnabled = YES;
    hud.label.text = status;
}

void ShowHUDFunction(UIView *contentView,NSString *status) {
    HideHUD(contentView);
    MBProgressHUD *hud = HUD(contentView, YES);
    hud.tag = kHudTag;
    hud.userInteractionEnabled = NO;
    hud.label.text = status;
}

void HideHUDFunction (UIView *contentView) {
    MBProgressHUD *hud = nil;
    if ([contentView viewWithTag:kHudTag]) {
        hud = [contentView viewWithTag:kHudTag];
        [hud hideAnimated:YES];
    }
    if ([contentView viewWithTag:kProgressHudTag]) {
        hud = [contentView viewWithTag:kProgressHudTag];
        [hud hideAnimated:YES];
    }
    [MBProgressHUD hideHUDForView:contentView animated:YES];
}


@end
