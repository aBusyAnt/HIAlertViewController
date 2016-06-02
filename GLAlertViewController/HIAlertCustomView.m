//
//  HIAlertCustomView.m
//  SioEyeAPP
//
//  Created by Grey.Luo on 16/4/19.
//  Email:guohui.great@gmail.com
//  Blog: http://study1234.com
//

#import "HIAlertCustomView.h"

@implementation HIAlertCustomView
- (void)dismiss {
    if (_delegate) {
        [_delegate dismissAlertCustomView];
    }
}
@end
