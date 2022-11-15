//
//  JYBookTopView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "JYBookTopView.h"

@interface JYBookTopView ()

/** 域名 */
@property (nonatomic,strong) UILabel *domainLb;
/** 最低价格 */
@property (nonatomic,strong) UILabel *priceLb;
/** 删除类型 */
@property (nonatomic,strong) UILabel *typeLb;
/** 删除日期 */
@property (nonatomic,strong) UILabel *dateLb;

@end

@implementation JYBookTopView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self buildSubviews];
  }
  return self;
}

- (void)buildSubviews {
  [self addSubview:self.domainLb];
  [self.domainLb makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.top.bottom.equalTo(self);
  }];
  
  [self addSubview:self.priceLb];
  [self.priceLb makeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(80);
    make.centerX.mas_equalTo(-15);
    make.top.bottom.equalTo(self);
    make.left.equalTo(self.domainLb.right).offset(10);
  }];
  
  [self addSubview:self.typeLb];
  [self.typeLb makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self);
    make.left.equalTo(self.priceLb.mas_right).offset(5);
  }];
  
  [self addSubview:self.dateLb];
  [self.dateLb makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-10);
    make.width.mas_equalTo(80);
    make.top.bottom.equalTo(self);
    make.left.equalTo(self.typeLb.mas_right).offset(5);
  }];
}

#pragma mark - 懒加载

- (UILabel *)domainLb {
  return JY_LAZY(_domainLb, ({
    UILabel *domainLb = [[UILabel alloc] init];
    domainLb.text = @"域名";
    domainLb.font = JYFont(14);
    domainLb.textAlignment = NSTextAlignmentCenter;
    domainLb.textColor = [UIColor colorHex:@"#333333"];
    domainLb;
  }));
}

- (UILabel *)priceLb {
  return JY_LAZY(_priceLb, ({
    UILabel *priceLb = [[UILabel alloc] init];
    priceLb.text = @"最低价格";
    priceLb.font = JYFont(14);
    priceLb.textAlignment = NSTextAlignmentCenter;
    priceLb.textColor = [UIColor colorHex:@"#333333"];
    priceLb;
  }));
}

- (UILabel *)typeLb {
  return JY_LAZY(_typeLb, ({
    UILabel *typeLb = [[UILabel alloc] init];
    typeLb.text = @"删除类型";
    typeLb.font = JYFont(14);
    typeLb.textAlignment = NSTextAlignmentCenter;
    typeLb.textColor = [UIColor colorHex:@"#333333"];
    typeLb;
  }));
}

- (UILabel *)dateLb {
  return JY_LAZY(_dateLb, ({
    UILabel *dateLb = [[UILabel alloc] init];
    dateLb.text = @"删除日期";
    dateLb.font = JYFont(14);
    dateLb.textAlignment = NSTextAlignmentCenter;
    dateLb.textColor = [UIColor colorHex:@"#333333"];
    dateLb;
  }));
}


@end
