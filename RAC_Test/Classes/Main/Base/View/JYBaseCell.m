//
//  JYBaseCell.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import "JYBaseCell.h"

@implementation JYBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    for (UIView *view in self.subviews) {
      if ([view isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)view).delaysContentTouches = NO;
        break;;
      }
    }
  }
  self.backgroundColor = [UIColor clearColor];
  self.contentView.backgroundColor = [UIColor clearColor];
  self.backgroundView.backgroundColor = [UIColor clearColor];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  return self;
}


#pragma mark - BuilderSubviewsProtocol

- (void)buildSubviews {
  
}

- (void)handlerCommand:(id)data {
  
}


#pragma mark - JYReactiveViewDelegate

- (void)bindModel:(id)model {
  
}

- (void)bindModel:(id)model withParam:(NSDictionary *)params {
  
}

- (void)bindViewModel:(id)viewModel model:(id)model withParam:(NSDictionary *)params {
  
}

@end
