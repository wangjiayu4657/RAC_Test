//
//  JYBannerView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import "JYBannerView.h"
#import <SDCycleScrollView.h>
#import "JYBannerModel.h"
#import "HTWebViewModel.h"
#import "HTMediatorAction.h"
#import "HTMediatorAction+HTWebViewController.h"


@interface JYBannerView()<SDCycleScrollViewDelegate>
/** banner视图 */
@property (nonatomic,strong) SDCycleScrollView *bannerView;
/** 数据源 */
@property (nonatomic,strong) NSArray<JYBannerModel *> *source;
@end

@implementation JYBannerView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self layoutViews];
  }
  return self;
}

- (void)layoutViews {
  self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:self placeholderImage:nil];
  self.bannerView.pageControlBottomOffset = -5;
  [self addSubview:self.bannerView];
  [self.bannerView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self);
  }];
}

- (void)setImageURLSignal:(RACSignal<NSArray<JYBannerModel *> *> *)imageURLSignal {
  _imageURLSignal = imageURLSignal;

  @weakify(self)
  [imageURLSignal subscribeNext:^(NSArray<JYBannerModel *> *_Nullable models) {
    self.source = models;
    
    @strongify(self)
    self.bannerView.imageURLStringsGroup = [[models.rac_sequence map:^id(JYBannerModel *model) {
      return model.src;
    }] array];
  }];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  JYBannerModel *model = self.source[index];
  
  NSDictionary *params = @{WebTitlekey:@"",RequestURLkey:model.link,WebNavBarStyleTypekey:@(kWebNavBarStyleNomal)};
  HTWebViewModel *viewModel = [[HTWebViewModel alloc] initWithServices:nil params:params];
  [[HTMediatorAction sharedInstance] pushWebViewControllerWithViewModel:viewModel];
}

@end
