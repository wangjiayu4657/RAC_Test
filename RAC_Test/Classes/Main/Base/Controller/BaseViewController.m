//
//  BaseViewController.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseViewController.h"


@interface BaseViewController ()
/** 安全区域 */
@property (nonatomic,assign,readwrite) UIEdgeInsets safeAreaInsets;
@end

@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
//  导航栏透明的情况下,frame从导航栏下面开始
//  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.view.backgroundColor = [UIColor whiteColor];
}


- (void)buildSubviews {
  
}

- (void)handlerCommand:(id)data {
  
}

@end
