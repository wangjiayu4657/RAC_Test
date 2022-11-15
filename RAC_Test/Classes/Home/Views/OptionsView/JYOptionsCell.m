//
//  JYOptionsCell.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "JYOptionsCell.h"
#import "JYReactiveViewDelegate.h"
#import "JYOptionModel.h"
#import "UIFont+Category.h"
#import "HomeViewModel.h"


@interface JYOptionsCell()<JYReactiveViewDelegate>

/** 标题 */
@property (nonatomic,strong) UILabel *titleLb;
/** 图片 */
@property (nonatomic,strong) UIImageView *iconView;
/** 操作按钮 */
@property (nonatomic,strong) UIButton *optionBtn;
/** 视图模型 */
@property (nonatomic,strong) HomeViewModel *homeViewModel;

@end


@implementation JYOptionsCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self buildSubviews];
  }
  return self;
}

#pragma mark - 设置UI

- (void)buildSubviews {
  [self addSubview:self.iconView];
  [self.iconView makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(0);
    make.centerX.equalTo(self);
    make.size.mas_equalTo(CGSizeMake(36 * kCurrentPoint, 36 * kCurrentPoint));
  }];
  
  [self addSubview:self.titleLb];
  [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self);
    make.top.equalTo(self.iconView.mas_bottom).offset(8 * kCurrentPoint);
  }];
  
  [self addSubview:self.optionBtn];
  [self.optionBtn makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(6);
    make.right.mas_equalTo(-6);
    make.size.mas_equalTo(CGSizeMake(22, 22));
  }];
}

#pragma mark - JYReactiveViewDelegate

- (void)bindViewModel:(id)viewModel model:(id)model withParam:(NSDictionary *)params {
  _homeViewModel = (HomeViewModel *)viewModel;
  JYOptionModel *optionModel = (JYOptionModel *)model;
  
  self.titleLb.text = optionModel.name;
  self.iconView.image = BuilderImg(optionModel.image);
  [self.optionBtn setImage:optionModel.icon forState:UIControlStateNormal];
}

#pragma mark - 懒加载

- (UIImageView *)iconView {
  return JY_LAZY(_iconView, ({
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView;
  }));
}

- (UILabel *)titleLb {
  return JY_LAZY(_titleLb, ({
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.font = JYFont(13);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = [UIColor colorWithHexStr:@"#333333"];
    titleLb;
  }));
}

- (UIButton *)optionBtn {
  return JY_LAZY(_optionBtn, ({
    UIButton *optionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    optionBtn.hidden = YES;
    optionBtn;
  }));
}

@end
