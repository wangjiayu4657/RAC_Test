//
//  HomeViewController.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "JYBannerView.h"
#import "JYRecommendedView.h"
#import "JYOptionsView.h"


@interface HomeViewController ()
/** viewModel */
@property (nonatomic,strong) HomeViewModel *viewModel;
/** banner视图 */
@property (nonatomic,strong) JYBannerView *bannerView;
/** 操作视图 */
@property (nonatomic,strong) JYOptionsView *optionView;
/** 推荐视图 */
@property (nonatomic,strong) JYRecommendedView *recommendView;
/** 滚动视图 */
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation HomeViewController

- (instancetype)initWithViewModel:(HomeViewModel *)viewModel {
  if (self = [super init]) {
    _viewModel = viewModel;
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"首页";
  
  [self buildSubviews];
  [self bindData];
}

#pragma mark - 设置UI

- (void)buildSubviews {
  [self.view addSubview:self.scrollView];
  [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.view);
  }];
  
  [self.scrollView addSubview:self.bannerView];
  [self.bannerView makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(200);
    make.top.centerX.equalTo(self.scrollView);
    make.width.mas_equalTo(self.view);
  }];
  
  [self.scrollView addSubview:self.optionView];
  [self.optionView makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(160);
    make.width.equalTo(self.view);
    make.top.mas_equalTo(self.bannerView.mas_bottom);
  }];
  
  [self.scrollView addSubview:self.recommendView];
  [self.recommendView makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(420);
    make.width.mas_equalTo(self.view);
    make.centerX.mas_equalTo(self.scrollView);
    make.top.mas_equalTo(self.optionView.mas_bottom);
    make.bottom.equalTo(self.scrollView.mas_bottom);
  }];
}

#pragma mark - 绑定信号

- (void)bindData {
  self.optionView.viewModel = self.viewModel;
  self.optionView.sourceSignal = [self.viewModel.optionCommand execute:nil];
  self.bannerView.imageURLSignal = [self.viewModel.bannerCommand execute:nil];
  self.recommendView.domainSignal = [self.viewModel.domainCommand execute:nil];
  
  @weakify(self)
  [self.optionView.updateHeightSignal subscribeNext:^(id _Nullable x) {
    @strongify(self)
    CGFloat height = [x floatValue];
    [self.optionView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.height.mas_equalTo(height);
    }];
  }];
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView {
  return JY_LAZY(_scrollView, [[UIScrollView alloc] init]);
}

- (JYBannerView *)bannerView {
  return JY_LAZY(_bannerView, [[JYBannerView alloc] init]);
}

- (JYOptionsView *)optionView {
  return JY_LAZY(_optionView, [[JYOptionsView alloc] init]);
}

- (JYRecommendedView *)recommendView {
  return JY_LAZY(_recommendView, [[JYRecommendedView alloc] init]);
}

@end
