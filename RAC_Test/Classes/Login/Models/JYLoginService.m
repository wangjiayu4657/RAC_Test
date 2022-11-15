//
//  JYLoginProtocolImp.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/27.
//

#import "JYLoginService.h"

@interface JYLoginService()

@end


@implementation JYLoginService

- (instancetype)initWithParam:(NSDictionary *)param {
  self = [super init];
  if (self) {
    [self loginRequestSignal:param];
  }
  return self;
}

- (RACSignal *)loginRequestSignal:(NSDictionary *)param {
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    JYURLSessionTask *task = [JYNetWork postWithUrl:@"login/index" refreshCache:NO showHUD:@"登陆中..." params:param success:^(id _Nonnull response) {
      NSLog(@"response == %@",response);
      [subscriber sendNext:@"xxx"];
      [subscriber sendCompleted];
    } fail:^(NSError * _Nonnull error) {
      NSLog(@"error == %@",error);
      [subscriber sendError:error];
    }];
    
    return [RACDisposable disposableWithBlock:^{
      [task cancel];
    }];
  }];
}

@end
