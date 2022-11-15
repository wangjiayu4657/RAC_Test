//
//  JYOptionsView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "JYOptionsView.h"
#import "JYJsonManager.h"
#import "JYOptionModel.h"
#import "HomeViewModel.h"
#import "JYOptionsCell.h"
#import "JYBookDetailController.h"

@interface JYOptionsView()

/** 网格视图 */
@property (nonatomic,strong) UICollectionView *collectionView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray<JYOptionModel *> *sources;
/** bind collectionView */
@property (nonatomic,strong) JYCollectionViewBindingHelper *optionHelper;
/** 选中cell时的信号 */
@property (nonatomic,strong) RACCommand *didSelectedCommand;

@end


@implementation JYOptionsView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self buildSubviews];
  }
  return self;
}

- (void)buildSubviews {
  [self addSubview:self.collectionView];
  [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  
  @weakify(self)
  [[self rac_signalForSelector:@selector(setViewModel:)] subscribeNext:^(RACTuple * _Nullable x) {
    @strongify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
      		CGFloat height = self.collectionView.contentSize.height; 
          [self.updateHeightSignal sendNext:@(height)];
          [self.updateHeightSignal sendCompleted];
      });
  }];
}

- (void)setSourceSignal:(RACSignal *)sourceSignal {
  _sourceSignal = sourceSignal;
  
  RACSignal *signal = [sourceSignal map:^id _Nullable(NSArray *_Nullable value) {
      return value.firstObject;
  }];

  self.optionHelper = [JYCollectionViewBindingHelper bindCollectionViewHelper:self.collectionView
                                                                     codeCell:[JYOptionsCell class]
                                                                       source:signal
                                                                    viewModel:self.viewModel
                                                           didSelectedCommand:self.didSelectedCommand];
  
}

#pragma mark - 数据处理

- (void)handlerCommand:(id)data {
  JYOptionModel *model = (JYOptionModel *)data;
  model.selected = !model.selected;
  
  [self.optionHelper reloadData];
  [JYRouterManager pushController:[JYBookDetailController new]];
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
  return JY_LAZY(_collectionView, ({
    CGFloat itemWidth = (SCREEN_WIDTH - 42) / 4;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(15, 15, 15, 15);
    collectionView.scrollEnabled = NO;
    collectionView;
  }));
}

- (NSMutableArray<JYOptionModel *> *)sources {
  return JY_LAZY(_sources, @[].mutableCopy);
}

- (RACSubject *)updateHeightSignal {
  return JY_LAZY(_updateHeightSignal, [RACSubject subject]);
}

- (RACCommand *)didSelectedCommand {
  return JY_LAZY(_didSelectedCommand, ({
    @weakify(self)
    RACCommand *didSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id _Nullable input) {
      @strongify(self)
      [self handlerCommand:input];
      return [RACSignal empty];
    }];
    didSelectedCommand;
  }));
}

@end
