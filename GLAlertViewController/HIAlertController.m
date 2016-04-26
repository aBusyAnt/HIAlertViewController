//
//  HIAlertController.m
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://grayluo.github.io/WeiFocusIo/
//

#import "HIAlertController.h"
#import "Masonry.h"
#import <objc/runtime.h>
#define PROPERTY(property) NSStringFromSelector(@selector(property))
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define IOS_VERSION_LOWER_THAN_8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;
//+ (UIImage *)screenshot;
//- (UIImage *)bluredImage;
//- (void)bluerdImageWithCompletion:(void(^)(UIImage *bluerdImage))completion;
@end

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect frame = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    CGContextSaveGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//+ (UIImage *)screenshot {
//    CGSize imageSize = [UIScreen mainScreen].bounds.size;
//
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    if (IOS_VERSION_LOWER_THAN_8 && UIInterfaceOrientationIsLandscape(orientation)) {
//        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
//    }
//
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.0f);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
//        CGContextSaveGState(context);
//        CGContextTranslateCTM(context, window.center.x, window.center.y);
//        CGContextConcatCTM(context, window.transform);
//        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
//
//        if (IOS_VERSION_LOWER_THAN_8) {
//            if (orientation == UIInterfaceOrientationLandscapeLeft) {
//                CGContextRotateCTM(context, M_PI_2);
//                CGContextTranslateCTM(context, 0, -imageSize.width);
//            } else if (orientation == UIInterfaceOrientationLandscapeRight) {
//                CGContextRotateCTM(context, -M_PI_2);
//                CGContextTranslateCTM(context, -imageSize.height, 0);
//            } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
//                CGContextRotateCTM(context, M_PI);
//                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
//            }
//        }
//
//        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
//            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
//        } else {
//            [window.layer renderInContext:context];
//        }
//        CGContextRestoreGState(context);
//    }
//
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//- (UIImage *)bluredImage {
//    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer: @NO}];
//    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
//
//    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
//    [gaussianBlurFilter setDefaults];
//    [gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
//    [gaussianBlurFilter setValue:@5.0f forKey:kCIInputRadiusKey];
//
//    CIImage *result = [gaussianBlurFilter valueForKey:kCIOutputImageKey];
//    CGImageRef cgImage = [context createCGImage:result fromRect:inputImage.extent];
//
//    return [UIImage imageWithCGImage:cgImage];
//}
//
//- (void)bluerdImageWithCompletion:(void(^)(UIImage *bluerdImage))completion {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
//        UIImage *bluredImage = self.bluredImage;
//        dispatch_async(dispatch_get_main_queue(), ^(void) {
//            if (completion) {
//                completion(bluredImage);
//            }
//        });
//    });
//}

@end

//#pragma mark - MSAlertAnimation Class
//@interface MSAlertAnimation : NSObject <UIViewControllerAnimatedTransitioning>
//
//@property (assign, nonatomic) BOOL isPresenting;
//
//@end
//
//@implementation MSAlertAnimation
//
//static CGFloat const kAnimationDuration = 0.25f;
//
//- (void)executePresentingAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
//    CGSize windowSize = [UIScreen mainScreen].bounds.size;
//    if (IOS_VERSION_LOWER_THAN_8) {
//        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//        if (UIInterfaceOrientationIsLandscape(orientation)) {
//            windowSize.width = [UIScreen mainScreen].bounds.size.height;
//            windowSize.height = [UIScreen mainScreen].bounds.size.width;
//        }
//    }
//    UIView *containerView = [transitionContext containerView];
//
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    toViewController.view.frame = CGRectMake(0.0f, 0.0f, windowSize.width, windowSize.height);
//    toViewController.view.alpha = 0.0f;
//    toViewController.view.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
//    [containerView addSubview:toViewController.view];
//
//    [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
//        toViewController.view.alpha = 1.0f;
//        toViewController.view.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        }
//    }];
//}
//
//- (void)executeDismissingAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
//    CGSize windowSize = [UIScreen mainScreen].bounds.size;
//    if (IOS_VERSION_LOWER_THAN_8) {
//        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//        if (UIInterfaceOrientationIsLandscape(orientation)) {
//            windowSize.width = [UIScreen mainScreen].bounds.size.height;
//            windowSize.height = [UIScreen mainScreen].bounds.size.width;
//        }
//    }
//    UIView *containerView = [transitionContext containerView];
//
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    toViewController.view.frame = CGRectMake(0.0f, 0.0f, windowSize.width, windowSize.height);
//    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
//
//    [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
//        fromViewController.view.alpha = 0.0f;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        }
//    }];
//}
//
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
//    return kAnimationDuration;
//}
//
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    if(self.isPresenting){
//        [self executePresentingAnimation:transitionContext];
//    }
//    else{
//        [self executeDismissingAnimation:transitionContext];
//    }
//}
//
//@end


#pragma mark -
#pragma mark - MSAlertAction Class
@interface HIAlertAction ()

typedef void (^HIAlertActionHandler)(HIAlertAction *action);

@property (strong, nonatomic) HIAlertActionHandler handler;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) HIAlertActionStyle style;

