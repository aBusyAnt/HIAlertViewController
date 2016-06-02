//
//  ViewController.m
//  GLAlertViewController
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://study1234.com
//

#import "ViewController.h"
#import "HIAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)alertWithButtons:(UIButton *)sender {
    NSString *result = @"guohui009";
    NSString *title = NSLocalizedString(@"Welcome", nil);
    NSMutableAttributedString *titleAttributStr = [[NSMutableAttributedString alloc]initWithString:title
                                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                                                                     }];


    NSString *message = [NSString stringWithFormat:@"Welcome %@",result];

    NSMutableAttributedString *messageAttributStr = [[NSMutableAttributedString alloc]initWithString:message
                                                                                          attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                                                                                       }];
    [messageAttributStr setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:19]
                                        } range:[message rangeOfString:result]];


    HIAlertController *hiAlert = [HIAlertController alertControllerWithTitleAttributedString:titleAttributStr messageAttributedString:nil preferredStyle:HIAlertControllerStyleAlert];

    HIAlertAction *action1 = [HIAlertAction actionWithTitle:@"Default Button1" style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
    }];
    action1.titleColor = [UIColor blackColor];
    [hiAlert addAction:action1];

    HIAlertAction *action2 = [HIAlertAction actionWithTitle:@"Default Button2" style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
    }];
    action2.titleColor = [UIColor greenColor];
    [hiAlert addAction:action2];

    [hiAlert showInController:self];

}
- (IBAction)alertWith2Buttons:(UIButton *)sender {

}
- (IBAction)alertWithTextFields:(UIButton *)sender {
//    hiAlert.textFieldHeight = 40.0f;

    //    [hiAlert addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
    //        textfield.text = @"fdsfasfas";
    //        textfield.clearButtonMode = UITextFieldViewModeAlways;
    //        textfield.borderStyle = UITextBorderStyleNone;
    //        textfield.layer.borderColor = [UIColor greenColor].CGColor;
    //        textfield.layer.borderWidth = 0.5f;
    //        textfield.layer.cornerRadius = 6.0f;
    //
    //        weakSelf.nameField = textfield;
    //    }];
    //    [hiAlert addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
    //
    //    }];
    //    [hiAlert addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
    //
    //    }];
    //    [hiAlert addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
    //
    //    }];

}

- (IBAction)actionSheetWithCancel:(UIButton *)sender {
    NSString *result = @"guohui009";
    NSString *title = NSLocalizedString(@"SioeyeWelcom", nil);
    NSMutableAttributedString *titleAttributStr = [[NSMutableAttributedString alloc]initWithString:title
                                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                                                                     }];


    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"SioeyeIdRemind", nil),result];

    NSMutableAttributedString *messageAttributStr = [[NSMutableAttributedString alloc]initWithString:message
                                                                                          attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                                                                                       }];
    [messageAttributStr setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:19]
                                        } range:[message rangeOfString:result]];


    HIAlertController *hiAlert = [HIAlertController alertControllerWithTitleAttributedString:titleAttributStr messageAttributedString:messageAttributStr preferredStyle:HIAlertControllerStyleActionSheet];

    HIAlertAction *action1 = [HIAlertAction actionWithTitle:@"Cancel" style:HIAlertActionStyleCancel handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
    }];
    action1.titleColor = [UIColor blackColor];
    [hiAlert addAction:action1];

    HIAlertAction *action2 = [HIAlertAction actionWithTitle:@"Default Button2" style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
    }];
    action2.titleColor = [UIColor greenColor];
    [hiAlert addAction:action2];

    [hiAlert showInController:self];

}

- (IBAction)actionSheetWithoutCancel:(UIButton *)sender {
    NSString *result = @"guohui009";
    NSString *title = NSLocalizedString(@"SioeyeWelcom", nil);
    NSMutableAttributedString *titleAttributStr = [[NSMutableAttributedString alloc]initWithString:title
                                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                                                                     }];


    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"SioeyeIdRemind", nil),result];

    NSMutableAttributedString *messageAttributStr = [[NSMutableAttributedString alloc]initWithString:message
                                                                                          attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                                                                                       }];
    [messageAttributStr setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:19]
                                        } range:[message rangeOfString:result]];


    HIAlertController *hiAlert = [HIAlertController alertControllerWithTitleAttributedString:titleAttributStr messageAttributedString:messageAttributStr preferredStyle:HIAlertControllerStyleActionSheet];

    HIAlertAction *action1 = [HIAlertAction actionWithTitle:@"Default Button1" style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
    }];
    action1.titleColor = [UIColor blackColor];
    [hiAlert addAction:action1];

    HIAlertAction *action2 = [HIAlertAction actionWithTitle:@"Default Button2" style:HIAlertActionStyleDefault handler:^(HIAlertAction *action) {
        NSLog(@"Cancel action tapped %@", action);
    }];
    action2.titleColor = [UIColor greenColor];
    [hiAlert addAction:action2];

    [hiAlert showInController:self];
}
@end
