//
//  QFBaseViewController.h
//  elmsc
//
//  Created by qinfensky on 2016/11/10.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBaseViewController : UIViewController

/**
 * 返回到指定页面
 */
-(void)popToViewController:(Class )showController isShow:(BOOL)isshow;

@end
