//
//  JYBookDetailController.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "JYBookDetailController.h"


@interface JYBookDetailController()

/** 内容标签 */
@property (nonatomic,strong) UILabel *contentLb;
/** UIVisualEffectView */
@property (nonatomic,strong) UIVisualEffectView *effectView;
@property (nonatomic,strong) UIVisualEffectView *subEffectView;

@end

@implementation JYBookDetailController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"预订详情";
 
  [self buildSubviews];
}

- (void)buildSubviews {
  self.view.backgroundColor = [UIColor colorHex:@"#E9E9E9"];
 
  [self.subEffectView.contentView addSubview:self.contentLb];
  [self.contentLb makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.subEffectView);
  }];
  
  [self.effectView.contentView addSubview:self.subEffectView];
  [self.subEffectView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.effectView);
  }];
  
  [self.view addSubview:self.effectView];
  [self.effectView makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(80);
    make.height.mas_equalTo(160);
    make.left.right.equalTo(self.view);
  }];
}

#pragma mark - 懒加载

- (UILabel *)contentLb {
  return JY_LAZY(_contentLb, ({
    UILabel *contentLb = [[UILabel alloc] init];
    contentLb.font = JYFont(40);
    contentLb.text = @"hello world";
    contentLb.textColor = [UIColor whiteColor];
    contentLb.textAlignment = NSTextAlignmentCenter;
    contentLb;
  }));
}

-(UIVisualEffectView *)effectView {
  return JY_LAZY(_effectView, ({
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView;
  }));
}

-(UIVisualEffectView *)subEffectView {
  return JY_LAZY(_subEffectView, ({
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *subEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    subEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    subEffectView;
  }));
}


@end
