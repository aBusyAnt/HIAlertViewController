//
//  HIAlertCustomView.h
//  SioEyeAPP
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://study1234.com
//

#import <UIKit/UIKit.h>

@protocol HIAlertCustomDismissDelegate <NSObject>
- (void)dismissAlertCustomView;
@end


@interface HIAlertCustomView : UIView
@property (nonatomic, weak) id<HIAlertCustomDismissDelegate> delegate;
- (void)dismiss;
@end