@end

@implementation HIAlertAction

static NSDictionary *_defaultFonts = nil;
static NSDictionary *_defaultColors = nil;

+ (instancetype)actionWithTitle:(NSString *)title style:(HIAlertActionStyle)style handler:(HIAlertActionHandler)handler {
    return [[[self class] alloc] initWithTitle:title style:style handler:handler];
}

- (id)initWithTitle:(NSString *)title style:(HIAlertActionStyle)style handler:(HIAlertActionHandler)handler {
    self = [super init];
    if (self) {
        static dispatch_once_t token;
        dispatch_once(&token, ^(void) {
            _defaultFonts = @{
                              @(HIAlertActionStyleDestructive): [UIFont fontWithName:@"HelveticaNeue" size:18.0f],
                              @(HIAlertActionStyleDefault): [UIFont fontWithName:@"HelveticaNeue" size:18.0f],
                              @(HIAlertActionStyleCancel): [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]
                              };

            _defaultColors = @{
                               @(HIAlertActionStyleDestructive): [UIColor colorWithRed:1.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0f],
                               @(HIAlertActionStyleDefault): [UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f],
                               @(HIAlertActionStyleCancel): [UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f]
                               };
        });


        self.handler = handler;
        self.style = style;
        self.title = title;
        self.font = [self.defaultFonts objectForKey:@(style)];
        self.titleColor = [self.defaultColors objectForKey:@(style)];
        self.enabled = YES;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    HIAlertAction *clone = [[[self class] allocWithZone:zone] initWithTitle:_title style:_style handler:_handler];
    self.font = [_font copyWithZone:zone];
    self.titleColor = [_titleColor copyWithZone:zone];
    self.enabled = _enabled;
    return clone;
}

- (BOOL)isEnabled {
    return _enabled;
}

- (NSDictionary *)defaultFonts {
    return _defaultFonts;
}

- (NSDictionary *)defaultColors {
    return _defaultColors;
}

@end

//////////////////////////////////////////////////////////////////////

@interface HIAlertController ()<UIViewControllerTransitioningDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    UIColor *disabledColor;
}

@property (assign, nonatomic) HIAlertControllerStyle preferredStyle;
@property (copy, nonatomic) NSArray *actions;
@property (copy, nonatomic) NSArray *textFields;
@property (strong, nonatomic) UIButton *cancelButton;
//@property (strong, nonatomic) MSAlertAnimation *animation;

//views on alert
@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *tableViewContainer;
@property (strong, nonatomic) UITableView *tableView;

// Views on Table View
@property (strong, nonatomic) UIView *tableViewHeader;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIView *textFieldContentView;

//
@property (nonatomic) CGFloat tableHeaderHeight;
@property (nonatomic) CGFloat tableViewContainerHeight;

@property (weak,nonatomic) UIViewController *fromController;
@end

@implementation HIAlertController
static NSString *const kCellReuseIdentifier = @"Cell";
//static CGFloat const kTextFieldHeight = 20.0f;
static CGFloat const kTextFieldWidth = 234.0f;
static CGFloat const kActionRowHeight = 44.0f;
static CGFloat const kActionSheetBottomMarginHeight = 8.0f;
static CGFloat const kButtonCornerRadius = 6.0f;

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.preferredStyle == HIAlertControllerStyleActionSheet && [self cancelAction] != nil) {
        UIImage *normalImage = [UIImage imageWithColor:self.alertBackgroundColor];
        [self.cancelButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        UIImage *highlightedImage = [UIImage imageWithColor:[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f]];
        [self.cancelButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.preferredStyle == HIAlertControllerStyleActionSheet && !IOS_VERSION_LOWER_THAN_8) {
        //Appear with animation
        WS(ws);
        [self.tableViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view.mas_bottom).with.offset(-kActionSheetBottomMarginHeight);
        }];
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void) {
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {}];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.preferredStyle == HIAlertControllerStyleActionSheet && !IOS_VERSION_LOWER_THAN_8) {
        //Disappear with animation
        WS(ws);
        [self.tableViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view.mas_bottom).with.offset(ws.tableViewContainerHeight);
        }];
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(void) {
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {}];
    }
}


