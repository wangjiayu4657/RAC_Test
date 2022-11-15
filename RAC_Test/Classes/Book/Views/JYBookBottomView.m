//
//  JYBookBottomView.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "JYBookBottomView.h"
#import "JYAlertView.h"


@interface JYBookBottomView()
/** 横线 */
@property (nonatomic,strong) UIView *line;
/** 全选 */
@property (nonatomic,strong) UIButton *allBtn;
/** 预订 */
@property (nonatomic,strong) UIButton *bookBtn;
@end

@implementation JYBookBottomView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self buildSubviews];
  }
  return self;
}

- (void)buildSubviews {
  [self addSubview:self.line];
  [self.line makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(1);
    make.left.top.right.equalTo(self);
  }];
  
  [self addSubview:self.allBtn];
  [self.allBtn makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.equalTo(self);
    make.top.equalTo(self.line.mas_bottom);
  }];
  
  [self addSubview:self.bookBtn];
  [self.bookBtn makeConstraints:^(MASConstraintMaker *make) {
    make.top.right.bottom.equalTo(self);
    make.left.equalTo(self.allBtn.mas_right);
    make.width.equalTo(self.allBtn.mas_width).multipliedBy(0.5);
  }];
}

- (void)setAllSelectedCommand:(RACCommand *)allSelectedCommand {
  _allSelectedCommand = allSelectedCommand;
}


#pragma mark - 事件监听

- (void)allBtnClick:(UIButton *)btn {
  btn.selected = !btn.selected;
  
  [_allSelectedCommand execute:@(btn.selected)];
}

- (void)bookBtnClick {
  NSString *content = @"是测容这是测试内容这是测试内容这是测试内容是测容这是测试内容这是测试";
  [JYAlertView showAlertContent:content callBack:^{
    NSLog(@"确定");
  }];
}

#pragma mark - 懒加载

- (UIView *)line {
  return JY_LAZY(_line, ({
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorHex:@"#F7F7F7"];
    line;
  }));
}

- (UIButton *)allBtn {
  return JY_LAZY(_allBtn, ({
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.titleLabel.font = JYFont(15);
    [allBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor colorHex:@"#333333"] forState:UIControlStateNormal];
    [allBtn setImage:BuilderImg(@"check_normal") forState:UIControlStateNormal];
    [allBtn setImage:BuilderImg(@"ture_selected") forState:UIControlStateSelected];
    allBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    allBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    allBtn;
  }));
}

- (UIButton *)bookBtn {
  return JY_LAZY(_bookBtn, ({
    UIButton *bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bookBtn.titleLabel.font = JYFont(15);
    bookBtn.backgroundColor = [UIColor orangeColor];
    [bookBtn setTitle:@"预订" forState:UIControlStateNormal];
    [bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookBtn addTarget:self action:@selector(bookBtnClick) forControlEvents:UIControlEventTouchUpInside];
    bookBtn;
  }));
}

@end
