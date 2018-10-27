//
//  QFBaseTableViewController.h
//  elmsc
//
//  Created by MAC on 2016/12/8.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFBaseTableViewController : UITableViewController

/**
 * 返回到指定页面
 */
-(void)popToViewController:(Class )showController isShow:(BOOL)isshow;

@end
