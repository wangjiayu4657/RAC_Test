//
//  JYRecommendCell.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import "JYRecommendCell.h"
#import "JYDomainModel.h"
#import "JYReactiveViewDelegate.h"

@interface JYRecommendCell()<JYReactiveViewDelegate>

/** 内容标签 */
@property (nonatomic,strong) UILabel *contentLb;

@end

@implementation JYRecommendCell

- (void)layoutSubviews {
  [super layoutSubviews];
	
  [self addSubview:self.contentLb];
  [self.contentLb makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
}

- (void)bindViewModel:(id)viewModel model:(id)model withParam:(NSDictionary *)params {
  JYDomainModel *domainModel = (JYDomainModel *)model;
  self.contentLb.text = domainModel.domain;
}

#pragma mark - 懒加载

- (UILabel *)contentLb {
  if (!_contentLb) {
    _contentLb = [[UILabel alloc] init];
    _contentLb.textColor = [UIColor orangeColor];
    _contentLb.font = [UIFont systemFontOfSize:14];
    _contentLb.textAlignment = NSTextAlignmentCenter;
    [_contentLb makeCornerRadius:2 borderColor:[UIColor colorHex:@"E9E9E9"]];
  }
  return _contentLb;
}


@end
