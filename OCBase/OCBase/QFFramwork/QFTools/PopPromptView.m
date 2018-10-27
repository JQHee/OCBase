//
//  PopPromptView.m
//  EsaiRegulations
//

#import "PopPromptView.h"

@implementation PopPromptView

/**
 *  单列模式初始化
 *
 *  @return 返回对象
 */
+ (id)initWithSingle {
    static PopPromptView *popPromptView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        popPromptView = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        popPromptView.tag = 8080;

        UITapGestureRecognizer *clickBGViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBGView)];
        [popPromptView addGestureRecognizer:clickBGViewTap];
        popPromptView.userInteractionEnabled = YES;
        popPromptView.backgroundColor = [UIColor clearColor];

        [popPromptView initLayer];

    });

    return popPromptView;

    /*
     self = [super initWithFrame:frame];
     if (self) {
     // Initialization code
     
     UITapGestureRecognizer *clickBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBGView:)];
     [self addGestureRecognizer:clickBGViewTap];
     //self.alpha = 0.0f;
     self.userInteractionEnabled = YES;
     self.backgroundColor = [UIColor clearColor];
     }
     return self;
     */
}

//初始化布局
- (void)initLayer {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.tag = 1010;
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    [self addSubview:bgView];

    UILabel *promptLabel = [UILabel new];
    promptLabel.font = [UIFont systemFontOfSize:14];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.lineBreakMode = NSLineBreakByWordWrapping;
    promptLabel.numberOfLines = 0; //上面两行设置多行显示
    promptLabel.frame = CGRectMake(8, 0, bgView.width - 16, bgView.height);
    promptLabel.tag = 100;
    promptLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //promptLabel.text = msg;
    [bgView addSubview:promptLabel];
}

/**
 *  显示提示信息
 *
 *  @param msg 提示信息
 */
+ (void)showMessage:(NSString *)msg {
    PopPromptView *popPromptView = [self initWithSingle];

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:popPromptView];

    UIView *bgView = [popPromptView viewWithTag:1010];
    UILabel *promptLabel = (UILabel *)[bgView viewWithTag:100];
    promptLabel.text = msg;

    bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    bgView.frame = CGRectMake((popPromptView.width - 5) / 2, 80, 10, 5);
    promptLabel.frame = CGRectMake(8, 0, bgView.width - 16, bgView.height);

    CGRect newFrame = CGRectMake((popPromptView.width - 210) / 2, 80, 210, 40);
    bgView.alpha = 0.0;

    [UIView animateWithDuration:0.3
        animations:^{
            bgView.alpha = 1.0;
            bgView.frame = newFrame;
        }
        completion:^(BOOL finished){

        }];

    [popPromptView performSelector:@selector(arriveTimeRemove) withObject:nil afterDelay:3.0];
}

//默认到达时间, 消失
- (void)arriveTimeRemove {
    [self clickPopPromptView];
}

//点击背景
+ (void)clickBGView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(arriveTimeRemove) object:nil];
    PopPromptView *popPromptView = [self initWithSingle];
    [popPromptView clickPopPromptView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(arriveTimeRemove) object:nil];
    [self clickPopPromptView];
}

- (void)clickPopPromptView {
    UIView *popView = [self viewWithTag:1010];

    [UIView animateWithDuration:0.2
        animations:^{
            popView.alpha = 0.0;
            popView.transform = CGAffineTransformMakeScale(0.1, 0.1);

        }
        completion:^(BOOL finished) {
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            [[keyWindow viewWithTag:8080] removeFromSuperview];
        }];
}

- (void)dealloc {
}

@end
