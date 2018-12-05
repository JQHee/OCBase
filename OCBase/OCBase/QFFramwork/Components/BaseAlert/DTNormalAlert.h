//
//  DTNormalAlert.h
//  BaseAlert
//
//  Created by zhenyong on 16/9/16.
//  Copyright © 2016年 com.demo. All rights reserved.
//

#import "DTBaseAlertView.h"

@interface DTNormalAlert : DTBaseAlertView

@end

/* 使用方式
DTNormalAlert *alertView = [[DTNormalAlert alloc]initWithAlertType:DTAlertTypeBottom isShowNav:NO];
[self.view addSubview:alertView];
[alertView show];
 */
