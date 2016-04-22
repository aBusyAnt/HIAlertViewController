# HIAlertViewController
A Custom AlertViewController like UIAlertViewController after iOS8, I write this to Compatible with iOS7.

# Style
+  Alert
+  ActionSheet

# Views Supported To Added 
+  UIButton
+  UITextField
+  UIView

# Custom(Your Can custom any view)
+  Font
+  Color

# Run System Required 
iOS7+

# Build Depends
[Masonry](https://github.com/SnapKit/Masonry)
Apple's Autolayout is so ugly,So I layout views with Masonry.
#Reference
[MSAlertViewController](https://github.com/szk-atmosphere/MSAlertController)

#Usage
    //@property (weak, nonatomic) UITextField *nameField;

    __weak __typeof(&*self)weakSelf = self;

    HIAlertController *hiAlert = [HIAlertController alertControllerWithTitle:title message:message preferredStyle:HIAlertControllerStyleAlert];
    HIAlertAction *action = [HIAlertAction actionWithTitle:@"OK" style:HIAlertActionStyleCancel handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
        NSLog(@"weakSelf.nameField:%@",self.nameField);
    }];
    action.titleColor = [UIColor blackColor];
    [hiAlert addAction:action];

    hiAlert.textFieldHeight = 40.0f;
    [hiAlert addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
        textfield.text = @"Grey.Luo";
        textfield.clearButtonMode = UITextFieldViewModeAlways;
        textfield.borderStyle = UITextBorderStyleNone;
        textfield.layer.borderColor = [UIColor greenColor].CGColor;
        textfield.layer.borderWidth = 0.5f;
        textfield.layer.cornerRadius = 6.0f;

        weakSelf.nameField = textfield;
    }];

    [hiAlert showInController:self animated:YES];

  