- (void)showInController:(UIViewController *)controller {
    if (self.preferredStyle == HIAlertControllerStyleActionSheet || self.preferredStyle == HIAlertControllerStyleAlert) {
        [self setupActions];
    }
    [self updateActions];

    self.fromController = controller;
    BOOL animated = NO;

    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    if (IOS_VERSION_LOWER_THAN_8) {
        controller.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [controller presentViewController:self animated:animated completion:^{
            [self exchangeMethodsToPreventReloadForController:controller];
        }];
        controller.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    } else {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [controller presentViewController:self animated:animated completion:^{
            [self exchangeMethodsToPreventReloadForController:controller];
        }];
    }
}

- (void)dismiss {
    BOOL animated = NO;
    [self dismissViewControllerAnimated:animated completion:^{
        [self exchangeMethodsToPreventReloadForController:self.fromController];
    }];
}

- (void)exchangeMethodsToPreventReloadForController:(UIViewController *)controller{
    SEL systemViewWillAppearSel = @selector(viewWillAppear:);
    SEL swizzViewWillAppearSel = @selector(swiz_viewWillAppear:);

    SEL systemViewDidAppearSel = @selector(viewDidAppear:);
    SEL swizzViewDidAppearSel = @selector(swiz_viewDidAppear:);

    [self exchangeSystemSel:systemViewWillAppearSel withSwizzSel:swizzViewWillAppearSel forController:controller];
    [self exchangeSystemSel:systemViewDidAppearSel withSwizzSel:swizzViewDidAppearSel forController:controller];
}
- (void)exchangeSystemSel:(SEL)systemSel withSwizzSel:(SEL)swizzSel forController:(UIViewController *)controller {
    Class class = [controller class];
    Method systemMethod = class_getInstanceMethod(class, systemSel);
    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
    BOOL isAdd= class_addMethod(class,systemSel,method_getImplementation(swizzMethod),method_getTypeEncoding(swizzMethod));
    if(isAdd) {
        class_replaceMethod(class,swizzSel,method_getImplementation(systemMethod),method_getTypeEncoding(systemMethod));
    }else {
        method_exchangeImplementations(systemMethod, swizzMethod);
    }
}
//Empty function to prevent viewWillAppear
- (void)swiz_viewWillAppear:(BOOL)animated {
    //    NSLog(@"[HIAlertViewController]-->swiz_viewWillAppear");
}
//Empty function to prevent viewDidAppear
- (void)swiz_viewDidAppear:(BOOL)animated {
    //    NSLog(@"[HIAlertViewController]-->viewDidAppear");
}
#pragma  mark - Init With title and message
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(HIAlertControllerStyle)preferredStyle {
    return [[[self class] alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
}
- (id)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(HIAlertControllerStyle)preferredStyle {
    self = [self initWithPreferredStyle:preferredStyle];
    if (self) {
        self.title = title;
        self.message = message;
    }
    return self;
}

+ (instancetype)alertControllerWithTitleAttributedString:(NSAttributedString *)titleAttributedString
                                 messageAttributedString:(NSAttributedString *)messageAttributedString
                                          preferredStyle:(HIAlertControllerStyle)preferredStyle {
    return [[[self class] alloc] initWithTitleAttributedString:titleAttributedString
                                       messageAttributedString:messageAttributedString
                                                preferredStyle:preferredStyle];
}

- (id)initWithTitleAttributedString:(NSAttributedString *)titleAttributedString
            messageAttributedString:(NSAttributedString *)messageAttributedString
                     preferredStyle:(HIAlertControllerStyle)preferredStyle{
    self = [self initWithPreferredStyle:preferredStyle];
    if (self) {
        self.titleAttributedString = titleAttributedString;
        self.messageAttributedString = messageAttributedString;
    }
    return self;
}

- (id)initWithPreferredStyle:(HIAlertControllerStyle)preferredStyle {
    self = [super init];
    if (self) {
        //        self.transitioningDelegate = self;

        if (preferredStyle == HIAlertControllerStyleAlert) {
            self.titleColor = [UIColor blackColor];
            self.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            self.messageColor = [UIColor blackColor];
            self.messageFont = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        } else {
            self.titleColor = [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
            self.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
            self.messageColor = [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:143.0f/255.0f alpha:1.0f];;
            self.messageFont = [UIFont fontWithName:@"HelveticaNeue" size:13.0f];
        }

        self.actions = [NSArray array];
        self.textFields = [NSArray array];
        self.preferredStyle = preferredStyle;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.2f;
        self.alertBackgroundColor = [UIColor whiteColor];
        self.separatorColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
        self.textFieldMargin = 0.0f;
        self.textFieldHeight = 20.0f;
        //        self.animation = [[MSAlertAnimation alloc] init];
        self.textFieldContainerMargin = 8.0f;
        self.titleMargin = 10.0f;
        self.messageMargin = 8.0f;
        disabledColor = [UIColor colorWithRed:131.0f/255.0f green:131.0f/255.0f blue:131.0f/255.0f alpha:1.0f];
    }
    return self;
}
#pragma mark - Init With Custom View
+ (instancetype)alertControllerWithView:(UIView *)view {
    return [[[self class] alloc]initWithView:view];
}

- (id)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.preferredStyle = HIAlertControllerStyleCustomView;
        self.customView = view;
        self.alpha = 0.5f;
        self.backgroundColor = [UIColor blackColor];

        [self.view addSubview:self.customView];
        self.customView.center = self.view.center;
    }
    return self;
}

- (void)setupBackgroundView {
    CGRect windowRect = [UIScreen mainScreen].bounds;
    WS(ws);

    NSInteger backgroundViewInsertIndex = 0;
    //    if (IOS_VERSION_LOWER_THAN_8) {
    //        self.imageView = [[UIImageView alloc]initWithFrame:windowRect];
    //        [self.view insertSubview:self.imageView atIndex:0];
    //        UIImage *screenshot = [UIImage screenshot];
    //        if (self.enabledBlurEffect) {
    //            self.imageView.image = screenshot.bluredImage;
    //        } else {
    //            self.imageView.image = screenshot;
    //        }
    //        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.edges.equalTo(ws.view);
    //        }];
    //        backgroundViewInsertIndex = 1;
    //    }

    self.backgroundView = [[UIView alloc]initWithFrame:windowRect];
    self.backgroundView.backgroundColor = self.backgroundColor;
    self.backgroundView.alpha = self.alpha;

    [self.view insertSubview:self.backgroundView atIndex:backgroundViewInsertIndex];

    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
#pragma mark - Setup views
- (void)setupTableView {

    WS(ws);

    CGRect windowBounds = [UIScreen mainScreen].bounds;
    self.view.frame = windowBounds;

    if (self.preferredStyle == HIAlertControllerStyleAlert) {
        self.tableViewContainer = [[UIView alloc]initWithFrame:windowBounds];
        [self.view addSubview:self.tableViewContainer];
        [self.tableViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.view);
        }];
    } else if(self.preferredStyle == HIAlertControllerStyleActionSheet) {
        self.tableViewContainer = [[UIView alloc]initWithFrame:CGRectMake(8, 441, 304, 119)];
        [self.view addSubview:self.tableViewContainer];
        CGFloat width = windowBounds.size.width;
        if (width > windowBounds.size.height) {
            width = windowBounds.size.height;
        }
        width -= 16.0f;

        [self.tableViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.view.mas_centerX);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(119);
            make.bottom.equalTo(ws.view.mas_bottom).with.offset(-kActionSheetBottomMarginHeight);
        }];
    }
    self.tableViewContainer.backgroundColor = [UIColor clearColor];
    self.tableViewContainer.translatesAutoresizingMaskIntoConstraints = NO;

    //
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 270, 144) style:UITableViewStylePlain];
    [self.tableViewContainer addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.preferredStyle == HIAlertControllerStyleAlert) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(ws.tableViewContainer);
            make.width.mas_equalTo(270);
            make.height.mas_equalTo(140);
        }];
    } else if(self.preferredStyle == HIAlertControllerStyleActionSheet) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.tableViewContainer.mas_top);
            make.bottom.equalTo(ws.tableViewContainer.mas_bottom);
            make.left.equalTo(ws.tableViewContainer.mas_left);
            make.right.equalTo(ws.tableViewContainer.mas_right);
        }];
    }
    self.tableView.layer.cornerRadius = 6.0f;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = self.separatorColor;
    if ([self.tableView respondsToSelector:@selector(layoutMargins)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];

}
- (void)setupTableHeader {

    WS(ws);

    self.tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 96)];
    CGFloat tableHeaderHeight = 0.0f;

    UIEdgeInsets titleLabelPadding = UIEdgeInsetsMake(self.titleMargin, 18, self.titleMargin, 18);
    CGFloat titleLabelWidth = self.tableViewHeader.bounds.size.width - titleLabelPadding.left - titleLabelPadding.right;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelPadding.left, 22, titleLabelWidth, 16)];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = self.titleColor;
    self.titleLabel.font = self.titleFont;
    [self.tableViewHeader addSubview:self.titleLabel];

    NSDictionary *options = @{ NSFontAttributeName : self.titleFont };
    CGRect boundingRect = CGRectZero;
    if (self.titleAttributedString) {
        self.titleLabel.attributedText = self.titleAttributedString;
        boundingRect = [self.titleLabel.attributedText boundingRectWithSize:CGSizeMake(titleLabelWidth, NSIntegerMax)
                                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                    context:nil];
    } else {
        self.titleLabel.text = self.title;
        options = @{ NSFontAttributeName : self.titleFont };
        boundingRect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(titleLabelWidth, NSIntegerMax)
                                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       attributes:options context:nil];

    }
    CGFloat titleLabelHeight = boundingRect.size.height;

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.tableViewHeader.mas_top).with.offset(titleLabelPadding.top);
        make.left.equalTo(ws.tableViewHeader.mas_left).with.offset(titleLabelPadding.left);
        make.right.equalTo(ws.tableViewHeader.mas_right).with.offset(-titleLabelPadding.right);
        make.height.mas_equalTo(titleLabelHeight);
    }];
    tableHeaderHeight += titleLabelPadding.top + titleLabelHeight;


    UIEdgeInsets messageLabelPadding = UIEdgeInsetsMake(self.messageMargin, 18, self.messageMargin, 18);
    CGFloat messageLabelWidth = titleLabelWidth;
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(messageLabelPadding.left, 46, messageLabelWidth, 14)];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = self.messageColor;
    self.messageLabel.font = self.messageFont;
    [self.tableViewHeader addSubview:self.messageLabel];

    if (self.messageAttributedString) {
        self.messageLabel.attributedText = self.messageAttributedString;
        boundingRect = [self.messageLabel.attributedText boundingRectWithSize:CGSizeMake(messageLabelWidth, NSIntegerMax)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                      context:nil];

    } else  {
        self.messageLabel.text = self.message;
        options = @{ NSFontAttributeName : self.messageFont };
        boundingRect = [self.messageLabel.text boundingRectWithSize:CGSizeMake(messageLabelWidth, NSIntegerMax)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:options context:nil];
    }
    CGFloat messageLabelHeight = boundingRect.size.height;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.titleLabel.mas_bottom).with.offset(messageLabelPadding.top);
        make.left.equalTo(ws.tableViewHeader.mas_left).with.offset(messageLabelPadding.left);
        make.right.equalTo(ws.tableViewHeader.mas_right).with.offset(-messageLabelPadding.right);
        make.height.mas_equalTo(messageLabelHeight);
    }];
    tableHeaderHeight += messageLabelPadding.top + messageLabelHeight;

    if ([self titleAndMessageIsNull]) {
        tableHeaderHeight = 0.0f;
    }

    //add textfield if need
    NSInteger textFieldCount = self.textFields.count;
    UIEdgeInsets textFieldContentViewPadding = UIEdgeInsetsMake(self.textFieldContainerMargin, 10, self.textFieldContainerMargin, 10);
    if (textFieldCount > 0) {
        self.textFieldContentView = [[UIView alloc]initWithFrame:CGRectZero];
        self.textFieldContentView.backgroundColor = [UIColor whiteColor];
        [self.tableViewHeader addSubview:self.textFieldContentView];
        [self.textFieldContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.tableViewHeader.mas_left).with.offset(textFieldContentViewPadding.left);
            make.right.equalTo(ws.tableViewHeader.mas_right).with.offset(-textFieldContentViewPadding.right);
            make.bottom.equalTo(ws.tableViewHeader.mas_bottom).with.offset(-textFieldContentViewPadding.bottom);
        }];
        tableHeaderHeight += textFieldContentViewPadding.top;

        CGFloat textFieldMarginH = self.textFieldMargin;
        __block CGFloat textFieldsTotalHeight = 0.0f;
        [self.textFields enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger index, BOOL *stop) {
            CGRect textFieldFrame = textField.frame;
            CGFloat theTextFieldHeight = textFieldFrame.size.height;
            [self.textFieldContentView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.textFieldContentView.mas_left);
                make.right.equalTo(ws.textFieldContentView.mas_right);
                make.height.mas_equalTo(theTextFieldHeight);
                make.top.equalTo(ws.textFieldContentView.mas_top).with.offset(textFieldsTotalHeight);
            }];

            textFieldsTotalHeight += (theTextFieldHeight + textFieldMarginH);
        }];

        CGFloat textFieldContentViewHeight = textFieldsTotalHeight ;
        [self.textFieldContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textFieldContentViewHeight);
        }];
        tableHeaderHeight += textFieldContentViewHeight;
        tableHeaderHeight += textFieldContentViewPadding.bottom;
    } else {
        tableHeaderHeight += messageLabelPadding.bottom;
    }

    //Add line between header and tableview
    UIView *line = nil;
    if (![self titleAndMessageIsNull]) {
        line = [[UIView alloc] init];
        line.backgroundColor = self.separatorColor;
        [self.tableViewHeader addSubview:line];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1.0);
            make.left.equalTo(ws.tableViewHeader.mas_left);
            make.right.equalTo(ws.tableViewHeader.mas_right);
            make.bottom.equalTo(ws.tableViewHeader.mas_bottom);
        }];
    }
    //create custom button while 2 actions
    NSInteger actionCount = self.actions.count;
    if (self.preferredStyle == HIAlertControllerStyleAlert && actionCount == 2) {
        UIView *actionContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        actionContainer.backgroundColor = [UIColor whiteColor];
        actionContainer.clipsToBounds = YES;
        [self.tableViewHeader addSubview:actionContainer];
        [actionContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.tableViewHeader.mas_left);
            make.right.equalTo(ws.tableViewHeader.mas_right);
            make.height.mas_equalTo(kActionRowHeight);
            make.bottom.equalTo(ws.tableViewHeader.mas_bottom);
        }];
        [self setupCustom2ButtonInView:actionContainer];
        //
        if(line) {
            [line mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(ws.tableViewHeader.mas_bottom).with.offset(-kActionRowHeight);
            }];
        }
        tableHeaderHeight += kActionRowHeight;

        if (textFieldCount > 0) {
            [self.textFieldContentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(ws.tableViewHeader.mas_bottom).with.offset(-(textFieldContentViewPadding.bottom+kActionRowHeight));
            }];
        }
    }

    //Update header frame
    CGRect headerFrame = self.tableViewHeader.frame;
    headerFrame.size.height = tableHeaderHeight;
    self.tableViewHeader.frame = headerFrame;

    self.tableHeaderHeight = tableHeaderHeight;
}
- (BOOL)titleAndMessageIsNull{
    return !self.title && !self.message && !self.titleAttributedString && !self.messageAttributedString;
}
- (void)setupCustom2ButtonInView:(UIView *)actionContrainer {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = self.separatorColor;
    [actionContrainer addSubview:line];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(actionContrainer.mas_top);
        make.bottom.equalTo(actionContrainer.mas_bottom);
        make.width.mas_equalTo(1.0f);
        make.center.equalTo(actionContrainer);
    }];

    for (int i = 0; i < self.actions.count; i++) {
        HIAlertAction *action = self.actions[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:action.title forState:UIControlStateNormal];
        if (button.enabled) {
            [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:disabledColor forState:UIControlStateNormal];
        }
        button.titleLabel.font = action.font;
        [button addTarget:self action:@selector(customButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [actionContrainer addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints = NO;

        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(actionContrainer.mas_top);
                make.left.equalTo(actionContrainer.mas_left);
                make.bottom.equalTo(actionContrainer.mas_bottom);
                make.right.equalTo(line.mas_left);
            }];
        }else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(actionContrainer.mas_top);
                make.left.equalTo(line.mas_right);
                make.bottom.equalTo(actionContrainer.mas_bottom);
                make.right.equalTo(actionContrainer.mas_right);
            }];
        }
    }
}

