//
//  LoginViewController.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "LoginViewModel.h"


@interface LoginViewController ()

/** logo */
@property (nonatomic,strong) UIImageView *logo;
/** 姓名输入视图 */
@property (nonatomic,strong) LoginInputView *accountView;
/** 密码输入视图 */
@property (nonatomic,strong) LoginInputView *passwordView;
/** 登录按钮 */
@property (nonatomic,strong) UIButton *loginBtn;
/** 登录视图模型 */
@property (nonatomic,strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
  [self buildSubviews];
  [self bindData];
}


#pragma mark - 设置UI

- (void)buildSubviews {
  [self.view addSubview:self.logo];
  [self.logo makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(120);
    make.centerX.equalTo(self.view);
    make.size.mas_equalTo(CGSizeMake(80, 80));
  }];
  
  [self.view addSubview:self.accountView];
  [self.accountView makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(15);
    make.right.mas_equalTo(-15);
    make.height.mas_equalTo(44);
    make.top.equalTo(self.logo.mas_bottom).offset(80);
  }];
  
  [self.view addSubview:self.passwordView];
  [self.passwordView makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.height.equalTo(self.accountView);
    make.top.equalTo(self.accountView.mas_bottom).offset(8);
  }];
  
  [self.view addSubview:self.loginBtn];
  [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(50);
    make.leading.trailing.equalTo(self.passwordView);
    make.top.equalTo(self.passwordView.mas_bottom).offset(16);
  }];
}


#pragma mark - 初始化

- (void)bindData {
  RAC(self.viewModel,user) = self.accountView.textSignal;
  RAC(self.viewModel,pwd) = self.passwordView.textSignal;
  self.loginBtn.rac_command = self.viewModel.command;
  [self.viewModel.enableSignal subscribeNext:^(id  _Nullable x) {
    self.loginBtn.enabled = [x boolValue];
  }];
}

#pragma mark - 懒加载

- (UIImageView *)logo {
  if (!_logo) {
    _logo = [[UIImageView alloc] init];
    _logo.image = BuilderImg(@"icon180px");
  }
  return _logo;
}

- (LoginInputView *)accountView {
  if (!_accountView) {
    _accountView = [[LoginInputView alloc] init];
    [_accountView initLeftImgName:@"login_user" placeHolder:@"请输入用户名"];
  }
  return _accountView;
}

- (LoginInputView *)passwordView {
  if (!_passwordView) {
    _passwordView = [[LoginInputView alloc] init];
    [_passwordView initLeftImgName:@"login_pwd" placeHolder:@"请输入密码"];
  }
  return _passwordView;
}

- (UIButton *)loginBtn {
  if (!_loginBtn) {
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = [UIColor orangeColor];
    _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [_loginBtn makeCornerWithRadius:4];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
  }
  return _loginBtn;
}

- (LoginViewModel *)viewModel {
  if (!_viewModel) {
    _viewModel = [[LoginViewModel alloc] init];
  }
  return _viewModel;
}


@end
