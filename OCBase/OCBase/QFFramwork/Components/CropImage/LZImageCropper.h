//
//  LZImageCropping.h
//  CroppingImage
//
//  Created by 刘志雄 on 2017/12/25.
//  Copyright © 2017年 刘志雄. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZImageCropper;
@protocol LZImageCroppingDelegate <NSObject>

-(void)lzImageCroppingDidCancle:(LZImageCropper *)cropping;
-(void)lzImageCropping:(LZImageCropper *)cropping didCropImage:(UIImage *)image;

@end

@interface LZImageCropper : UIViewController

@property(nonatomic,weak)id<LZImageCroppingDelegate>delegate;

/**
 裁剪的图片
 */
@property(nonatomic,strong)UIImage *image;

/**
 裁剪区域
 */
@property(nonatomic,assign)CGSize cropSize;


/**
 是否裁剪成圆形
 */
@property(nonatomic,assign)BOOL isRound;

@end

/**
self.cropper= [[LZImageCropper alloc]init];
//设置代理
self.cropper.delegate = self;
//设置图片
NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3209"  ofType:@"jpg"];
UIImage *image = [UIImage imageWithContentsOfFile:path];
self.cropper.image = image;
//设置自定义裁剪区域大小
self.cropper.cropSize = CGSizeMake(self.view.frame.size.width - 60, (self.view.frame.size.width-60)*960/1280);
self.cropper.isRound = sender.tag-kBaseTag == 0;
[self presentViewController:self.cropper animated:YES completion:nil];
 */
