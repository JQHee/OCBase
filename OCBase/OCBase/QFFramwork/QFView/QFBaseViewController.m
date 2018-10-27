//
//  QFBaseViewController.m
//  elmsc
//
//  Created by qinfensky on 2016/11/10.
//  Copyright © 2016年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import "QFBaseViewController.h"

@interface QFBaseViewController ()

@end

@implementation QFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaviView];
}

- (void)setupNaviView {
    /**
     *  @author qinfensky, 15-11-18 17:11:11
     *
     *  去掉导航栏高斯模糊
     */
    self.navigationController.navigationBar.translucent = NO;
    //修改导航条背景色（themeColor）
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#2a6c6b"];
    //修改导航条标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    //修改导航条添加的按钮（item）颜色(黄色)
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.28 green:0.29 blue:0.29 alpha:1.00];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    //去除导航栏黑色分界线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    //设置返回键标题
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 返回到指定页面
 */
-(void)popToViewController:(Class )showController isShow:(BOOL)isshow {
    
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    UIViewController *currentController = [navigationArray lastObject];
    
    for (NSInteger i = navigationArray.count-1 ;i >= 0 ;i--) {
        
        UIViewController *vc = [navigationArray objectAtIndex:i];
        
        if (![vc isKindOfClass:[showController class]]) {
            [navigationArray removeObject:vc];
        }
        else{
            //是否显示当前页面
            if (isshow) {
                [navigationArray addObject:currentController];
            }
            self.navigationController.viewControllers = navigationArray;
            return;
        }
    }
}


- (void)dealloc {
    debugLog(@"dealloc");
}



@end
