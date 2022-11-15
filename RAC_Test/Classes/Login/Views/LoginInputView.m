//
//  LoginInputView.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "LoginInputView.h"

@interface LoginInputView()

/** 背景视图 */
@property (nonatomic,strong) UIView *bgView;
/** 左边的图标 */
@property (nonatomic,strong) UIImageView *leftIcon;
/** 输入框 */
@property (nonatomic,strong) UITextField *inputTF;
/** 右边的按钮 */
@property (nonatomic,strong) UIButton *rightBtn;

@end

@implementation LoginInputView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self configUI];
  }
  return self;
}


#pragma mark - 对外暴露API

- (void)initLeftImgName:(NSString *)imgName placeHolder:(NSString *)placeHolder {
  self.leftIcon.image = BuilderImg(imgName);
  self.inputTF.placeholder = placeHolder;
  
  BOOL flag = [placeHolder isEqualToString:@"请输入用户名"];
  self.rightBtn.hidden = flag;
  self.inputTF.secureTextEntry = !flag;
}

- (void)setIsHiddenRightBtn:(BOOL)isHiddenRightBtn {
  _isHiddenRightBtn = isHiddenRightBtn;
  self.rightBtn.hidden = isHiddenRightBtn;
  
  [self.rightBtn updateConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(isHiddenRightBtn ? 0 : 20);
  }];
}


#pragma mark - 设置UI

- (void)configUI {
  [self addSubview:self.bgView];
  [self.bgView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  
  [self.bgView addSubview:self.leftIcon];
  [self.leftIcon makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.width.mas_equalTo(18);
    make.top.bottom.equalTo(self);
  }];
  
  [self.bgView addSubview:self.rightBtn];
  [self.rightBtn makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self);
    make.right.mas_equalTo(-15);
    make.width.mas_equalTo(20);
  }];
  
  [self.bgView addSubview:self.inputTF];
  [self.inputTF makeConstraints:^(MASConstraintMaker *make) {
    make.top.bottom.equalTo(self);
    make.right.equalTo(self.rightBtn.mas_left);
    make.left.equalTo(self.leftIcon.mas_right).offset(8);
  }];
}


#pragma mark - get 方法

- (NSString *)text {
  return self.inputTF.text;
}

- (RACSignal *)textSignal {
  return self.inputTF.rac_textSignal;
}

#pragma mark - 事件监听

- (void)rightBtnClick:(UIButton *)btn {
  btn.selected = !btn.selected;
  self.inputTF.secureTextEntry = !btn.selected;
}


#pragma mark - 懒加载

- (UIView *)bgView {
  if (!_bgView) {
    _bgView = [[UIView alloc] init];
    [_bgView makeCornerRadius:4 borderColor:[UIColor colorHex:@"#F7F7F7"]];
  }
  return _bgView;
}

- (UIImageView *)leftIcon {
  if (!_leftIcon) {
    _leftIcon = [[UIImageView alloc] init];
    _leftIcon.contentMode = UIViewContentModeCenter;
  }
  return _leftIcon;
}

- (UITextField *)inputTF {
  if (!_inputTF) {
    _inputTF = [[UITextField alloc] init];
    _inputTF.borderStyle = UITextBorderStyleNone;
  }
  return _inputTF;
}

- (UIButton *)rightBtn {
  if (!_rightBtn) {
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:BuilderImg(@"pwd_hidden") forState:UIControlStateNormal];
    [_rightBtn setImage:BuilderImg(@"pwd_show") forState:UIControlStateSelected];
    [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _rightBtn;
}

@end
