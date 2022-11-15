//
//  LoginViewModel.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "LoginViewModel.h"
#import "RACReturnSignal.h"
#import "JYLoginService.h"


@interface LoginViewModel()
@property (nonatomic,strong) JYLoginService *service;
@end

@implementation LoginViewModel

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initConfig];
  }
  return self;
}

#pragma mark - 初始化

- (void)initConfig {
  @weakify(self)
  self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self)
    NSDictionary *param = @{@"userKey":self.user,@"password":[self.pwd md5String],@"verifyCode":@""};
    NSLog(@"login param == %@",param);
    return [[self.service loginRequestSignal:param] doNext:^(id  _Nullable result) {
      NSLog(@"result === %@",result);
    }];
  }];
  
  [self.command.executionSignals.switchToLatest subscribeNext:^(NSString *value) {
    NSLog(@"接收到请求的数据");
  }];
  
  [[self.command.executing skip:1] subscribeNext:^(NSNumber *x) {
    BOOL flag = [x boolValue];
    NSString *msg = flag ? @"正在执行中..." : @"执行结束了";
    NSLog(@"msg == %@",msg);
  }];
}


#pragma mark - get 方法

- (RACSignal *)enableSignal {
  NSArray *signals = @[RACObserve(self, user),RACObserve(self, pwd)];
  return [RACSignal combineLatest:signals reduce:^id(NSString *user,NSString *pwd){
    return @(user.length && pwd.length);
  }];
}


#pragma mark - 网络请求

- (RACSignal<NSString *> *)startLoginRequest {
  return [RACReturnSignal return:@"发送请求数据"];
}


- (JYLoginService *)service {
  if (!_service) {
    _service = [[JYLoginService alloc] init];
  }
  return _service;
}


@end
