//
//  BaseTabBarController.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "BookViewController.h"
#import "ServiceViewController.h"
#import "ProfileViewController.h"

#import "ViewModelServiceImpl.h"
#import "HomeViewModel.h"
#import "BookViewModel.h"


@interface BaseTabBarController ()
/** 数据服务类 */
@property (nonatomic,strong) ViewModelServiceImpl *serviceImpl;
/** 首页视图模型 */
@property (nonatomic,strong) HomeViewModel *homeViewModel;
/** 消息页视图模型 */
@property (nonatomic,strong) BookViewModel *bookViewModel;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configController];
  [self configTarbarItem];
}

#pragma mark - 初始化控制器

- (void)configController {
  
  self.serviceImpl = [[ViewModelServiceImpl alloc] initModelServiceImpl];
  
  self.homeViewModel = [[HomeViewModel alloc] initWithService:self.serviceImpl];
  HomeViewController *home = [[HomeViewController alloc] initWithViewModel:self.homeViewModel];
  BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:home];
  
  self.bookViewModel = [[BookViewModel alloc] initWithService:self.serviceImpl];
  BookViewController *message = [[BookViewController alloc] initWithViewModel:self.bookViewModel];
  BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:message];
  
  ServiceViewController *service = [[ServiceViewController alloc] init];
  BaseNavigationController *serviceNav = [[BaseNavigationController alloc] initWithRootViewController:service];
  
  ProfileViewController *profile = [[ProfileViewController alloc] init];
  BaseNavigationController *profileNav = [[BaseNavigationController alloc] initWithRootViewController:profile];
  
  self.viewControllers = @[homeNav,messageNav,serviceNav,profileNav];
}

- (void)configTarbarItem {
  NSArray *titles = @[@"首页", @"消息", @"服务", @"我的"];
  NSArray *highImgs = @[@"tab_home_selected", @"tab_reserve_selected", @"tab_oneprice_selected", @"tab_my_selected"];
  NSArray *normalImgs = @[@"tab_home_normal", @"tab_reserve_normal", @"tab_oneprice_normal", @"tab_my_normal"];
  
  self.tabBar.translucent = NO;
  [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
    item.title = titles[idx];
    item.image = BuilderImg(normalImgs[idx]);
    item.selectedImage = BuilderImg(highImgs[idx]);
  }];
  
  UITabBar *tabBar = [UITabBar appearance];
  tabBar.tintColor = [UIColor colorHex:@"#F9752b"];
  tabBar.unselectedItemTintColor = [UIColor grayColor];
  tabBar.backgroundColor = [UIColor colorHex:@"#F7F7F7"];
  
}
@end
