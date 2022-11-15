//
//  JYRouterManagere.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import "JYRouterManager.h"

@implementation JYRouterManager

+ (void)pushController:(UIViewController *)controller {
  UIViewController *ctrl = [[HTMediatorAction sharedInstance] performTarget:nil action:nil];
  [ctrl.navigationController pushViewController:controller animated:YES];
}

@end
