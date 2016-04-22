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

# Reference
[MSAlertViewController](https://github.com/szk-atmosphere/MSAlertController)

# Usage

## Alert with button and UITextfield Example

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


## ActionSheet With Buttons,button include icon and title

    __weak typeof(self) weakSelf = self;

    NSMutableAttributedString *titleAttributStr = [[NSMutableAttributedString alloc]initWithString:NSLocalizedString(@"SelectTitle", nil)
                                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:0x999999],
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                                                                     }];
    HIAlertController *actionSheet = [HIAlertController alertControllerWithTitleAttributedString:titleAttributStr messageAttributedString:nil preferredStyle:HIAlertControllerStyleActionSheet];
    HIAlertAction *action1 = [HIAlertAction actionWithTitle:NSLocalizedString(@"Option1", nil) style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        [weakSelf genderChanged:HIGenderMale];
    }];
    action1.font = [UIFont systemFontOfSize:20];
    action1.titleColor = [UIColor colorWithRGBHex:0x000000];
    action1.icon = [UIImage imageNamed:@"Option1"];
    [actionSheet addAction:action1];

    HIAlertAction *action2 = [HIAlertAction actionWithTitle:NSLocalizedString(@"Option2", nil) style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        [weakSelf genderChanged:HIGenderFemale];
    }];
    action2.font = [UIFont systemFontOfSize:20];
    action2.titleColor = [UIColor colorWithRGBHex:0x000000];
    action2.icon = [UIImage imageNamed:@"Option2"];
    [actionSheet addAction:action2];

    HIAlertAction *action3 = [HIAlertAction actionWithTitle:NSLocalizedString(@"Option3", nil) style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        [weakSelf genderChanged:HIGenderOther];
    }];
    action3.font = [UIFont systemFontOfSize:20];
    action3.titleColor = [UIColor colorWithRGBHex:0x000000];
    action3.icon = [UIImage imageNamed:@"Option3"];
    [actionSheet addAction:action3];

    HIAlertAction *cancelAction = [HIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:HIAlertActionStyleCancel handler:^(HIAlertAction *action) {
    }];
    cancelAction.font = [UIFont systemFontOfSize:20];
    cancelAction.titleColor = [UIColor colorWithRGBHex:0x000000];
    [actionSheet addAction:cancelAction];

    [actionSheet showInController:self];



  

