//
//  UIViewController+HIPresentTransparent.h
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://grayluo.github.io/WeiFocusIo/
//

#import <UIKit/UIKit.h>

@interface UIViewController (HIPresentTransparent)
- (void) presentTransparentViewController:(UIViewController *)viewControllerToPresent
                                 animated:(BOOL)flag
                               completion:(void (^)(void))completion;
@end
