//
//  QRViewController.h
//  OCBase
//
//  Created by HJQ on 2018/11/4.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRViewController : UIViewController

//得到二维码后回调，传出stringQR
@property (nonatomic, copy) void (^getQrCode)(NSString *stringQR);

@end

NS_ASSUME_NONNULL_END
