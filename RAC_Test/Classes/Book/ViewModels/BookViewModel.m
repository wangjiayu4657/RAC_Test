//
//  MessageViewModel.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import "BookViewModel.h"
#import "ViewModelServiceImpl.h"
#import "BookProtocolImpl.h"
#import "JYBookDomainModel.h"



@interface BookViewModel()
/** 临时 */
@property (nonatomic,strong) NSMutableArray *temp;
/** 服务类 */
@property (nonatomic,strong) id<ViewModelService> service;

@end


@implementation BookViewModel

- (instancetype)initWithService:(id<ViewModelService>)service {
  if (self = [super init]) {
    _service = service;
    [self initialize];
  }
  return self;
}

- (void)initialize {
  //数据源信号
  @weakify(self)
  self.sourceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
    @strongify(self)
    int page = [input intValue];
  
    NSDictionary *param = @{@"page":@(page)};
    return [[[self.service getMessageService] requestDomainDataSignalWithParam:param] doNext:^(id _Nullable x) {
      NSArray *source = (NSArray *)x;
      if (page == 1) {
        if (source.count > 0) {
          [self.temp removeAllObjects];
          [self.sources removeAllObjects];
        }
        self.temp = [source mutableCopy];
        self.sources = self.temp;
//        self.sources = [source mutableCopy];
      } else {
        [self.temp addObjectsFromArray:source];
        self.sources = self.temp;
//        [self.sources addObjectsFromArray:source];
      }
      
    }];
  }];
  
  //单选信号
  self.didSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(JYBookDomainModel *model) {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber> _Nonnull subscriber) {
      model.isSelected = !model.isSelected;
      [subscriber sendNext:model];
      [subscriber sendCompleted];
      return [RACDisposable disposableWithBlock:^{ }];
    }];
  }];
  
  //全选信号
  self.allSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      BOOL selected = [input boolValue];
      NSArray *source = [[self.sources.rac_sequence map:^id _Nullable(JYBookDomainModel *model) {
        model.isSelected = selected;
        return model;
      }] array];
      [subscriber sendNext:source];
      [subscriber sendCompleted];
      
      return [RACDisposable disposableWithBlock:^{ }];
    }];
  }];
  
  //组合选中和全选的信号
  self.selectedSetSignal = [self.didSelectedCommand.executionSignals.switchToLatest merge:self.allSelectedCommand.executionSignals.switchToLatest];
}

#pragma mark - 懒加载

- (NSMutableArray *)sources {
  return JY_LAZY(_sources, [NSMutableArray array]);
}

- (NSMutableArray *)temp {
  return JY_LAZY(_temp, [NSMutableArray array]);
}


@end
