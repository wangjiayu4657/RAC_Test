//
//  JYAlertView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "JYAlertView.h"
#import "NSString+Category.h"

@interface JYAlertView()
/** 内容背景视图 */
@property (nonatomic,strong) UIView *contentView;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLb;
/** 内容 */
@property (nonatomic,strong) UILabel *contentLb;
/** 按钮背景视图 */
@property (nonatomic,strong) UIStackView *stackView;
/** 左边按钮 */
@property (nonatomic,strong) UIButton *leftBtn;
/** 右边按钮 */
@property (nonatomic,strong) UIButton *rightBtn;

/** 回调函数 */
@property (nonatomic,strong) void(^callBack)(void);
@end

@implementation JYAlertView


+ (instancetype)share {
  static JYAlertView *alertView = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    alertView = [[JYAlertView alloc] initWithFrame:MainScreenRect];
    alertView.backgroundColor = [[UIColor colorHex:@"#333333"] colorWithAlphaComponent:0.36];
    [alertView buildSubviews];
  });
  return alertView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  if ([view isKindOfClass:[self class]]) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.15 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
      [self removeFromSuperview];
    });
  }
  return view;
}

#pragma mark - 设置UI

- (void)buildSubviews {
  [self addSubview:self.contentView];
  [self.contentView makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self);
    make.left.mas_equalTo(48);
    make.right.mas_equalTo(-48);
  }];
  
  [self.contentView addSubview:self.titleLb];
  [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-15);
    make.height.mas_equalTo(20);
    make.left.top.mas_equalTo(15);
  }];
  
  [self.contentView addSubview:self.contentLb];
  [self.contentLb makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(20);
    make.right.mas_equalTo(-20);
    make.top.equalTo(self.titleLb.mas_bottom).offset(15);
  }];

  [self.contentView addSubview:self.stackView];
  [self.stackView makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(20);
    make.right.mas_equalTo(-20);
    make.height.mas_equalTo(38);
    make.top.equalTo(self.contentLb.mas_bottom).offset(20);
    make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
  }];
}


#pragma mark - 对外暴露api

+ (void)showAlertContent:(NSString *)content callBack:(void (^)(void))callBack {
  [self showAlertTitle:@"提示" content:content actionNames:@[@"取消",@"确定"] callBack:callBack];
}

+ (void)showAlertTitle:(NSString *)title content:(NSString *)content callBack:(void (^)(void))callBack {
  [self showAlertTitle:title content:content actionNames:@[@"取消",@"确定"] callBack:callBack];
}

+ (void)showAlertTitle:(NSString *)title content:(NSString *)content actionNames:(NSArray<NSString *> *)actionNames callBack:(void (^)(void))callBack {
  [[JYAlertView share] showTitle:title content:content actionNames:actionNames callBack:callBack];
}


#pragma mark - 私有方法

///一个按钮
- (void)updateSingleBtnContraint:(NSArray *)actionNames {
  self.rightBtn.hidden = actionNames.count == 1;
  [self.leftBtn setTitle:actionNames.firstObject forState:UIControlStateNormal];
}

///两个按钮
- (void)updateDoubleBtnContraint:(NSArray *)actionNames {
  [self updateSingleBtnContraint:actionNames];

  self.rightBtn.hidden = actionNames.count == 1;
  [self.rightBtn setTitle:actionNames.lastObject forState:UIControlStateNormal];
}

///展示内容
- (void)showTitle:(NSString *)title content:(NSString *)content actionNames:(NSArray *)actionNames callBack:(void (^)(void))callBack {
  self.titleLb.text = title;
  self.contentLb.attributedText = content.lineSpace(8);
  self.callBack = callBack;
  
  if (actionNames.count == 1) {
    [self updateSingleBtnContraint:actionNames];
  } else if (actionNames.count == 2) {
    [self updateDoubleBtnContraint:actionNames];
  }
  
  [self layoutIfNeeded];
  
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  [window addSubview:self];
}

#pragma mark - 懒加载

- (UIView *)contentView {
  return JY_LAZY(_contentView, ({
    UIView *contentView = [[UIView alloc] init];
    [contentView makeCornerWithRadius:8];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView;
  }));
}

- (UILabel *)titleLb {
  return JY_LAZY(_titleLb, ({
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.font = JYBoldFont(18);
    titleLb.text = @"提示";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = [UIColor colorHex:@"#333333"];
    titleLb;
  }));
}

- (UILabel *)contentLb {
  return JY_LAZY(_contentLb, ({
    UILabel *contentLb = [[UILabel alloc] init];
    contentLb.font = JYFont(13);
    contentLb.numberOfLines = 0;
    contentLb.textAlignment = NSTextAlignmentCenter;
    contentLb.textColor = [UIColor colorHex:@"#333333"];
    contentLb;
  }));
}

- (UIStackView *)stackView {
  return JY_LAZY(_stackView, ({
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.leftBtn,self.rightBtn]];
    stackView.spacing = 15;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.backgroundColor = [UIColor whiteColor];
    stackView;
  }));
}

- (UIButton *)leftBtn {
  return JY_LAZY(_leftBtn, ({
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.titleLabel.font = JYFont(15);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorHex:@"#333333"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor colorHex:@"#F7F7F7"];
    [leftBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id _Nonnull sender) {
      [self removeFromSuperview];
    }];
    leftBtn;
  }));
}

- (UIButton *)rightBtn {
  return JY_LAZY(_rightBtn, ({
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = JYFont(15);
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorHex:@"#333333"] forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor colorHex:@"#F7F7F7"];
    [rightBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
      self.callBack ? self.callBack() : nil;
      [self removeFromSuperview];
    }];
    rightBtn;
  }));
}




@end
