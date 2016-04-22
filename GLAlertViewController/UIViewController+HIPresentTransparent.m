//
//  UIViewController+HIPresentTransparent.m
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://grayluo.github.io/WeiFocusIo/
//

#import "UIViewController+HIPresentTransparent.h"

@implementation UIViewController (HIPresentTransparent)
- (void)presentTransparentViewController:(UIViewController *)viewControllerToPresent
                                animated:(BOOL)flag
                              completion:(void (^)(void))completion
{
#define SYSTEM_VERSION_LESS_THAN(x)  ([[UIDevice currentDevice] systemVersion].floatValue < x)
    if(SYSTEM_VERSION_LESS_THAN(8.0)) {
        [self presentIOS7TransparentController:viewControllerToPresent withCompletion:completion];
    }else{
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:viewControllerToPresent animated:YES completion:completion];
    }
}
-(void)presentIOS7TransparentController:(UIViewController *)viewControllerToPresent
                         withCompletion:(void(^)(void))completion
{
//    UIViewController *presentingVC = self;
//    UIViewController *root = self;
//    while (root.parentViewController) {
//        root = root.parentViewController;
//    }
//    UIModalPresentationStyle orginalStyle = root.modalPresentationStyle;
//    root.modalPresentationStyle = UIModalPresentationCurrentContext;
//    [presentingVC presentViewController:viewControllerToPresent animated:YES completion:^{
//        root.modalPresentationStyle = orginalStyle;
//    }];
#define kHIAppDelegate [[UIApplication sharedApplication] delegate]
    kHIAppDelegate.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext|UIModalPresentationFullScreen;
    [kHIAppDelegate.window.rootViewController presentViewController:viewControllerToPresent animated:YES completion:^{
        viewControllerToPresent.view.backgroundColor=[UIColor clearColor];
    }];
}
@end
