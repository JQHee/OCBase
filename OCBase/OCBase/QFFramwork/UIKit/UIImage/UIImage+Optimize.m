//
//  UIImage+Optimize.m
//  OCBase
//
//  Created by HJQ on 2018/12/16.
//  Copyright © 2018 HJQ. All rights reserved.
//

#import "UIImage+Optimize.h"

/*imageName:的爱恨情仇*/
/*
看打点日志就很恐怖了，执行两个imageName:就消耗了主线程差不多100ms的时间，五个tabbar那就是500ms的时间，显然这就是上面效果图出现白屏的原因了，实际上imageName:是会对图片进行解码之后再渲染的。
既然原因找到了，那就尝试解决一下。将这个耗时的操作放到子线程执行，这里也是参考了SDWebImage的图片编解码的思路，SD在拿到图片data的时候并没有将它直接转为image对象，而是在子线程里面做了一个解码的操作，这样已经被解码的图片就赋值给imageView的时候就不会再进行解码，也就不会妨碍主线程了。
 代码实现很简单，就是将图片的操作放入到一个全局队列中，当然也可以自己创建一个队列去执行这个异步操作。decodedImageWithImage:为SD的代码，需要#import "SDWebImageDecoder.h"
 */

/*
- (void)decodedImageWithImageName:(NSString *)imageName block:(void(^)(UIImage *image))block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @autoreleasepool{
            UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            image = [UIImage decodedImageWithImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(block)
                    block(image);
            });
        }
    });
}
 */

