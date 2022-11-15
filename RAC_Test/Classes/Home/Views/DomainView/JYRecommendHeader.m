//
//  JYRecommendHeader.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import "JYRecommendHeader.h"
#import "JYReactiveViewDelegate.h"

@interface JYRecommendHeader()<JYReactiveViewDelegate>

/** 竖线 */
@property (nonatomic,strong) UIView *lineView;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLb;

@end

@implementation JYRecommendHeader

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self layoutViews];
  }
  return self;
}

- (void)layoutViews {
  [self addSubview:self.lineView];
  [self.lineView makeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(4);
    make.height.mas_equalTo(14);
    make.centerY.left.mas_equalTo(self);
  }];
  
  [self addSubview:self.titleLb];
  [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self);
    make.left.mas_equalTo(self.lineView.mas_right).offset(10);
  }];
}

#pragma mark - JYReactiveView

- (void)bindModel:(id)viewModel withParam:(NSDictionary *)params {
  NSIndexPath *indexPath = params[ModelOfIndexPath];
  self.titleLb.text = indexPath.section == 0 ? @"今日预订推荐" : @"预订竞价域名";
}


#pragma mark - 懒加载

- (UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor orangeColor];
  }
  return _lineView;
}

- (UILabel *)titleLb {
  if (!_titleLb) {
    _titleLb = [[UILabel alloc] init];
    _titleLb.font = [UIFont boldSystemFontOfSize:16];
    _titleLb.textColor = [UIColor colorHex:@"#333333"];
  }
  return _titleLb;
}


@end
