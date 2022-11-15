//
//  AppDelegate.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "LoginViewController.h"
#import "JYServerConfig.h"
#import "JYAppDotNetAPIClient.h"
#import "MLeaksFinder.h"


@interface AppDelegate ()
@property (nonatomic,strong) BaseTabBarController *tabBarCtrl;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self initRootController];
  [JYServerConfig setJYConfigEnv:@"01"];
  return YES;
}

///初始化根控制器
- (void)initRootController {
  BOOL islogin = YES;
  if (islogin) {
    self.tabBarCtrl = [[BaseTabBarController alloc] init];
    self.window.rootViewController = self.tabBarCtrl;
  } else {
    self.window.rootViewController = [[LoginViewController alloc] init];
  }
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
}


@end
