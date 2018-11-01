//
//  QFFramwork.m
//  elmsc
//
//  Created by qinfensky on 2016/11/7.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import "QFFramwork.h"

@implementation QFFramwork

+ (void)actionSheetShowToVC:(UIViewController *)VC
                     titles:(NSArray<NSString *> *)titles
              callBackIndex:(void (^)(NSInteger index))block {
    // 1.创建一个UIAlertController，注意用类方法创建的形式创建，选择AlertControllerStyle为ActionSheet
    UIAlertController *sheet =
        [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];

    for (int i = 0; i < titles.count; i++) {
        [sheet addAction:[UIAlertAction actionWithTitle:titles[i]
                                                  style:(UIAlertActionStyleDefault)
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                    block(i);
                                                }]];
    }

    // 注意：如果选择UIAlertActionStyleCancel这个款式，则该action是取消按钮，独立于其它的action。而其他的action都是黏在一起的。
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:(UIAlertActionStyleCancel)
                                            handler:^(UIAlertAction *_Nonnull action){

                                            }]];
    [VC presentViewController:sheet animated:YES completion:nil];
}

+ (void)showBlackTipsView:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:APPWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.font = [UIFont systemFontOfSize:13];
    [hud hideAnimated:YES afterDelay:2];
}

@end
