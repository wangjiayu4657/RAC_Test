//
//  JYBookDomainCell.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import "JYBookDomainCell.h"
#import "JYBookDomainModel.h"
#import "BookViewModel.h"

@interface JYBookDomainCell()

/** 操作按钮 */
@property (nonatomic,strong) UIButton *optionBtn;
/** 最低价格 */
@property (nonatomic,strong) UILabel *domainLb;
/** 最低价格 */
@property (nonatomic,strong) UILabel *priceLb;
/** 删除类型 */
@property (nonatomic,strong) UILabel *delTypeLb;
/** 删除日期 */
@property (nonatomic,strong) UILabel *delDateLb;

/** 数据模型 */
@property (nonatomic,strong) JYBookDomainModel *model;
/** 视图模型 */
@property (nonatomic,strong) BookViewModel *viewModel;

@end


@implementation JYBookDomainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self buildSubviews];
  }

  return self;
}

- (void)buildSubviews {
  [self.optionBtn makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.width.mas_equalTo(28);
    make.top.bottom.equalTo(self);
  }];
  
  [self.domainLb makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self);
    make.left.equalTo(self.optionBtn.mas_right).offset(8);
    make.right.equalTo(self.priceLb.mas_left).offset(-8);
  }];
  
  [self.priceLb makeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(80);
    make.centerX.mas_equalTo(-15);
    make.top.bottom.equalTo(self);
  }];
  
  [self.delTypeLb makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self);
    make.left.equalTo(self.priceLb.mas_right).offset(5);
    make.right.equalTo(self.delDateLb.mas_left);
  }];
  
  [self.delDateLb makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-10);
    make.width.mas_equalTo(80);
    make.top.bottom.equalTo(self);
  }];
}


#pragma mark - JYReactiveViewDelegate

- (void)bindViewModel:(id)viewModel model:(id)model withParam:(NSDictionary *)params {
  self.viewModel = (BookViewModel *)viewModel;
  JYBookDomainModel *domainModel = (JYBookDomainModel *)model;
  self.model = domainModel;
  
  self.domainLb.text = domainModel.domain;
  self.priceLb.text = domainModel.price;
  self.delDateLb.text = domainModel.delete_time_msg;
  self.delTypeLb.text = domainModel.delete_type_value;
  [self.optionBtn setImage:domainModel.icon forState:UIControlStateNormal];
}


#pragma mark - 懒加载

- (UIButton *)optionBtn {
  return JY_LAZY(_optionBtn, ({
    UIButton *optionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [optionBtn setImage:BuilderImg(@"check_normal") forState:UIControlStateNormal];
    [optionBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id _Nonnull sender) {
      [self.viewModel.didSelectedCommand execute:self.model];
    }];
    [self addSubview:optionBtn];
    optionBtn;
  }));
}

- (UILabel *)domainLb {
  return JY_LAZY(_domainLb, ({
    UILabel *domainLb = [[UILabel alloc] init];
    domainLb.numberOfLines = 0;
    domainLb.font = [UIFont systemFontOfSize:12];
    domainLb.textAlignment = NSTextAlignmentLeft;
    domainLb.textColor = [UIColor colorWithHex:0x333333];
    [self addSubview:domainLb];
    domainLb;
  }));
}

- (UILabel *)priceLb {
  return JY_LAZY(_priceLb, ({
    UILabel *priceLb = [[UILabel alloc] init];
    priceLb.font = [UIFont systemFontOfSize:12];
    priceLb.textAlignment = NSTextAlignmentCenter;
    priceLb.textColor = [UIColor orangeColor];
    [self addSubview:priceLb];
    priceLb;
  }));
}

- (UILabel *)delTypeLb {
  return JY_LAZY(_delTypeLb, ({
    UILabel *delTypeLb = [[UILabel alloc] init];
    delTypeLb.font = [UIFont systemFontOfSize:12];
    delTypeLb.textAlignment = NSTextAlignmentCenter;
    delTypeLb.textColor = [UIColor colorWithHex:0x333333];
    [self addSubview:delTypeLb];
    delTypeLb;
  }));
}

- (UILabel *)delDateLb {
  return JY_LAZY(_delDateLb, ({
    UILabel *delDateLb = [[UILabel alloc] init];
    delDateLb.font = [UIFont systemFontOfSize:12];
    delDateLb.textAlignment = NSTextAlignmentCenter;
    delDateLb.textColor = [UIColor colorWithHex:0x333333];
    [self addSubview:delDateLb];
    delDateLb;
  }));
}


@end
