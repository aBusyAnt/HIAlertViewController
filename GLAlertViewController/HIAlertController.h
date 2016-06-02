//
//  HIAlertController.h
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://study1234.com
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HIAlertActionStyle) {
    HIAlertActionStyleDefault = 0,
    HIAlertActionStyleCancel,
    HIAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, HIAlertControllerStyle) {
    HIAlertControllerStyleActionSheet = 0,
    HIAlertControllerStyleAlert,
    HIAlertControllerStyleCustomView
};

@interface HIAlertAction : NSObject <NSCopying>

@property (copy, nonatomic, readonly) NSString *title;
@property (assign, nonatomic, readonly) HIAlertActionStyle style;
@property (assign, nonatomic, getter=isEnabled) BOOL enabled;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *highlightedColor;
@property (strong, nonatomic) UIImage *icon;//Only ActionSheet with style HIAlertActionStyleDefault and Alert action count is not equal 2 supported

+ (instancetype)actionWithTitle:(NSString *)title style:(HIAlertActionStyle)style handler:(void (^)(HIAlertAction *action))handler;

@end
/////////////////////////////////////////////////////
@interface HIAlertController : UIViewController

@property (copy, nonatomic, readonly) NSArray *actions;
@property (copy, nonatomic, readonly) NSArray *textFields;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) NSAttributedString *titleAttributedString;
@property (strong, nonatomic) NSAttributedString *messageAttributedString;
@property (assign, nonatomic, readonly) HIAlertControllerStyle preferredStyle;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIColor *messageColor;
@property (strong, nonatomic) UIFont *messageFont;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (assign, nonatomic) CGFloat alpha;
@property (strong, nonatomic) UIColor *alertBackgroundColor;
@property (strong, nonatomic) UIColor *separatorColor;
@property (assign, nonatomic) CGFloat textFieldContainerMargin;
@property (assign, nonatomic) CGFloat textFieldMargin;
@property (assign, nonatomic) CGFloat textFieldHeight;
@property (assign, nonatomic) CGFloat titleMargin;
@property (assign, nonatomic) CGFloat messageMargin;

@property (assign, nonatomic) BOOL enabledBlurEffect;

+ (instancetype)alertControllerWithView:(UIView *)view;
- (void)showInController:(UIViewController *)controller;
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message
                          preferredStyle:(HIAlertControllerStyle)preferredStyle;
+ (instancetype)alertControllerWithTitleAttributedString:(NSAttributedString *)titleAttributedString
                                 messageAttributedString:(NSAttributedString *)messageAttributedString
                                          preferredStyle:(HIAlertControllerStyle)preferredStyle;
- (void)dismiss;
- (void)addAction:(HIAlertAction *)action;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *))configurationHandler;

@end