- (void)setupActions {
    [self setupTableView];
    [self setupTableHeader];
}

- (void)updateActions {
    WS(ws);
    self.view.frame = [UIScreen mainScreen].bounds;
    //background
    [self setupBackgroundView];
    //update tableContainer and table height
    if (self.preferredStyle == HIAlertControllerStyleAlert) {
        CGFloat tableTotalHeight = self.tableHeaderHeight - 1.0f;
        if (self.actions.count != 2) {
            tableTotalHeight  += (self.actions.count * kActionRowHeight);
        }
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(tableTotalHeight);
        }];
    } else if(self.preferredStyle == HIAlertControllerStyleActionSheet) {
        NSInteger actionCount = self.actions.count;
        HIAlertAction *cancelAction = [self cancelAction];
        if (cancelAction != nil) {
            actionCount--;
        }
        CGFloat tableViewHeight = actionCount * kActionRowHeight;
        CGFloat tableViewContainerBottomMargin = 0.0f;
        if (cancelAction != nil) {
            tableViewContainerBottomMargin = kActionRowHeight + kActionSheetBottomMarginHeight;
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(ws.tableViewContainer.mas_bottom).with.offset(-tableViewContainerBottomMargin);
            }];

            self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancelButton.userInteractionEnabled = cancelAction.enabled;
            self.cancelButton.layer.cornerRadius = kButtonCornerRadius;
            self.cancelButton.layer.masksToBounds = YES;
            [self.cancelButton setTitle:cancelAction.title forState:UIControlStateNormal];
            if (cancelAction.enabled) {
                [self.cancelButton setTitleColor:cancelAction.titleColor forState:UIControlStateNormal];
            } else {
                [self.cancelButton setTitleColor:disabledColor forState:UIControlStateNormal];
            }
            self.cancelButton.titleLabel.font = cancelAction.font;
            [self.cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.tableViewContainer addSubview:self.cancelButton];

            self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(ws.tableView.mas_bottom).with.offset(kActionSheetBottomMarginHeight);
                make.height.mas_equalTo(kActionRowHeight);
                make.left.equalTo(ws.tableViewContainer.mas_left);
                make.right.equalTo(ws.tableViewContainer.mas_right);
            }];
        }

        CGFloat tableViewContainerHeight = tableViewHeight + self.tableHeaderHeight + tableViewContainerBottomMargin - 0.5f;
        self.tableViewContainerHeight = tableViewContainerHeight;
        [self.tableViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(tableViewContainerHeight);
            if(!IOS_VERSION_LOWER_THAN_8) {
                make.bottom.equalTo(ws.view.mas_bottom).with.offset(tableViewContainerHeight);//Hide Before appear , show in didAppear with animation
            }
        }];
    }
}



