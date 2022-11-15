//
//  MessageProtocolImpl.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import "BookProtocolImpl.h"
#import "JYBookDomainModel.h"

@implementation BookProtocolImpl

- (RACSignal *)requestDomainDataSignalWithParam:(NSDictionary *)param {
  NSString *url = @"backorder/index";
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber> _Nonnull subscriber) {
   JYURLSessionTask *task = [JYNetWork postWithUrl:url refreshCache:YES params:param success:^(id _Nonnull response) {
      NSArray *source = [JYBookDomainModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"list"]];
      [subscriber sendNext:source];
      [subscriber sendCompleted];
    } fail:^(NSError * _Nonnull error) {
      [subscriber sendError:error];
    }];
    
    return [RACDisposable disposableWithBlock:^{
      [task cancel];
    }];
  }];
}

@end
