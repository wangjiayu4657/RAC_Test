//
//  JYJsonManager.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "JYJsonManager.h"

@implementation JYJsonManager

+ (RACSignal *)loadDataWithFileName:(NSString *)fileName {
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *datas = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [subscriber sendNext:datas];
    [subscriber sendCompleted];
    return [RACDisposable disposableWithBlock:^{}];
  }];
}

+ (RACSignal *)loadDataWithFileName:(NSString *)fileName toModel:(NSString *)modelName {
  Class cls = NSClassFromString(modelName);
  return [[self loadDataWithFileName:fileName] map:^id _Nullable(NSArray *_Nullable datas) {
    return [[datas.rac_sequence map:^id _Nullable(NSArray *_Nullable values) {
      return [cls mj_objectArrayWithKeyValuesArray:values];
    }] array];
  }];
}

@end
