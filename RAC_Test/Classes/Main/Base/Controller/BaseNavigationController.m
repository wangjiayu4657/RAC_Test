//
//  BaseNavigationController.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configNavigationBarAppearance];
}

#pragma mark - Public Method

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if (self.viewControllers.count > 0) {
    viewController.hidesBottomBarWhenPushed = YES;
    CGFloat leftDistance = CGRectGetWidth(MainScreenRect) / 3;
    viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = leftDistance;
    [self setUpCustomNavigationBarWithViewController:viewController];
  }
  [super pushViewController:viewController animated:animated];
}


#pragma mark - 设置全局的导航栏属性

- (void)configNavigationBarAppearance {
  if (@available(iOS 13.0, *)) {
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    appearance.backgroundColor = [UIColor colorWithHexStr:@"#F9752b"];
    appearance.titleTextAttributes = @{
      NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:JYSetFont(@"Noteworthy-Bold", 18)
    };
    
    self.navigationBar.standardAppearance = appearance;
    self.navigationBar.scrollEdgeAppearance = appearance;
    self.navigationBar.translucent = NO;
  } else {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = @{
      NSForegroundColorAttributeName: [UIColor whiteColor],
      NSFontAttributeName:JYSetFont(@"Noteworthy-Bold", 18)
    };
    
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    navigationBarAppearance.tintColor = [UIColor whiteColor];
    navigationBarAppearance.barTintColor = [UIColor colorWithHexStr:@"#F9752b"];
  }
}

- (void)btnLeftBtn {
  [self popViewControllerAnimated:YES];
}

- (void)setUpCustomNavigationBarWithViewController:(UIViewController *)viewController {
    UIBarButtonItem * item = [UIBarButtonItem itemWithTarget: self action:@selector(btnLeftBtn) image:@"navi_back"  selectImage:@"navi_back"];
    viewController.navigationItem.leftBarButtonItem = item;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

@end
