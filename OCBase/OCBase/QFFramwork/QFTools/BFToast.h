#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#pragma mark - 1.在window上显示
@interface BFToast : NSObject
#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text;
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;
#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text;
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;
#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text;
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration;
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;
@end
#pragma mark - 2.在view上显示
@interface UIView (BFToast)
#pragma mark-中间显示
- (void)showXXToastCenterWithText:(NSString *)text;
- (void)showXXToastCenterWithText:(NSString *)text duration:(CGFloat)duration;
#pragma mark-上方显示
- (void)showXXToastTopWithText:(NSString *)text;
- (void)showXXToastTopWithText:(NSString *)text duration:(CGFloat)duration;
- (void)showXXToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;
- (void)showXXToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;
#pragma mark-下方显示
- (void)showXXToastBottomWithText:(NSString *)text;
- (void)showXXToastBottomWithText:(NSString *)text duration:(CGFloat)duration;
- (void)showXXToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;
- (void)showXXToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;
@end
