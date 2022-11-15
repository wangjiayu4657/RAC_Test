//
//  HomeViewModel.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import "HomeViewModel.h"
#import "HomeProtocolImpl.h"
#import "JYJsonManager.h"
#import "JYOptionModel.h"


@interface HomeViewModel()
/** 首页数据服务类 */
@property (nonatomic,strong) id<ViewModelService> service;

@end

@implementation HomeViewModel

- (instancetype)initWithService:(id<ViewModelService>)service {
  if (self = [super init]) {
    self.service = service;
    [self initialize];
  }
  
  return self;
}

- (void)initialize {
  
  @weakify(self)
  self.bannerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
    @strongify(self)
    return [[self.service getHomeService] requestBannerDataSignal:Banner_URL];
  }];
  
  self.optionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    return [JYJsonManager loadDataWithFileName:@"applys.json" toModel:@"JYOptionModel"];
  }];
  
  RACSignal<NSArray<JYDomainModel *> *> *biddingSignal = [[self.service getHomeService] requestBiddingDataSignale:Bidding_URL];
  RACSignal<NSArray<JYDomainModel *> *> *recommendSignal = [[self.service getHomeService] requestRecommendDataSignale:Recommend_URL];
  
  NSArray *signals = @[recommendSignal,biddingSignal];
  NSMutableArray *domains = [NSMutableArray array];
  
  self.domainCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
    return [RACSignal combineLatest:signals reduce:^id(NSArray *source1,NSArray *source2){
       [domains addObjectsFromArray:@[source1,source2]];
       return domains;
    }];
  }];
}

@end
