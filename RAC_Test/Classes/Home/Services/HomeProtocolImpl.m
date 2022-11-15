//
//  HomeProtocolImpl.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import "HomeProtocolImpl.h"
#import "JYBannerModel.h"
#import "JYDomainModel.h"

@implementation HomeProtocolImpl

- (RACSignal<NSArray <JYBannerModel *> *> *)requestBannerDataSignal:(NSString *)url {
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    JYURLSessionTask *task = [JYNetWork getWithUrl:url refreshCache:YES success:^(id  _Nonnull response) {
      NSArray *source = response[@"data"][@"list"];
      NSArray *models = [JYBannerModel mj_objectArrayWithKeyValuesArray:source];
      [subscriber sendNext:models];
      [subscriber sendCompleted];
    } fail:^(NSError * _Nonnull error) {
      [subscriber sendError:error];
    }];
    
    return [RACDisposable disposableWithBlock:^{
      [task cancel];
    }];
  }];
}

- (RACSignal<NSArray <JYDomainModel *> *> *)requestRecommendDataSignale:(NSString *)url {
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    JYURLSessionTask *task = [JYNetWork getWithUrl:url refreshCache:YES showHUD:@"loading..." success:^(id _Nonnull response) {
      NSArray *source = response[@"data"][@"list"];
      NSArray *models = [JYDomainModel mj_objectArrayWithKeyValuesArray:source];
      [subscriber sendNext:models];
      [subscriber sendCompleted];
    } fail:^(NSError * _Nonnull error) {
      [subscriber sendError:error];
    }];
    return [RACDisposable disposableWithBlock:^{
      [task cancel];
    }];
  }];
}

- (RACSignal<NSArray <JYDomainModel *> *> *)requestBiddingDataSignale:(NSString *)url {
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    JYURLSessionTask *task = [JYNetWork getWithUrl:url refreshCache:YES showHUD:@"loading..." success:^(id _Nonnull response) {
      NSArray *source = response[@"data"][@"list"];
      NSArray *models = [JYDomainModel mj_objectArrayWithKeyValuesArray:source];
      [subscriber sendNext:models];
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
