//
//  JYRecommendedView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import "JYRecommendedView.h"
#import "JYRecommendCell.h"
#import "JYRecommendHeader.h"
#import "JYDomainModel.h"

@interface JYRecommendedView()

@property (nonatomic,strong) UICollectionView *collectionView;
/** cell选中时的信号 */
@property (nonatomic,strong) RACCommand *didSelectedCommand;
/** bind collectionView */
@property (nonatomic,strong) JYCollectionViewBindingHelper *helper;

@end

@implementation JYRecommendedView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self layoutViews];
  }
  return self;
}

#pragma mark - 设置UI

- (void)layoutViews {
  [self addSubview:self.collectionView];
  [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
}

- (void)setDomainSignal:(RACSignal *)domainSignal {
  _domainSignal = domainSignal;
  
  self.helper = [JYCollectionViewBindingHelper bindCollectionViewHelper:self.collectionView
                                                               codeCell:[JYRecommendCell class]
                                                          sectionHeader:[JYRecommendHeader class]
                                                                 source:domainSignal
                                                              viewModel:nil
                                                        selectedCommand:self.didSelectedCommand];
}

#pragma mark - 处理cell选中时的事件

- (void)handlerCommand:(id)data {
  JYDomainModel *model = (JYDomainModel *)data;
  NSLog(@"model.domain == %@",model.domain);
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
  if (!_collectionView) {
    CGFloat itemWidth = (SCREEN_WIDTH - 15 * 4) / 3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 14;
    layout.itemSize = CGSizeMake(itemWidth, 34);
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 64);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.contentInset = UIEdgeInsetsMake(10, 15, 10, 15);
  }
  return _collectionView;
}

- (RACCommand *)didSelectedCommand {
  if (!_didSelectedCommand) {
    	@weakify(self)
      _didSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id _Nullable input) {
      @strongify(self)
      [self handlerCommand:input];
      return [RACSignal empty];
    }];
  }
  return _didSelectedCommand;
}

@end
