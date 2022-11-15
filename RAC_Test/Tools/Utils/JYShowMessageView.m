//
//  JYShowMessageView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/10.
//

#import "JYShowMessageView.h"
#import <MMProgressHUD.h>


@implementation JYShowMessageView

+ (void)showErrorWithMessage:(NSString *)message {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD dismissWithError:nil title:message afterDelay:2.0];
}

+ (void)showSuccessWithMessage:(NSString *)message {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD dismissWithSuccess:nil title:message afterDelay:2.0];
}

+ (void)showStatusWithMessage:(NSString *)message {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD showWithTitle:nil status:message];
}

+ (void)dismissSuccessView:(NSString *)message {
   [MMProgressHUD dismissWithSuccess:message];
}

+ (void)dismissErrorView:(NSString *)message {
    [MMProgressHUD dismissWithError:message];
}

@end