- (HIAlertAction *)cancelAction {
    for (HIAlertAction *action in self.actions) {
        if (action.style == HIAlertActionStyleCancel) {
            return action;
        }
    }
    return nil;
}

- (void)cancelButtonTapped:(id)sender {
    HIAlertAction *action = [self cancelAction];
    if ([action isMemberOfClass:[HIAlertAction class]] && action.handler) {
        action.handler(action);
    }
    [self dismiss];
}

#pragma mark - MSAlertController Public Methods
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *))configurationHandler {
    if (self.preferredStyle != HIAlertControllerStyleAlert) {
        [NSException raise:@"NSInternalInconsistencyException" format:@"Text fields can only be added to an alert controller of style HIAlertControllerStyleAlert"];
        return;
    }

    NSMutableArray *textFields = self.textFields.mutableCopy;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kTextFieldWidth, self.textFieldHeight)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.borderWidth = 0.5f;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.delegate = self;

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.textFieldHeight)];
    paddingView.backgroundColor = [UIColor clearColor];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;

    if (configurationHandler) {
        configurationHandler(textField);
    }
    [textFields addObject:textField];
    self.textFields = textFields.copy;
}

- (void)addAction:(HIAlertAction *)action {
    NSMutableArray *actions = self.actions.mutableCopy;
    if (action.style == HIAlertActionStyleCancel) {
        for (HIAlertAction *aa in actions) {
            if (aa.style == HIAlertActionStyleCancel) {
                [NSException raise:@"NSInternalInconsistencyException" format:@"HIAlertController can only have one action with a style of HIAlertActionStyleCancel"];
                return;
            }
        }
    }

    [actions addObject:action];
    [actions enumerateObjectsUsingBlock:^(HIAlertAction *aa, NSUInteger index, BOOL *stop) {
        NSUInteger lastIndex = actions.count - 1;
        if (aa.style == HIAlertActionStyleCancel && lastIndex != index) {
            [actions exchangeObjectAtIndex:index withObjectAtIndex:lastIndex];
            *stop = YES;
            return;
        }
    }];
    self.actions = actions.copy;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.preferredStyle == HIAlertControllerStyleActionSheet && [self cancelAction] != nil) {
        return self.actions.count - 1;
    } else if (self.preferredStyle == HIAlertControllerStyleAlert) {
        return (self.actions.count == 2) ? 0 : self.actions.count;
    }
    return self.actions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];

    HIAlertAction *action = [self.actions objectAtIndex:indexPath.row];
    CGFloat totalWidth = self.tableView.frame.size.width;
    CGFloat textLabelRealWidth = totalWidth;
    if (action.icon) {
        CGSize iconSize = action.icon.size;
        NSDictionary *options = @{ NSFontAttributeName : action.font };
        CGFloat margin = 10.0f;
        CGFloat textLabelWidth = totalWidth - iconSize.width - margin;
        CGRect boundingRect = [action.title boundingRectWithSize:CGSizeMake(textLabelWidth, NSIntegerMax)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:options context:nil];

        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, iconSize.width, iconSize.height)];
        iconImageView.image = action.icon;
        [cell.contentView addSubview:iconImageView];

        CGFloat leftMargin = (totalWidth - iconSize.width - boundingRect.size.width) / 2.0;
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).with.offset(leftMargin);
            make.width.mas_equalTo(iconSize.width);
            make.centerY.equalTo(cell.contentView.mas_centerY);
        }];
        textLabelRealWidth = boundingRect.size.width + leftMargin;
    }
    if (action.title) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textLabelRealWidth, cell.frame.size.height)];
        titleLabel.text = action.title;
        titleLabel.textColor = action.titleColor;
        titleLabel.font = action.font;
        if (action.icon) {
            titleLabel.textAlignment = NSTextAlignmentLeft;
        } else {
            titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        [cell.contentView addSubview:titleLabel];

        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (action.icon) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.right.equalTo(cell.contentView.mas_right);
                make.width.mas_equalTo(textLabelRealWidth);
            } else {
                make.edges.equalTo(cell.contentView);
            }
        }];
        if (!action.enabled) {
            titleLabel.textColor = disabledColor;
        }
    }
    cell.separatorInset = UIEdgeInsetsZero;
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }

    cell.userInteractionEnabled = action.enabled;

    if (action.normalColor) {
        cell.backgroundColor = action.normalColor;
    } else {
        cell.backgroundColor = self.alertBackgroundColor;
    }

    if (action.highlightedColor) {
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = action.highlightedColor;
        cell.selectedBackgroundView = selectedBackgroundView;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGRectGetHeight(self.tableViewHeader.frame);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.tableViewHeader.backgroundColor = self.alertBackgroundColor;
    return self.tableViewHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HIAlertAction *action = [self.actions objectAtIndex:indexPath.row];
    if ([action isMemberOfClass:[HIAlertAction class]] && action.handler) {
        action.handler(action);
    }
    [self dismiss];
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}


#pragma mark - Custom Button
- (void)customButtonTaped:(UIButton *)button {
    NSInteger tag = button.tag;
    HIAlertAction *action = [self.actions objectAtIndex:tag];
    if ([action isMemberOfClass:[HIAlertAction class]] && action.handler) {
        action.handler(action);
    }
    [self dismiss];
}

#pragma mark - Keyboard Notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    WS(ws);
    //Only Care Alert,Only Alert support UITextField
    CGFloat bottomMargin = ([UIScreen mainScreen].bounds.size.height - kbSize.height ) / 2.0;
    [self.tableViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom).with.offset(-bottomMargin);
    }];
    [UIView animateWithDuration:0.3 animations:^(void) {
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {

    WS(ws);

    //Only Care Alert,Only Alert support UITextField

    [self.tableViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    [UIView animateWithDuration:0.3 animations:^(void) {
        [self.view layoutIfNeeded];
    }];
}

//#pragma mark - UIViewControllerTransitioningDelegate Methods
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    self.animation.isPresenting = YES;
//    return self.animation;
//}
//
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    self.animation.isPresenting = NO;
//    return self.animation;
//}

@end
